// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';
import {AHAB_SAFE} from 'aave-address-book/ts/MiscPlasma.ts';

/**
 * @title Extend Ahab Funding
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xa1cb3c88f8c30a05dca3c767a60abc31b4f48fe36a4175f421ac0f2e8ab7dbac
 * - Discussion: https://governance.aave.com/t/arfc-extend-ahab-funding/23213/2
 */
contract AaveV3Plasma_ExtendAhabFunding_20251022 is IProposalGenericExecutor {
  function execute() external override {
    AaveV3Plasma.COLLECTOR.approve(
      IERC20(0x5D72a9d9A9510Cd8cBdBA12aC62593A58930a948),
      AHAB_SAFE,
      3_000_000 ether
    );

    AaveV3Plasma.COLLECTOR.approve(
      IERC20(0x7519403E12111ff6b710877Fcd821D0c12CAF43A),
      AHAB_SAFE,
      2_000_000 ether
    );
  }
}
