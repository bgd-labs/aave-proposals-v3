// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';

/**
 * @title Manual Risk Stewards Activation
 * @author BGD Labs (@bgdlabs)
 */
contract AaveV3InkWhitelabel_ManualRiskStewardsActivation_20260119 is IProposalGenericExecutor {
  address public constant RISK_STEWARD = 0x69a6CaF240698982c3Ac89E0A7C12E76bCEee4ef;

  function execute() external {
    AaveV3InkWhitelabel.ACL_MANAGER.addRiskAdmin(RISK_STEWARD);
  }
}
