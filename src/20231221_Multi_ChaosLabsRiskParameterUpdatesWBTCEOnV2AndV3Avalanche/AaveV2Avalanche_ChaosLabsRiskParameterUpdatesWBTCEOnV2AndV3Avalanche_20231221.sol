// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Chaos Labs Risk Parameter Updates - WBTC.e on V2 and V3 Avalanche
 * @author Chaos Labs - Eyal Ovadya
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x0e496f9cb98fb887e9c0e1b4669607a2b99a0675b23ad152c7aedbe28f8dc08d
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-wbtc-e-on-v2-and-v3-avalanche/15824
 */
contract AaveV2Avalanche_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche_20231221 is
  IProposalGenericExecutor
{
  function execute() external {
    AaveV2Avalanche.POOL_CONFIGURATOR.freezeReserve(AaveV2AvalancheAssets.WBTCe_UNDERLYING);
    AaveV2Avalanche.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2AvalancheAssets.WBTCe_UNDERLYING,
      0,
      70_00,
      105_00
    );
  }
}
