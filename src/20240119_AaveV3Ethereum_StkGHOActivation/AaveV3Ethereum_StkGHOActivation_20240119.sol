// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IStakeToken} from './IStakeToken.sol';

/**
 * @title StkGHO Activation
 * @author Aave Labs & ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4bc99a842adab6cdd8c7d5c7a787ee4c0056be554fde0d008d53b45b3e795065
 * - Discussion: https://governance.aave.com/t/arfc-upgrade-safety-module-with-stkgho/15635
 */
contract AaveV3Ethereum_StkGHOActivation_20240119 is IProposalGenericExecutor {
  uint128 public constant AAVE_EMISSION_PER_SECOND = uint128(50e18) / 1 days; // 50 AAVE per day
  uint256 public constant DISTRIBUTION_DURATION = 90 days; // 3 months

  function execute() external {
    // Configure distribution
    IStakeToken(AaveSafetyModule.STK_GHO).setDistributionEnd(
      block.timestamp + DISTRIBUTION_DURATION
    );
    IStakeToken.AssetConfigInput[] memory enableConfigs = new IStakeToken.AssetConfigInput[](1);
    enableConfigs[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: AAVE_EMISSION_PER_SECOND,
      totalStaked: 0, // it's overwritten internally
      underlyingAsset: AaveSafetyModule.STK_GHO
    });
    IStakeToken(AaveSafetyModule.STK_GHO).configureAssets(enableConfigs);

    // Allowance to pull funds from Ecosystem Reserve
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_GHO,
      AAVE_EMISSION_PER_SECOND * DISTRIBUTION_DURATION
    );
  }
}
