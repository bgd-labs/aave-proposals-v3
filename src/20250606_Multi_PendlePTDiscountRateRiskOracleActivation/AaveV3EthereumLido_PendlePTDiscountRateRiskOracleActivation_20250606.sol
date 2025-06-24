// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';

import {IRiskSteward} from './interfaces/IRiskSteward.sol';

/**
 * @title Discount Rate Risk Oracle Activation and update manual AGRS
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/93
 */
contract AaveV3EthereumLido_PendlePTDiscountRateRiskOracleActivation_20250606 is
  IProposalGenericExecutor
{
  address public constant NEW_RISK_STEWARD = 0x7e6a6B115D31d4A837E3C737c49Cf6Fafe6112C3;

  function execute() external {
    AaveV3EthereumLido.ACL_MANAGER.removeRiskAdmin(AaveV3EthereumLido.RISK_STEWARD);
    AaveV3EthereumLido.ACL_MANAGER.removeRiskAdmin(AaveV3EthereumLido.CAPS_PLUS_RISK_STEWARD);

    AaveV3EthereumLido.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    IRiskSteward(NEW_RISK_STEWARD).setAddressRestricted(
      AaveV3EthereumLidoAssets.GHO_UNDERLYING,
      true
    );
  }
}
