// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';

/**
 * @title Manual Risk Stewards Activation
 * @author BGD Labs (@bgdlabs)
 */
contract AaveV3InkWhitelabel_ManualRiskStewardsActivation_20260119 is IProposalGenericExecutor {
  address public constant RISK_STEWARD = 0x2F9fDD0D80843b21A7e2c7bfe2A6278231A5683e;

  function execute() external {
    AaveV3InkWhitelabel.ACL_MANAGER.addRiskAdmin(RISK_STEWARD);
  }
}
