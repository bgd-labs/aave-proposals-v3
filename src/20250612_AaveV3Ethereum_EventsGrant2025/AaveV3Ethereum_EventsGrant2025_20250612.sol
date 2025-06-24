// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

/**
 * @title EventsGrant2025
 * @author Aave Labs
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x12ae50ccd9a4cd8edfead63d773e62ca23ea567a458c442557e0b6193e01bb1d
 * - Discussion: https://governance.aave.com/t/arfc-aave-events-sponsorship-budget-2025/22173
 */
contract AaveV3Ethereum_EventsGrant2025_20250612 is IProposalGenericExecutor {
  address public constant AAVE_LABS = 0x1c037b3C22240048807cC9d7111be5d455F640bd;
  uint256 public constant GHO_GRANT_AMOUNT = 750_000 ether;
  IERC20 public constant GHO_TOKEN = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING);

  function execute() external {
    AaveV3Ethereum.COLLECTOR.transfer(GHO_TOKEN, AAVE_LABS, GHO_GRANT_AMOUNT);
  }
}
