// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Celo} from 'aave-address-book/AaveV3Celo.sol';

/**
 * @title Aave V3.7 RiskSteward Update on Celo
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3Celo_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0xF73F2634b43344d86921DA3391d4EF0d5675Dd63;

  function execute() external {
    AaveV3Celo.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    AaveV3Celo.ACL_MANAGER.removeRiskAdmin(AaveV3Celo.RISK_STEWARD);
  }
}
