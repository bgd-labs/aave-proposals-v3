// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
/**
 * @title Merit Base Incentives and Superfest Matching
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x15cbc6b6c5b4ef76a1fb8cf8747460bf327c459fa01b69907fab0119457939a8
 * - Discussion: https://governance.aave.com/t/arfc-merit-base-incentives-and-superfest-matching/18450
 */
contract AaveV3Ethereum_MeritBaseIncentivesAndSuperfestMatching_20240812 is
  IProposalGenericExecutor
{
  address public constant ACI_MULTISIG = 0xac140648435d03f784879cd789130F22Ef588Fcd;
  uint256 public constant ALLOWANCE = 200_000e6;
  function execute() external {
    AaveV3Ethereum.COLLECTOR.approve(AaveV3EthereumAssets.USDC_UNDERLYING, ACI_MULTISIG, ALLOWANCE);
  }
}
