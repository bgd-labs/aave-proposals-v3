// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Avalanche.sol';

/**
 * @title Reserve Factor Upgrades
 * @author karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x770ff4e02634c77aaa09952345551168920f7878b32ab03fcef92763a5fb70ab
 * - Discussion: https://governance.aave.com/t/arfc-avalanche-v2-reserve-factor-adjustment/17040/4
 */
contract AaveV2Avalanche_ReserveFactorUpgrades_20240528 is IProposalGenericExecutor {
  ILendingPoolConfigurator public constant POOL_CONFIGURATOR =
    ILendingPoolConfigurator(AaveV2Avalanche.POOL_CONFIGURATOR);

  uint256 public constant DAIe_RF = 55_00;
  uint256 public constant USDCe_RF = 55_00;
  uint256 public constant USDTe_RF = 55_00;
  uint256 public constant WAVAX_RF = 55_00;
  uint256 public constant WBTCe_RF = 60_00;
  uint256 public constant WETHe_RF = 55_00;

  function execute() external {
    POOL_CONFIGURATOR.setReserveFactor(AaveV2AvalancheAssets.DAIe_UNDERLYING, DAIe_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2AvalancheAssets.USDCe_UNDERLYING, USDCe_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2AvalancheAssets.USDTe_UNDERLYING, USDTe_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2AvalancheAssets.WAVAX_UNDERLYING, WAVAX_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2AvalancheAssets.WBTCe_UNDERLYING, WBTCe_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2AvalancheAssets.WETHe_UNDERLYING, WETHe_RF);
  }
}
