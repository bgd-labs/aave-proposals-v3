// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Treasury Management - GSM Funding & RWA Strategy Preparations (Part 1)
 * @author efecarranza.eth
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV2Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229 is
  IProposalGenericExecutor
{
  address public constant TO_REVOKE_ONE = 0x04f90d449D4f8316eDd6Ef4F963b657f8444a4cA;
  address public constant TO_REVOKE_TWO = 0x46A1B7d4a2920270c7eB2C2Db4DF2259A109bcb4;

  function execute() external {
    AaveV2Ethereum.COLLECTOR.approve(AaveV2EthereumAssets.USDC_A_TOKEN, TO_REVOKE_ONE, 0);
    AaveV2Ethereum.COLLECTOR.approve(AaveV2EthereumAssets.USDC_A_TOKEN, TO_REVOKE_TWO, 0);
  }
}
