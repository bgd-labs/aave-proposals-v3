// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Sonic} from 'aave-address-book/AaveV3Sonic.sol';

/**
 * @title Aave V3.7 RiskSteward Update on Sonic
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3Sonic_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0xb9898C9F4711cBCaD882863302EF8300bFc9d6Dc;

  function execute() external {
    AaveV3Sonic.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    AaveV3Sonic.ACL_MANAGER.removeRiskAdmin(AaveV3Sonic.RISK_STEWARD);
  }
}
