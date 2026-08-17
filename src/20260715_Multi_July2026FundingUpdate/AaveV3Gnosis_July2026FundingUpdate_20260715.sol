// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {MiscGnosis} from 'aave-address-book/MiscGnosis.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title July 2026 Funding Update
 * @author TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x2f86020fc038694a5c4738e3982e4fa92eb315aaa4d3ce2fa2be2a5808a9280b
 * - Discussion: https://governance.aave.com/t/direct-to-aip-july-2026-funding-update/25277
 */
contract AaveV3Gnosis_July2026FundingUpdate_20260715 is IProposalGenericExecutor {
  function execute() external {
    AaveV3Gnosis.COLLECTOR.approve(
      IERC20(AaveV3GnosisAssets.EURe_A_TOKEN),
      MiscGnosis.MASIV_SAFE,
      0
    );
  }
}
