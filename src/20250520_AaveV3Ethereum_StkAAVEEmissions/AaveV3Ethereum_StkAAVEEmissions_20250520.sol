// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title stkAAVE Emissions
 * @author @TokenLogic
 * - Snapshot: Direct-To-AIP
 * - Discussion: https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/26
 */
contract AaveV3Ethereum_StkAAVEEmissions_20250520 is IProposalGenericExecutor {
  uint256 public constant DISTRIBUTION_DURATION = 90 days;
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_AAVE = uint128(360 ether) / 1 days;
  uint256 public constant ALLOWANCE_MARGIN = 7200 ether;
  uint256 public constant TOTAL_ALLOWANCE =
    (DISTRIBUTION_DURATION * AAVE_EMISSION_PER_SECOND_STK_AAVE) + ALLOWANCE_MARGIN;

  function execute() external {
    // Approval needs to be reset in order to increase it
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_AAVE,
      0
    );

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveSafetyModule.STK_AAVE,
      TOTAL_ALLOWANCE
    );
  }
}
