// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IStakeToken} from 'aave-helpers/lib/aave-address-book/src/common/IStakeToken.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';

/**
 * @title stkAAVE Emissions Update
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xd416e6cb09416cc4effdd2ad869373db2ac005ea63e7d7baeec0db4934281352
 * - Discussion: https://governance.aave.com/t/arfc-stkaave-emissions-update/24945
 */
contract AaveV3Ethereum_StkAAVEEmissionsUpdate_20260522 is IProposalGenericExecutor {
  uint128 public constant STK_AAVE_EMISSION_PER_SECOND = uint128(uint256(150 ether) / 1 days);

  function execute() external override {
    IStakeToken.AssetConfigInput[] memory stkAAVEConfig = new IStakeToken.AssetConfigInput[](1);
    stkAAVEConfig[0] = IStakeToken.AssetConfigInput({
      emissionPerSecond: STK_AAVE_EMISSION_PER_SECOND,
      totalStaked: 0,
      underlyingAsset: AaveSafetyModule.STK_AAVE
    });

    IStakeToken(AaveSafetyModule.STK_AAVE).configureAssets(stkAAVEConfig);
  }
}
