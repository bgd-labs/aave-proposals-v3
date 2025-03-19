// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Finance Steward Deployment: Pool Exposure Module
 * @author @TokenLogic
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319 is
  IProposalGenericExecutor
{
  function execute() external {
    IAccessControl(address(AaveV3Ethereum.COLLECTOR)).grantRole(
      'FUNDS_ADMIN',
      AaveV3Ethereum.POOL_EXPOSURE_STEWARD
    );
  }
}
