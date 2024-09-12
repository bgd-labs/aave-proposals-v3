// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IBaseParaSwapAdapter} from './interfaces/IBaseParaSwapAdapter.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

/**
 * @title AddAdapterAsFlashBorrowerAndRevokePrevious
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/periphery-contracts-incident-august-28-2024/18821
 */
contract AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912 is
  IProposalGenericExecutor
{
  address public constant NEW_FLASH_BORROWER = 0x0000000000000000000000000000000000000001;

  function execute() external {
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.DAI_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.LINK_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.WBTC_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.WETH_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.USDT_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.wstETH_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.LUSD_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.ARB_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.weETH_UNDERLYING)
    );

    AaveV3Arbitrum.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);
    AaveV3Arbitrum.ACL_MANAGER.removeFlashBorrower(AaveV3Arbitrum.DEBT_SWAP_ADAPTER);
  }
}
