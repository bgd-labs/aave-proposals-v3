// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Sonic, AaveV3SonicAssets} from 'aave-address-book/AaveV3Sonic.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title stS Loop Incentive Program
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x65e12ce7784f12fbed9731d4cdbc826a8a5d4804439dc6d55d6e31c0b069a048
 * - Discussion: https://governance.aave.com/t/arfc-sts-loop-incentive-program/22368
 */
contract AaveV3Sonic_StSLoopIncentiveProgram_20250711 is IProposalGenericExecutor {
  uint256 public constant INCENTIVES_AMOUNT = 40_000 ether;
  address public constant MASIV_NESTED_SAFE = 0x565B80842eCEDad88A2564Ea375CE875Ed3bAdeC;

  function execute() external {
    AaveV3Sonic.COLLECTOR.approve(
      IERC20(AaveV3SonicAssets.wS_A_TOKEN),
      MASIV_NESTED_SAFE,
      INCENTIVES_AMOUNT
    );
  }
}
