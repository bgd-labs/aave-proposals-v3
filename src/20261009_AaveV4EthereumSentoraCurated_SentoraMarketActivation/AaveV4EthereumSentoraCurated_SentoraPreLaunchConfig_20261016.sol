// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IHub, ISpoke} from 'aave-address-book/AaveV4.sol';
import {AaveV4EthereumSentoraCurated, AaveV4EthereumSentoraCuratedHubs, AaveV4EthereumSentoraCuratedSpokes, AaveV4EthereumSentoraCuratedAssets} from 'aave-address-book/AaveV4EthereumSentoraCurated.sol';

/**
 * @title Aave V4 Sentora Pre-Launch Config
 * @author Aave Labs
 * @notice Applies Sentora's pre-launch changes to the Sentora market: closes mWIN, sets the PST and
 * PRIME caps on RLUSD Yield and OUSD Yield to 0, and sets the liquidation config of the three Spokes.
 * @dev Executed by the V4 Security Council through its Executor via delegatecall, once the Council
 * has granted the Executor roles 200, 400, 1000 and 1001, and before the activation payload.
 */
contract AaveV4EthereumSentoraCurated_SentoraPreLaunchConfig_20261016 is IProposalGenericExecutor {
  function execute() external override {
    IHub hub = AaveV4EthereumSentoraCuratedHubs.SENTORA_HUB;
    ISpoke rlusdYield = AaveV4EthereumSentoraCuratedSpokes.RLUSD_YIELD_SPOKE;
    ISpoke ousdYield = AaveV4EthereumSentoraCuratedSpokes.OUSD_YIELD_SPOKE;

    _closeMWin(hub, rlusdYield, ousdYield);
    _zeroCaps(hub, AaveV4EthereumSentoraCuratedAssets.PST_UNDERLYING, rlusdYield, ousdYield);
    _zeroCaps(hub, AaveV4EthereumSentoraCuratedAssets.PRIME_UNDERLYING, rlusdYield, ousdYield);

    ISpoke.LiquidationConfig memory yieldConfig = ISpoke.LiquidationConfig({
      targetHealthFactor: 1.047e18,
      healthFactorForMaxBonus: 0.99e18,
      liquidationBonusFactor: 100_00
    });
    AaveV4EthereumSentoraCurated.SPOKE_CONFIGURATOR.updateLiquidationConfig(
      address(rlusdYield),
      yieldConfig
    );
    AaveV4EthereumSentoraCurated.SPOKE_CONFIGURATOR.updateLiquidationConfig(
      address(ousdYield),
      yieldConfig
    );
    AaveV4EthereumSentoraCurated.SPOKE_CONFIGURATOR.updateLiquidationConfig(
      address(AaveV4EthereumSentoraCuratedSpokes.BLUECHIP_SPOKE),
      ISpoke.LiquidationConfig({
        targetHealthFactor: 1.143e18,
        healthFactorForMaxBonus: 0.99e18,
        liquidationBonusFactor: 100_00
      })
    );
  }

  /// @dev Deactivating and resetting the asset covers every mWIN pair, the TreasurySpoke included.
  function _closeMWin(IHub hub, ISpoke rlusdYield, ISpoke ousdYield) internal {
    uint256 assetId = hub.getAssetId(AaveV4EthereumSentoraCuratedAssets.mWIN_UNDERLYING);
    AaveV4EthereumSentoraCurated.HUB_CONFIGURATOR.deactivateAsset(address(hub), assetId);
    AaveV4EthereumSentoraCurated.HUB_CONFIGURATOR.resetAssetCaps(address(hub), assetId);
    AaveV4EthereumSentoraCurated.SPOKE_CONFIGURATOR.pauseReserve(
      address(rlusdYield),
      rlusdYield.getReserveId(address(hub), assetId)
    );
    AaveV4EthereumSentoraCurated.SPOKE_CONFIGURATOR.pauseReserve(
      address(ousdYield),
      ousdYield.getReserveId(address(hub), assetId)
    );
  }

  function _zeroCaps(IHub hub, address underlying, ISpoke rlusdYield, ISpoke ousdYield) internal {
    uint256 assetId = hub.getAssetId(underlying);
    AaveV4EthereumSentoraCurated.HUB_CONFIGURATOR.updateSpokeCaps(
      address(hub),
      assetId,
      address(rlusdYield),
      0,
      0
    );
    AaveV4EthereumSentoraCurated.HUB_CONFIGURATOR.updateSpokeCaps(
      address(hub),
      assetId,
      address(ousdYield),
      0,
      0
    );
  }
}
