// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Avalanche.sol';

/**
 * @title Reserve Factor Updates Mid October
 * @author karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x9cc7906f04f45cebeaa48a05ed281f49da00d89c4dd988a968272fa179f14d06
 * - Discussion: https://governance.aave.com/t/arfc-increase-bridged-usdc-reserve-factor-across-all-deployments/17787
 */
contract AaveV2Avalanche_ReserveFactorUpdatesMidOctober_20241004 is IProposalGenericExecutor {
  ILendingPoolConfigurator public constant POOL_CONFIGURATOR =
    ILendingPoolConfigurator(AaveV2Avalanche.POOL_CONFIGURATOR);

  uint256 public constant DAIe_RF = 80_00;
  uint256 public constant USDCe_RF = 80_00;
  uint256 public constant USDTe_RF = 80_00;
  uint256 public constant WAVAX_RF = 80_00;
  uint256 public constant WBTCe_RF = 85_00;
  uint256 public constant WETHe_RF = 80_00;

  function execute() external {
    POOL_CONFIGURATOR.setReserveFactor(AaveV2AvalancheAssets.DAIe_UNDERLYING, DAIe_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2AvalancheAssets.USDCe_UNDERLYING, USDCe_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2AvalancheAssets.USDTe_UNDERLYING, USDTe_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2AvalancheAssets.WAVAX_UNDERLYING, WAVAX_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2AvalancheAssets.WBTCe_UNDERLYING, WBTCe_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2AvalancheAssets.WETHe_UNDERLYING, WETHe_RF);
  }
}
