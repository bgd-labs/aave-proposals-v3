// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IStakeToken} from 'aave-helpers/lib/aave-address-book/src/common/IStakeToken.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';

/**
 * @title Reduce Safety Module Emissions
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xe76461b0936fc892904c1696066b9fa3688e1042078d9c9f06c1a937736a100e
 * - Discussion: https://governance.aave.com/t/arfc-safety-module-reduce-emissions/24203
 */
contract AaveV3Ethereum_ReduceSafetyModuleEmissions_20260224 is IProposalGenericExecutor {
  uint128 public constant STK_AAVE_EMISSION_PER_SECOND = uint128(uint256(220 ether) / 1 days);
  uint256 public constant STK_AAVE_COOLDOWN_SECONDS = 2 days;

  function execute() external override {
    IStakeToken.AssetConfigInput[] memory stkAAVEConfig = new IStakeToken.AssetConfigInput[](1);
    stkAAVEConfig[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: STK_AAVE_EMISSION_PER_SECOND,
      totalStaked: 0,
      underlyingAsset: AaveSafetyModule.STK_AAVE
    });

    IStakeToken(AaveSafetyModule.STK_AAVE).configureAssets(stkAAVEConfig);
    IStakeToken(AaveSafetyModule.STK_AAVE).setCooldownSeconds(STK_AAVE_COOLDOWN_SECONDS);

    IStakeToken.AssetConfigInput[] memory stkBPTConfig = new IStakeToken.AssetConfigInput[](1);
    stkBPTConfig[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: 0,
      totalStaked: 0,
      underlyingAsset: AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    });

    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).configureAssets(stkBPTConfig);
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).setCooldownSeconds(0);
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).setMaxSlashablePercentage(0);
  }
}
