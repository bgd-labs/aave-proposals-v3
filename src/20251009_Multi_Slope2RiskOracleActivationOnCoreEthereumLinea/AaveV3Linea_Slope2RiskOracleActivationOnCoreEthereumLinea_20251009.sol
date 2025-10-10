// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Linea} from 'aave-address-book/AaveV3Linea.sol';

/**
 * @title Slope2 Risk Oracle Activation On Core Ethereum, Linea
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/chaos-labs-risk-stewards-slope2-parameter-adjustments-for-risk-oracle-deployment/23192
 */
contract AaveV3Linea_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009 is
  IProposalGenericExecutor
{
  address public constant EDGE_RISK_STEWARDS_RATES = 0xdDE20B20E21a6F3b7080e740b684CDf5b764B80D;

  function execute() external {
    AaveV3Linea.ACL_MANAGER.addRiskAdmin(EDGE_RISK_STEWARDS_RATES);
  }
}
