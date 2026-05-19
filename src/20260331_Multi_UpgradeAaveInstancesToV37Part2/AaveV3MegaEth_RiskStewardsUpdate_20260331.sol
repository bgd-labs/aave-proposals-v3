// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3MegaEth} from 'aave-address-book/AaveV3MegaEth.sol';

/**
 * @title Aave V3.7 RiskSteward Update on MegaEth
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3MegaEth_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0xb5a1Fe36dcf5Ba149Cb8d90A03f4709141eE5442;

  function execute() external {
    AaveV3MegaEth.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    AaveV3MegaEth.ACL_MANAGER.removeRiskAdmin(AaveV3MegaEth.RISK_STEWARD);
  }
}
