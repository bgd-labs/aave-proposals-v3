// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';

/**
 * @title Safety Module stkAAVE - Re-enable Rewards
 * @author @karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/13
 */
contract AaveV3Ethereum_SafetyModuleStkAAVEReEnableRewards_20241106 is IProposalGenericExecutor {
  uint256 public constant DISTRIBUTION_DURATION = 180 days;
  uint128 public constant AAVE_EMISSION_PER_SECOND_STK_AAVE = uint128(360e18) / 1 days; // 360 AAVE per day

  function execute() external {
    uint256 remainingAllowance = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      address(MiscEthereum.ECOSYSTEM_RESERVE),
      AaveSafetyModule.STK_AAVE
    );

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
      remainingAllowance + (AAVE_EMISSION_PER_SECOND_STK_AAVE * DISTRIBUTION_DURATION)
    );
  }
}
