// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Mantle, AaveV3MantleAssets} from 'aave-address-book/AaveV3Mantle.sol';
import {IRiskSteward} from 'src/interfaces/IRiskSteward.sol';

/**
 * @title Aave V3.7 RiskSteward Update on Mantle
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3Mantle_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0xb5a1Fe36dcf5Ba149Cb8d90A03f4709141eE5442;

  function execute() external {
    AaveV3Mantle.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    AaveV3Mantle.ACL_MANAGER.removeRiskAdmin(AaveV3Mantle.RISK_STEWARD);

    IRiskSteward(NEW_RISK_STEWARD).setAddressRestricted(AaveV3MantleAssets.GHO_UNDERLYING, true);
  }
}
