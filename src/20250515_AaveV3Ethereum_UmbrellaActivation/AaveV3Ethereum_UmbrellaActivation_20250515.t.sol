// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AccessControlUpgradeable} from 'openzeppelin-contracts-upgradeable/contracts/access/AccessControlUpgradeable.sol';

import {UmbrellaEthereum} from 'aave-address-book/UmbrellaEthereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {IDeficitOffsetClinicSteward} from 'aave-umbrella/stewards/interfaces/IDeficitOffsetClinicSteward.sol';

import {AaveV3Ethereum_UmbrellaActivation_20250515} from './AaveV3Ethereum_UmbrellaActivation_20250515.sol';

/**
 * @dev Test for AaveV3Ethereum_UmbrellaActivation_20250515
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250515_AaveV3Ethereum_UmbrellaActivation/AaveV3Ethereum_UmbrellaActivation_20250515.t.sol -vv
 */
contract AaveV3Ethereum_UmbrellaActivation_20250515_Test is ProtocolV3TestBase {
  AaveV3Ethereum_UmbrellaActivation_20250515 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22517759);
    proposal = new AaveV3Ethereum_UmbrellaActivation_20250515();
  }

  function test_reserveDeficitsElimination() public {
    uint256 currentReserveDeficitUSDC = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.USDC_UNDERLYING
    );
    assertGe(currentReserveDeficitUSDC, 168401963);

    uint256 currentReserveDeficitUSDT = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.USDT_UNDERLYING
    );
    assertGe(currentReserveDeficitUSDT, 197155140);

    uint256 currentReserveDeficitWETH = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.WETH_UNDERLYING
    );
    assertGe(currentReserveDeficitWETH, 42022976677445873);

    uint256 currentReserveDeficitGHO = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.GHO_UNDERLYING
    );
    assertGe(currentReserveDeficitGHO, 132211052243180416981);

    executePayload(vm, address(proposal));

    uint256 newReserveDeficitUSDC = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.USDC_UNDERLYING
    );
    assertLe(newReserveDeficitUSDC, 1); // aToken transfer precision loss

    uint256 newReserveDeficitUSDT = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.USDT_UNDERLYING
    );
    assertLe(newReserveDeficitUSDT, 1); // aToken transfer precision loss

    uint256 newReserveDeficitWETH = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.WETH_UNDERLYING
    );
    assertLe(newReserveDeficitWETH, 1); // aToken transfer precision loss

    uint256 newReserveDeficitGHO = AaveV3Ethereum.POOL.getReserveDeficit(
      AaveV3EthereumAssets.GHO_UNDERLYING
    );
    assertLe(newReserveDeficitGHO, 0);
  }

  function test_deficitOffsetClinicSteward() public {
    bool hasRole = AccessControlUpgradeable(address(UmbrellaEthereum.UMBRELLA)).hasRole(
      proposal.COVERAGE_MANAGER_ROLE(),
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    );

    assert(!hasRole);

    uint256 allowanceUsdcBefore = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(AaveV3EthereumAssets.USDC_UNDERLYING);
    uint256 allowanceUsdtBefore = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(AaveV3EthereumAssets.USDT_UNDERLYING);
    uint256 allowanceWethBefore = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(AaveV3EthereumAssets.WETH_UNDERLYING);
    uint256 allowanceGhoBefore = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(AaveV3EthereumAssets.GHO_UNDERLYING);

    assertEq(allowanceUsdcBefore, 0);
    assertEq(allowanceUsdtBefore, 0);
    assertEq(allowanceWethBefore, 0);
    assertEq(allowanceGhoBefore, 0);

    executePayload(vm, address(proposal));

    hasRole = AccessControlUpgradeable(address(UmbrellaEthereum.UMBRELLA)).hasRole(
      proposal.COVERAGE_MANAGER_ROLE(),
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    );

    assert(hasRole);

    uint256 allowanceUsdcAfter = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(AaveV3EthereumAssets.USDC_UNDERLYING);
    uint256 allowanceUsdtAfter = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(AaveV3EthereumAssets.USDT_UNDERLYING);
    uint256 allowanceWethAfter = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(AaveV3EthereumAssets.WETH_UNDERLYING);
    uint256 allowanceGhoAfter = IDeficitOffsetClinicSteward(
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    ).getRemainingAllowance(AaveV3EthereumAssets.GHO_UNDERLYING);

    assertEq(allowanceUsdcAfter, proposal.DEFICIT_OFFSET_USDC());
    assertEq(allowanceUsdtAfter, proposal.DEFICIT_OFFSET_USDT());
    assertEq(allowanceWethAfter, proposal.DEFICIT_OFFSET_WETH());
    assertEq(allowanceGhoAfter, proposal.DEFICIT_OFFSET_GHO());
  }
}
