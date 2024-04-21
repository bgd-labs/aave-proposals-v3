// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
/**
 * @title April Finance Update
 * @author @karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-april-finance-update/17390
 */
contract AaveV3Gnosis_AprilFinanceUpdate_20240421 is IProposalGenericExecutor {
  address public constant REAL_T = 0x7DA9A33d15413F499299687cC9d81DE84684E28E;
  uint256 public constant TO_TRANSFER = 3_504 ether;

  function execute() external {
    AaveV3Gnosis.COLLECTOR.transfer(AaveV3GnosisAssets.WXDAI_A_TOKEN, REAL_T, TO_TRANSFER);
  }
}
