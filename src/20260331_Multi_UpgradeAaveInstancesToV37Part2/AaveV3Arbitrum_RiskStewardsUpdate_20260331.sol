// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IRiskSteward} from 'src/interfaces/IRiskSteward.sol';

/**
 * @title Aave V3.7 RiskSteward Update on Arbitrum
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3Arbitrum_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0xC5762E5A5c12886D4F6768549A9C605823d029E9;

  function execute() external {
    AaveV3Arbitrum.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    AaveV3Arbitrum.ACL_MANAGER.removeRiskAdmin(AaveV3Arbitrum.RISK_STEWARD);

    IRiskSteward(NEW_RISK_STEWARD).setAddressRestricted(AaveV3ArbitrumAssets.GHO_UNDERLYING, true);
  }
}
