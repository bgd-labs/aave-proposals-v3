// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

/**
 * @title Caps Risk Oracle Activation on Optimism, BNB, Gnosis, Polygon
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/arfc-supply-and-borrow-cap-risk-oracle-activation/20834
 */
contract AaveV3Gnosis_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722 is
  IProposalGenericExecutor
{
  address public constant EDGE_RISK_STEWARD = 0x655252250f4A453854040A49E8280951A76f3033;

  function execute() external {
    AaveV3Gnosis.ACL_MANAGER.addRiskAdmin(EDGE_RISK_STEWARD);
    // automation for robot is done using gelato automation on gnosis
  }
}
