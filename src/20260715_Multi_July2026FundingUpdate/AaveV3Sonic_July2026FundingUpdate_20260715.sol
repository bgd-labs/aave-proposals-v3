// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Sonic, AaveV3SonicAssets} from 'aave-address-book/AaveV3Sonic.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title July 2026 Funding Update
 * @author TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x2f86020fc038694a5c4738e3982e4fa92eb315aaa4d3ce2fa2be2a5808a9280b
 * - Discussion: https://governance.aave.com/t/direct-to-aip-july-2026-funding-update/25277
 */
contract AaveV3Sonic_July2026FundingUpdate_20260715 is IProposalGenericExecutor {
  // https://sonicscan.org/address/0x565B80842eCEDad88A2564Ea375CE875Ed3bAdeC
  address public constant ACI_INCENTIVES = 0x565B80842eCEDad88A2564Ea375CE875Ed3bAdeC;

  function execute() external {
    AaveV3Sonic.COLLECTOR.approve(IERC20(AaveV3SonicAssets.wS_A_TOKEN), ACI_INCENTIVES, 0);
  }
}
