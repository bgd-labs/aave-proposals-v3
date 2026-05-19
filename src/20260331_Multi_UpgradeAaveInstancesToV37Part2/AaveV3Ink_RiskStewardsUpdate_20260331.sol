// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';

/**
 * @title Aave V3.7 RiskSteward Update on Ink
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3Ink_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0xC1d38a1cdfb53Fce012A3A8CB42B64ddF60d4332;

  function execute() external {
    AaveV3InkWhitelabel.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    AaveV3InkWhitelabel.ACL_MANAGER.removeRiskAdmin(AaveV3InkWhitelabel.RISK_STEWARD);
  }
}
