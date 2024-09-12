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
      IERC20(AaveV3ArbitrumAssets.DAI_A_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.DAI_STATA_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.LINK_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.LINK_A_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.LINK_STATA_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.USDC_A_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.USDC_STATA_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.WBTC_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.WBTC_A_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.WBTC_STATA_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.WETH_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.WETH_A_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.WETH_STATA_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.USDT_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.USDT_A_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.USDT_STATA_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.AAVE_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.AAVE_A_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.AAVE_STATA_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.EURS_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.EURS_A_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.EURS_STATA_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.wstETH_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.wstETH_A_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.wstETH_STATA_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.MAI_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.MAI_A_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.MAI_STATA_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.rETH_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.rETH_A_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.rETH_STATA_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.LUSD_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.LUSD_A_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.LUSD_STATA_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.USDCn_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.USDCn_A_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.USDCn_STATA_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.FRAX_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.FRAX_A_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.FRAX_STATA_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.ARB_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.ARB_A_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.ARB_STATA_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.weETH_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.weETH_A_TOKEN)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.GHO_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Arbitrum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.GHO_A_TOKEN)
    );

    AaveV3Arbitrum.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);
    AaveV3Arbitrum.ACL_MANAGER.removeFlashBorrower(AaveV3Arbitrum.DEBT_SWAP_ADAPTER);
  }
}
