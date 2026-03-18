// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title wstETH CAPO Oracle Incident User Reimbursement
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-wsteth-capo-oracle-incident-user-reimbursement/24275?u=tokenlogic
 */
contract AaveV3Ethereum_WstETHCAPOOracleIncidentUserReimbursement_20260312 is
  IProposalGenericExecutor
{
  uint256 public constant WETH_REIMBURSEMENT = 513.19 ether;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.WETH_UNDERLYING),
      MiscEthereum.AFC_SAFE,
      WETH_REIMBURSEMENT
    );
  }
}
