// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';

/**
 * @title Security Budget Request Dec 23 and Robot Refill
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xf95bc210e3e93c2112c694cb158db22c93504155b48c03d9358e4c41c33ee782
 * - Discussion: https://governance.aave.com/t/arfc-bgd-security-budget-request-december-2023/15783
 */
contract AaveV3Polygon_SecurityBudgetRequestDec23AndRobotRefill_20240411 is
  IProposalGenericExecutor
{
  uint256 public constant WMATIC_AMOUNT_REIMBURSEMENT = 3500 ether;
  uint256 public constant A_WMATIC_AMOUNT_REIMBURSEMENT = 500 ether;
  address public constant BGD_RECIPIENT = 0xbCEB4f363f2666E2E8E430806F37e97C405c130b;

  function execute() external {
    AaveV2Polygon.COLLECTOR.transfer(
      AaveV2PolygonAssets.WMATIC_UNDERLYING,
      BGD_RECIPIENT,
      WMATIC_AMOUNT_REIMBURSEMENT
    );
    AaveV2Polygon.COLLECTOR.transfer(
      AaveV2PolygonAssets.WMATIC_A_TOKEN,
      BGD_RECIPIENT,
      A_WMATIC_AMOUNT_REIMBURSEMENT
    );
  }
}
