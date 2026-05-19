// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';

/**
 * @title Aave V3.7 RiskSteward Update on BNB
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3BNB_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0x42ca9E62C9B61d01Bb222d6E69f095eE98e61cE8;

  function execute() external {
    AaveV3BNB.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    AaveV3BNB.ACL_MANAGER.removeRiskAdmin(AaveV3BNB.RISK_STEWARD);
  }
}
