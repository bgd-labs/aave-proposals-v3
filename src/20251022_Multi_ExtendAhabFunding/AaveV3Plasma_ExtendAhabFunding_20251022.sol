// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {IPoolConfigurator} from 'aave-v3-origin/contracts/interfaces/IPoolConfigurator.sol';

/**
 * @title Extend Ahab Funding
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xa1cb3c88f8c30a05dca3c767a60abc31b4f48fe36a4175f421ac0f2e8ab7dbac
 * - Discussion: https://governance.aave.com/t/arfc-extend-ahab-funding/23213/2
 */
contract AaveV3Plasma_ExtendAhabFunding_20251022 is IProposalGenericExecutor {
  function execute() external override {
    AaveV3Plasma.COLLECTOR.approve(
      IERC20(AaveV3PlasmaAssets.USDT0_A_TOKEN),
      MiscEthereum.AHAB_SAFE,
      3_000_000 ether
    );

    AaveV3Plasma.COLLECTOR.approve(
      IERC20(AaveV3PlasmaAssets.USDe_A_TOKEN),
      MiscEthereum.AHAB_SAFE,
      2_000_000 ether
    );

    IPoolConfigurator(AaveV3Plasma.POOL_CONFIGURATOR).setReserveFactor(
      AaveV3PlasmaAssets.USDT0_UNDERLYING,
      5_00
    );
  }
}
