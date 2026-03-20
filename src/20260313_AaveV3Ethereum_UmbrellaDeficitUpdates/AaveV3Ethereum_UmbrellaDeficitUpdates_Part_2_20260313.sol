// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import {UmbrellaBasePayload} from 'aave-umbrella/payloads/UmbrellaBasePayload.sol';
import {IUmbrellaEngineStructs as IStructs} from 'aave-umbrella/payloads/IUmbrellaEngineStructs.sol';

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {UmbrellaEthereum} from 'aave-address-book/UmbrellaEthereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title UmbrellaDeficitUpdates_Part_2
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xfcd429c8fcb5fc44a0bea9bf078726ef48b1c76ca1039a8c6c9dff23f4547e30
 * - Discussion: https://governance.aave.com/t/arfc-revenue-indexed-deficit-offsets-for-umbrella/24000
 */
contract AaveV3Ethereum_UmbrellaDeficitUpdates_Part_2_20260313 is UmbrellaBasePayload {
  uint256 public constant CRV_DEFICIT_ELIMINATION_CAP = 394_500 * 1e18;
  uint256 public constant ENS_DEFICIT_ELIMINATION_CAP = 5_769 * 1e18;

  constructor() UmbrellaBasePayload(UmbrellaEthereum.UMBRELLA_CONFIG_ENGINE) {}

  function _preExecute() internal override {
    uint256 crvDeficit = _getDeficitEliminationAmount(
      AaveV3EthereumAssets.CRV_UNDERLYING,
      CRV_DEFICIT_ELIMINATION_CAP
    );
    uint256 ensDeficit = _getDeficitEliminationAmount(
      AaveV3EthereumAssets.ENS_UNDERLYING,
      ENS_DEFICIT_ELIMINATION_CAP
    );

    // Transfer aTokens for reserve deficit elimination
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.CRV_A_TOKEN),
      address(this),
      crvDeficit
    );
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.ENS_A_TOKEN),
      address(this),
      ensDeficit
    );
  }

  function coverReserveDeficit() public view override returns (IStructs.CoverDeficit[] memory) {
    // Cover deficits that don't have slashing configs (Curve, Ens)
    IStructs.CoverDeficit[] memory coverReserveDeficits = new IStructs.CoverDeficit[](2);

    coverReserveDeficits[0] = IStructs.CoverDeficit({
      reserve: AaveV3EthereumAssets.CRV_UNDERLYING,
      amount: _getDeficitEliminationAmount(
        AaveV3EthereumAssets.CRV_UNDERLYING,
        CRV_DEFICIT_ELIMINATION_CAP
      ),
      approve: true
    });

    coverReserveDeficits[1] = IStructs.CoverDeficit({
      reserve: AaveV3EthereumAssets.ENS_UNDERLYING,
      amount: _getDeficitEliminationAmount(
        AaveV3EthereumAssets.ENS_UNDERLYING,
        ENS_DEFICIT_ELIMINATION_CAP
      ),
      approve: true
    });

    return coverReserveDeficits;
  }

  function _getDeficitEliminationAmount(
    address reserve,
    uint256 cap
  ) internal view returns (uint256) {
    uint256 deficit = AaveV3Ethereum.POOL.getReserveDeficit(reserve);
    return deficit < cap ? deficit : cap;
  }
}
