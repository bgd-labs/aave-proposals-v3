// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {UmbrellaEthereum} from 'aave-address-book/UmbrellaEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {UmbrellaExtendedPayload} from 'aave-umbrella/payloads/UmbrellaExtendedPayload.sol';

import {IUmbrellaEngineStructs as IStructs} from 'aave-umbrella/payloads/UmbrellaExtendedPayload.sol';
import {IUmbrellaStkManager as ISMStructs, IUmbrellaConfiguration as ICStructs} from 'aave-umbrella/payloads/UmbrellaExtendedPayload.sol';

import {AccessControlUpgradeable} from '@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol';

/**
 * @title UmbrellaActivation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/arfc-aave-umbrella-activation/21521
 */
contract AaveV3Ethereum_UmbrellaActivation_20250515 is UmbrellaExtendedPayload {
  uint256 public constant DEFICIT_OFFSET_USDC = 100_000 * 1e6;
  uint256 public constant DEFICIT_OFFSET_USDT = 100_000 * 1e6;
  uint256 public constant DEFICIT_OFFSET_WETH = 50 * 1e18;
  uint256 public constant DEFICIT_OFFSET_GHO = 100_000 * 1e18;

  bytes32 public constant REWARDS_ADMIN_ROLE = keccak256('REWARDS_ADMIN_ROLE');
  bytes32 public constant COVERAGE_MANAGER_ROLE = keccak256('COVERAGE_MANAGER_ROLE');

  bytes32 public constant UMBRELLA = 'UMBRELLA';

  function _preExecute() public override {
    // Give `UMBRELLA` to the `Umbrella` contract, so `Umbrella` could start eliminating deficit for this `POOL`
    AaveV3Ethereum.ADDRESSES_PROVIDER.setAddress(UMBRELLA, address(UmbrellaEthereum.Umbrella));

    // Cache current reserve deficit amounts
    /////////////////////////////////////////////////////////////////////////////////////////

    uint256 currentReserveDeficitToCoverUSDC = AaveV3Ethereum.Pool.getReserveDeficit(
      AaveV3EthereumAssets.USDC_UNDERLYING
    );

    uint256 currentReserveDeficitToCoverUSDT = AaveV3Ethereum.Pool.getReserveDeficit(
      AaveV3EthereumAssets.USDT_UNDERLYING
    );

    uint256 currentReserveDeficitToCoverWETH = AaveV3Ethereum.Pool.getReserveDeficit(
      AaveV3EthereumAssets.WETH_UNDERLYING
    );

    uint256 currentReserveDeficitToCoverGHO = AaveV3Ethereum.Pool.getReserveDeficit(
      AaveV3EthereumAssets.GHO_UNDERLYING
    );

    // Transfer current reserve deficit amounts to this address, so it could be used to eliminate `ReserveDeficit` later
    // +1 to avoid precision error with aToken tranfers
    /////////////////////////////////////////////////////////////////////////////////////////

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDC_A_TOKEN,
      address(this),
      currentReserveDeficitToCoverUSDC + 1
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDT_A_TOKEN,
      address(this),
      currentReserveDeficitToCoverUSDT + 1
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.WETH_A_TOKEN,
      address(this),
      currentReserveDeficitToCoverWETH + 1
    );

    // should be executed before v3.4 or `GHO_UNDERLYING` should be replaced with `GHO_A_TOKEN`
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      address(this),
      currentReserveDeficitToCoverGHO
    );
  }

  function coverReserveDeficit() public override returns (IStructs.CoverDeficit[] memory) {
    // Will eliminate reserve deficit before configuring anything, using funds, that were transferred during `_preExecute` phase
    IStructs.CoverDeficit[] memory coverReserveDeficit = new IStructs.CoverDeficit[](4);

    coverReserveDeficit[0] = CoverDeficit({
      reserve: AaveV3EthereumAssets.USDC_UNDERLYING,
      amount: AaveV3Ethereum.Pool.getReserveDeficit(AaveV3EthereumAssets.USDC_UNDERLYING),
      approve: true
    });

    coverReserveDeficit[1] = CoverDeficit({
      reserve: AaveV3EthereumAssets.USDT_UNDERLYING,
      amount: AaveV3Ethereum.Pool.getReserveDeficit(AaveV3EthereumAssets.USDT_UNDERLYING),
      approve: true
    });

    coverReserveDeficit[2] = CoverDeficit({
      reserve: AaveV3EthereumAssets.WETH_UNDERLYING,
      amount: AaveV3Ethereum.Pool.getReserveDeficit(AaveV3EthereumAssets.WETH_UNDERLYING),
      approve: true
    });

    coverReserveDeficit[3] = CoverDeficit({
      reserve: AaveV3EthereumAssets.GHO_UNDERLYING,
      amount: AaveV3Ethereum.Pool.getReserveDeficit(AaveV3EthereumAssets.GHO_UNDERLYING),
      approve: true
    });

    return coverReserveDeficit;
  }

  function _postExecute() public override {
    // Give roles
    /////////////////////////////////////////////////////////////////////////////////////////

    // Give role to limited reward updates inside `RewardsController` for `FinancialCommittee`
    // `FinancialCommittee` is the payload manager inside `PERMISSIONED_PAYLOADS_CONTROLLER`
    AccessControlUpgradeable(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER).grantRole(
      REWARDS_ADMIN_ROLE,
      GovernanceV3Ethereum.PERMISSIONED_PAYLOADS_CONTROLLER_EXECUTOR
    );

    // Give role to cover deficit offset for `FinancialCommittee`
    // `FinancialCommittee` has the `FINANCE_COMMITTEE_ROLE` role inside `DeficitOffsetClinicSteward`
    AccessControlUpgradeable(address(UmbrellaEthereum.UMBRELLA)).grantRole(
      COVERAGE_MANAGER_ROLE,
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD
    );

    // Give allowance to `DeficitOffsetClinitSteward`
    // So `deficitOffset` could be closed using `Collector` funds
    /////////////////////////////////////////////////////////////////////////////////////////

    AaveV3Ethereum.COLLECTOR.approve(
      AaveV3EthereumAssets.USDC_A_TOKEN,
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD,
      DEFICIT_OFFSET_USDC
    );

    AaveV3Ethereum.COLLECTOR.approve(
      AaveV3EthereumAssets.USDT_A_TOKEN,
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD,
      DEFICIT_OFFSET_USDT
    );

    AaveV3Ethereum.COLLECTOR.approve(
      AaveV3EthereumAssets.WETH_A_TOKEN,
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD,
      DEFICIT_OFFSET_WETH
    );

    AaveV3Ethereum.COLLECTOR.approve(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      UmbrellaEthereum.DEFICIT_OFFSET_CLINIC_STEWARD,
      DEFICIT_OFFSET_GHO
    );
  }
}
