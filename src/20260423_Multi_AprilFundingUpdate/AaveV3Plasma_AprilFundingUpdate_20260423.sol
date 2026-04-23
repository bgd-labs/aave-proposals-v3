// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {MiscPlasma} from 'aave-address-book/MiscPlasma.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title April Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-april-2026-funding-update/24447
 */
contract AaveV3Plasma_AprilFundingUpdate_20260423 is IProposalGenericExecutor {
  address public constant AFC_SAFE = 0x22740deBa78d5a0c24C58C740e3715ec29de1bFa;
  uint256 public constant WETH_ALLOWANCE = 55 ether;

  function execute() external {
    AaveV3Plasma.COLLECTOR.approve(
      IERC20(AaveV3PlasmaAssets.WETH_A_TOKEN),
      AFC_SAFE,
      WETH_ALLOWANCE
    );
  }
}
