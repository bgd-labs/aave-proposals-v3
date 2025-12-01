// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Sonic, AaveV3SonicAssets} from 'aave-address-book/AaveV3Sonic.sol';
import {MiscSonic} from 'aave-address-book/MiscSonic.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title November Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-november-2025-funding-update/23339
 */
contract AaveV3Sonic_NovemberFundingUpdate_20251110 is IProposalGenericExecutor {
  uint256 public constant WETH_AMOUNT = 12 ether;

  function execute() external {
    AaveV3Sonic.COLLECTOR.approve(
      IERC20(AaveV3SonicAssets.WETH_UNDERLYING),
      MiscSonic.AFC_SAFE,
      WETH_AMOUNT
    );
  }
}
