// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {IBaseParaSwapAdapter} from './interfaces/IBaseParaSwapAdapter.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

/**
 * @title AddAdapterAsFlashBorrowerAndRevokePrevious
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/periphery-contracts-incident-august-28-2024/18821
 */
contract AaveV3Base_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912 is
  IProposalGenericExecutor
{
  address public constant NEW_FLASH_BORROWER = 0x0000000000000000000000000000000000000001;

  function execute() external {
    AaveV3Base.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);

    IBaseParaSwapAdapter(AaveV3Base.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3BaseAssets.USDbC_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Base.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3BaseAssets.WETH_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Base.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3BaseAssets.wstETH_UNDERLYING)
    );
    IBaseParaSwapAdapter(AaveV3Base.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3BaseAssets.USDC_UNDERLYING)
    );

    AaveV3Base.ACL_MANAGER.removeFlashBorrower(AaveV3Base.DEBT_SWAP_ADAPTER);
  }
}
