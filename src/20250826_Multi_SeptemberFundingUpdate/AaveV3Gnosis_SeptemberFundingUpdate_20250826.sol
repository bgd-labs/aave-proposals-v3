// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {MiscGnosis} from 'aave-address-book/MiscGnosis.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title September Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-september-2025-funding-update/22915
 */
contract AaveV3Gnosis_SeptemberFundingUpdate_20250826 is IProposalGenericExecutor {
  uint256 public constant EURE_AMOUNT = 5_145 ether;

  function execute() external {
    AaveV3Gnosis.COLLECTOR.approve(
      IERC20(AaveV3GnosisAssets.EURe_A_TOKEN),
      MiscGnosis.MASIV_SAFE,
      EURE_AMOUNT
    );
  }
}
