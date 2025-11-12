// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3BNB, AaveV3BNBAssets} from 'aave-address-book/AaveV3BNB.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title November Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-november-2025-funding-update/23339
 */
contract AaveV3BNB_NovemberFundingUpdate_20251110 is IProposalGenericExecutor {
  uint256 public constant USDC_AMOUNT = 123_000 ether;
  uint256 public constant USDT_AMOUNT = 323_000 ether;
  uint256 public constant ETH_AMOUNT = 27 ether;

  function execute() external {
    AaveV3BNB.COLLECTOR.approve(
      IERC20(AaveV3BNBAssets.USDC_UNDERLYING),
      MiscBNB.AFC_SAFE,
      USDC_AMOUNT
    );

    AaveV3BNB.COLLECTOR.approve(
      IERC20(AaveV3BNBAssets.USDT_UNDERLYING),
      MiscBNB.AFC_SAFE,
      USDT_AMOUNT
    );

    AaveV3BNB.COLLECTOR.approve(
      IERC20(AaveV3BNBAssets.ETH_UNDERLYING),
      MiscBNB.AFC_SAFE,
      ETH_AMOUNT
    );
  }
}
