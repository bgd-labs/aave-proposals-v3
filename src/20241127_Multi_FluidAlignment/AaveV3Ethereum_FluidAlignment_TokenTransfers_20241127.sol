// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
/**
 * @title Fluid Alignment
 * @author ACI
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/arfc-fluid-alignment-with-inst-purchase/19921
 */
contract AaveV3Ethereum_FluidAlignment_TokenTransfers_20241127 is IProposalGenericExecutor {
  address public constant INST_TOKEN = 0x6f40d4A6237C257fff2dB00FA0510DeEECd303eb;

  address public INSTADAPP_TREASURY = 0x28849D2b63fA8D361e5fc15cB8aBB13019884d09;

  uint256 public constant INST_AMOUNT = 1.145 * 10 ** 6 ether; // 1.145M

  uint256 public constant GHO_AMOUNT = 4 * 10 ** 6 ether; // 4M

  function execute() external {
    // Pull INST to collector
    IERC20(INST_TOKEN).transferFrom(INSTADAPP_TREASURY, AaveV3Ethereum.COLLECTOR, INST_AMOUNT);

    // Send GHO to Instadapp Treasury
    AaveV3Avalanche.COLLECTOR.transfer(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      INSTADAPP_TREASURY,
      GHO_AMOUNT
    );
  }
}
