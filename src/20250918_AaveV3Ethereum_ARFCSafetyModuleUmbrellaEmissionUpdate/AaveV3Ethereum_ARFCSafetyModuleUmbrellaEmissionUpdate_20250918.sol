// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IAaveEcosystemReserveController} from 'aave-address-book/common/IAaveEcosystemReserveController.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @title [ARFC] Safety Module & Umbrella Emission Update
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x6712b1677068d2d316af699757057a0c8c03e0ff0693c12aacc381d294c419a4
 * - Discussion: https://governance.aave.com/t/arfc-safety-module-umbrella-emission-update/23103/8
 */
contract AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918 is
  IProposalGenericExecutor
{
  uint256 public constant NEW_MAX_SLASHING_PCT = 0;

  uint256 public constant NEW_COOLDOWN_PERIOD_AAVE = 7 days;

  address public constant AAVE_LIQUIDITY_SAFE = 0xAAA973Fe8A6202947e21D0a3a43d8E83ABE35C23;

  uint256 public constant AAVE_ALLOWANCE = 18398.7 ether;
  uint256 public constant WETH_ALLOWANCE = 1239.66 ether;

  function execute() external override {
    _disableSlashingLegacyModules();
    _setCooldownPeriod();
    _setLiquiditySafeAllowances();
  }

  function _disableSlashingLegacyModules() internal {
    IStakeToken(AaveSafetyModule.STK_AAVE).setMaxSlashablePercentage(NEW_MAX_SLASHING_PCT);
    IStakeToken(AaveSafetyModule.STK_ABPT).setMaxSlashablePercentage(NEW_MAX_SLASHING_PCT);
  }

  function _setCooldownPeriod() internal {
    IStakeToken(AaveSafetyModule.STK_AAVE).setCooldownSeconds(NEW_COOLDOWN_PERIOD_AAVE);
  }

  function _setLiquiditySafeAllowances() internal {
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN),
      AAVE_LIQUIDITY_SAFE,
      WETH_ALLOWANCE
    );

    IAaveEcosystemReserveController(MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER).approve(
      address(MiscEthereum.ECOSYSTEM_RESERVE),
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AAVE_LIQUIDITY_SAFE,
      AAVE_ALLOWANCE
    );
  }
}
