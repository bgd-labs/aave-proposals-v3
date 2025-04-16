// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV3Linea} from 'aave-address-book/AaveV3Linea.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {DustBinSender} from './DustBinSender.sol';

/**
 * @title Finance Steward Deployment: Pool Exposure Module
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x1730ba3a2dd1f7b0b00cfae01b0c9f1bb7494b848c5de517275e2c72cf8c7b4d
 * - Discussion: https://governance.aave.com/t/arfc-aave-finance-steward-deployment/21495
 */
contract AaveV3Linea_FinanceStewardDeploymentPoolExposureModule_20250319 is
  IProposalGenericExecutor,
  DustBinSender
{
  function execute() external {
    send(
      AaveV3Linea.POOL,
      AaveV3Linea.COLLECTOR,
      address(AaveV3Linea.ORACLE),
      AaveV3Linea.DUST_BIN
    );

    IAccessControl(address(AaveV3Linea.COLLECTOR)).grantRole(
      'FUNDS_ADMIN',
      AaveV3Linea.POOL_EXPOSURE_STEWARD
    );
  }
}
