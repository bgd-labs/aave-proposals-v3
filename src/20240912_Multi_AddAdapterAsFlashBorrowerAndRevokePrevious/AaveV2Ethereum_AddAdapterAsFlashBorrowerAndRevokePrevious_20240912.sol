// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IBaseParaSwapAdapter} from './interfaces/IBaseParaSwapAdapter.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

/**
 * @title AddAdapterAsFlashBorrowerAndRevokePrevious
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/periphery-contracts-incident-august-28-2024/18821
 */
contract AaveV2Ethereum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912 is
  IProposalGenericExecutor
{
  address public constant NEW_FLASH_BORROWER = 0x0000000000000000000000000000000000000001;

  function execute() external {
    IBaseParaSwapAdapter(AaveV2Ethereum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV2Ethereum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV2Ethereum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV2EthereumAssets.DAI_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV2Ethereum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV2EthereumAssets.USDT_UNDERLYING)
    );
  }
}
