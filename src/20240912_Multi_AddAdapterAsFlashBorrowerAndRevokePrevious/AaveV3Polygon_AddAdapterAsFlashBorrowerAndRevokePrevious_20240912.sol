// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IBaseParaSwapAdapter} from './interfaces/IBaseParaSwapAdapter.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

/**
 * @title AddAdapterAsFlashBorrowerAndRevokePrevious
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/periphery-contracts-incident-august-28-2024/18821
 */
contract AaveV3Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912 is
  IProposalGenericExecutor
{
  address public constant NEW_FLASH_BORROWER = 0x0000000000000000000000000000000000000001;

  function execute() external {
    IBaseParaSwapAdapter(AaveV3Polygon.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3PolygonAssets.WBTC_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Polygon.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3PolygonAssets.DAI_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Polygon.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3PolygonAssets.BAL_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Polygon.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3PolygonAssets.USDC_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Polygon.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3PolygonAssets.WETH_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Polygon.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3PolygonAssets.USDT_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Polygon.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3PolygonAssets.LINK_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Polygon.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3PolygonAssets.DPI_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Polygon.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3PolygonAssets.MaticX_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Polygon.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3PolygonAssets.wstETH_UNDERLYING)
    );

    AaveV3Polygon.ACL_MANAGER.removeFlashBorrower(AaveV3Polygon.DEBT_SWAP_ADAPTER);
    AaveV3Polygon.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);
  }
}
