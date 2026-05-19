// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';

/**
 * @title Aave V3.7 RiskSteward Update on Scroll
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3Scroll_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0xc524A770ae73e57F0295aA48fd7605927a628B3b;

  function execute() external {
    AaveV3Scroll.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    AaveV3Scroll.ACL_MANAGER.removeRiskAdmin(AaveV3Scroll.RISK_STEWARD);
  }
}
