// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

/**
 * @title Caps Risk Oracle Activation on Optimism, BNB, Gnosis, Polygon
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/98
 */
contract AaveV3Gnosis_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722 is
  IProposalGenericExecutor
{
  address public constant EDGE_RISK_STEWARD = 0x655252250f4A453854040A49E8280951A76f3033;

  function execute() external {
    AaveV3Gnosis.ACL_MANAGER.addRiskAdmin(EDGE_RISK_STEWARD);

    // automation for injector robot is registered using gelato automation on gnosis:
    // https://app.gelato.network/functions/task/0x56ecbbb1cd925f1b5a06d615718035d64d59328019fca1fba63b0afab507e979:100
  }
}
