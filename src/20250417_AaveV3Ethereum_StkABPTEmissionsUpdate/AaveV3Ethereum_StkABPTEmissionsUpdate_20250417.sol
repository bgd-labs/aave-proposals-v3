// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {IStakeToken} from './IStakeToken.sol';

/**
 * @title stkABPT - Emissions Update
 * @author TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x8dbeee9b489266cfefb8cb3c75fb0791d364975eed48cee951ff04fd17ee57c1
 * - Discussion: https://governance.aave.com/t/arfc-stkabpt-emissions-update/21683
 */
contract AaveV3Ethereum_StkABPTEmissionsUpdate_20250417 is IProposalGenericExecutor {
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_ABPT = uint128(240e18) / 1 days; // 360 AAVE per day

  function execute() external {
    IStakeToken.AssetConfigInput[] memory abptConfigs = new IStakeToken.AssetConfigInput[](1);
    abptConfigs[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: AAVE_EMISSION_PER_SECOND_STK_ABPT,
      totalStaked: 0, // it's overwritten internally
      underlyingAsset: AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    });
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).configureAssets(abptConfigs);
  }
}
