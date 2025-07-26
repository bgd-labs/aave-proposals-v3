// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {MiscGnosis} from 'aave-address-book/MiscGnosis.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title July 2025 - Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-july-2025-funding-update/22555
 */
contract AaveV3Gnosis_July2025FundingUpdate_20250721 is IProposalGenericExecutor {
  uint256 public constant EURE_AMOUNT = 6_000e18;

  function execute() external {
    AaveV3Gnosis.COLLECTOR.approve(
      IERC20(AaveV3GnosisAssets.EURe_A_TOKEN),
      MiscGnosis.MASIV_SAFE,
      EURE_AMOUNT
    );
  }
}
