// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Add Fluid Protocol to flashBorrowers
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x5e13f3e63fd9a2d4d00ff9f7915644e48d4b8b35fe03b52a599b4bc1c95914d0
 * - Discussion: https://governance.aave.com/t/arfc-add-fluid-protocol-to-flashborrowers/23007
 */
contract AaveV3Polygon_AddFluidProtocolToFlashBorrowers_20250903 is IProposalGenericExecutor {
  address public constant FLUID_PROTOCOL = 0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7;

  function execute() external {
    AaveV3Polygon.ACL_MANAGER.addFlashBorrower(FLUID_PROTOCOL);
  }
}
