// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IStakeToken} from 'aave-helpers/lib/aave-address-book/src/common/IStakeToken.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';

/**
 * @title Umbrella Emission Update
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/
 */
contract AaveV3Ethereum_EmissionUpdate_20251219 is IProposalGenericExecutor {
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_BPT = uint128(40 ether) / 1 days;

  function execute() external override {
    IStakeToken.AssetConfigInput[] memory config = new IStakeToken.AssetConfigInput[](1);
    config[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: AAVE_EMISSION_PER_SECOND_STK_BPT,
      totalStaked: 0,
      underlyingAsset: AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    });

    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).configureAssets(config);
  }
}
