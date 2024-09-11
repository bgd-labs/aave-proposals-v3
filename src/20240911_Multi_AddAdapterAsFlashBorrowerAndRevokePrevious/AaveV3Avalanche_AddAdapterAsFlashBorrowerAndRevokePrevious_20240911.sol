// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IBaseParaSwapAdapter} from 'aave-debt-swap/contracts/interfaces/IBaseParaSwapAdapter.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

/**
 * @title AddAdapterAsFlashBorrowerAndRevokePrevious
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/periphery-contracts-incident-august-28-2024/18821
 */
contract AaveV3Avalanche_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911 is
  IProposalGenericExecutor
{
  address public constant NEW_FLASH_BORROWER = 0x0000000000000000000000000000000000000001;

  function execute() external {
    AaveV3Avalanche.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);

    IBaseParaSwapAdapter(AaveV3Avalanche.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3AvalancheAssets.USDt_UNDERLYING)
    );

    AaveV3Avalanche.ACL_MANAGER.removeFlashBorrower(AaveV3Avalanche.DEBT_SWAP_ADAPTER);
  }
}
