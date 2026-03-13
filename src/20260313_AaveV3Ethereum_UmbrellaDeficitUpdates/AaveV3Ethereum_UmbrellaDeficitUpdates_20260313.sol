// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';

import {UmbrellaBasePayload} from 'aave-umbrella/payloads/UmbrellaBasePayload.sol';

import {IUmbrellaEngineStructs as IStructs} from 'aave-umbrella/payloads/IUmbrellaEngineStructs.sol';

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {UmbrellaEthereum} from 'aave-address-book/UmbrellaEthereum.sol';

/**
 * @title UmbrellaDeficitUpdates
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xfcd429c8fcb5fc44a0bea9bf078726ef48b1c76ca1039a8c6c9dff23f4547e30
 * - Discussion: https://governance.aave.com/t/arfc-revenue-indexed-deficit-offsets-for-umbrella/24000
 */
contract AaveV3Ethereum_UmbrellaDeficitUpdates_20260313 is UmbrellaBasePayload {
  uint256 public constant USDT_DEFICIT_OFFSET = 1_600_000 * 1e6;
  uint256 public constant USDC_DEFICIT_OFFSET = 1_300_000 * 1e6;
  uint256 public constant WETH_DEFICIT_OFFSET = 77 * 1e18;
  uint256 public constant GHO_DEFICIT_OFFSET = 115_000 * 1e18;

  bytes32 public constant COVERAGE_MANAGER_ROLE = keccak256('COVERAGE_MANAGER_ROLE');

  constructor() UmbrellaBasePayload(UmbrellaEthereum.UMBRELLA_CONFIG_ENGINE) {}

  function _preExecute() internal override {
    // Move funds from collector for the deficit coverage during `coverDeficitOffset()`
    uint256 amountOfAUsdt = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.USDT_UNDERLYING
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN),
      address(this),
      amountOfAUsdt
    );

    uint256 amountOfAUsdc = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.USDC_UNDERLYING
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN),
      address(this),
      amountOfAUsdc
    );

    uint256 amountOfAWeth = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.WETH_UNDERLYING
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN),
      address(this),
      amountOfAWeth
    );
  }

  function setDeficitOffset() public view override returns (IStructs.SetDeficitOffset[] memory) {
    IStructs.SetDeficitOffset[] memory newDeficitOffsets = new IStructs.SetDeficitOffset[](4);

    // Due to the fact, that engine firstly sets deficit and then covers it,
    // we need to set deficit including funds that will be used for coverage

    uint256 usdtDeficitOffset = USDT_DEFICIT_OFFSET +
      AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.USDT_UNDERLYING);

    newDeficitOffsets[0] = IStructs.SetDeficitOffset({
      reserve: AaveV3EthereumAssets.USDT_UNDERLYING,
      newDeficitOffset: usdtDeficitOffset
    });

    uint256 usdcDeficitOffset = USDC_DEFICIT_OFFSET +
      AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.USDC_UNDERLYING);

    newDeficitOffsets[1] = IStructs.SetDeficitOffset({
      reserve: AaveV3EthereumAssets.USDC_UNDERLYING,
      newDeficitOffset: usdcDeficitOffset
    });

    uint256 wethDeficitOffset = WETH_DEFICIT_OFFSET +
      AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.WETH_UNDERLYING);

    newDeficitOffsets[2] = IStructs.SetDeficitOffset({
      reserve: AaveV3EthereumAssets.WETH_UNDERLYING,
      newDeficitOffset: wethDeficitOffset
    });

    // There's no coverage proposed for Gho, so just increase deficitOffset
    newDeficitOffsets[3] = IStructs.SetDeficitOffset({
      reserve: AaveV3EthereumAssets.GHO_UNDERLYING,
      newDeficitOffset: GHO_DEFICIT_OFFSET
    });

    return newDeficitOffsets;
  }

  function coverDeficitOffset() public view override returns (IStructs.CoverDeficit[] memory) {
    // Cover deficits that don't have slashing configs (Curve, Ens)
    IStructs.CoverDeficit[] memory coverReserveDeficits = new IStructs.CoverDeficit[](3);

    coverReserveDeficits[0] = IStructs.CoverDeficit({
      reserve: AaveV3EthereumAssets.USDT_UNDERLYING,
      amount: AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.USDT_UNDERLYING),
      approve: true
    });

    coverReserveDeficits[1] = IStructs.CoverDeficit({
      reserve: AaveV3EthereumAssets.USDC_UNDERLYING,
      amount: AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.USDC_UNDERLYING),
      approve: true
    });

    coverReserveDeficits[2] = IStructs.CoverDeficit({
      reserve: AaveV3EthereumAssets.WETH_UNDERLYING,
      amount: AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.WETH_UNDERLYING),
      approve: true
    });

    return coverReserveDeficits;
  }

  function _postExecute() internal override {
    // Give an ability to cover reserve deficits to financialCommittee via PERMISSIONED_PAYLOADS_CONTROLLER
    // So, they can cover reserve deficits, that don't have slashing configs (Crv, Ens)
    IAccessControl(address(UmbrellaEthereum.UMBRELLA)).grantRole(
      COVERAGE_MANAGER_ROLE,
      UmbrellaEthereum.PERMISSIONED_PAYLOADS_CONTROLLER_EXECUTOR
    );
  }
}
