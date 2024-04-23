// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
/**
 * @title April Finance Update
 * @author @karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-april-finance-update/17390
 */
contract AaveV3Gnosis_AprilFinanceUpdate_20240421 is IProposalGenericExecutor {
  address public constant REAL_T = 0x7DA9A33d15413F499299687cC9d81DE84684E28E;
  address public constant armmv3WXDAI = 0x0cA4f5554Dd9Da6217d62D8df2816c82bba4157b;

  uint256 public constant TO_TRANSFER = 3_504 ether;

  function execute() external {
    AaveV3Gnosis.COLLECTOR.transfer(armmv3WXDAI, REAL_T, TO_TRANSFER);
  }
}
