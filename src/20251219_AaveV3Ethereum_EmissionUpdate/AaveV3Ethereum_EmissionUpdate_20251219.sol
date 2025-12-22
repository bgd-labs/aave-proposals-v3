// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IStakeToken} from 'aave-helpers/lib/aave-address-book/src/common/IStakeToken.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @title stkABPT Emission Update
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x6712b1677068d2d316af699757057a0c8c03e0ff0693c12aacc381d294c419a4
 * - Discussion: https://governance.aave.com/t/arfc-safety-module-umbrella-emission-update/23103/9
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

    uint256 distributionEnd = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).distributionEnd();
    uint256 updatedAllowance = uint256(AAVE_EMISSION_PER_SECOND_STK_BPT) *
      (distributionEnd - block.timestamp);

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2,
      0
    );

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2,
      updatedAllowance
    );
  }
}
