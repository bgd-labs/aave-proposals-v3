// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {ISpoke} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/ISpoke.sol';
import {IHub} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/IHub.sol';
import {IAaveOracle} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/IAaveOracle.sol';
import {IAssetInterestRateStrategy} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/IAssetInterestRateStrategy.sol';
import {Types} from './Types.sol';
import {V4DiffWriter} from './V4DiffWriter.sol';
import {GatewayScenarios} from './GatewayScenarios.sol';

/// @title SnapshotV4
/// @notice Snapshot capture for Aave V4. JSON + markdown diff delegated to V4DiffWriter.
abstract contract SnapshotV4 is GatewayScenarios {
  /// @notice Capture a full V4 configuration snapshot from the given spokes and hubs.
  function createV4Snapshot(
    ISpoke[] memory spokes,
    IHub[] memory hubs
  ) internal view returns (Types.V4Snapshot memory snapshot) {
    snapshot.spokeReserves = _snapshotSpokeReserves(spokes);
    snapshot.spokeLiquidationConfigs = _snapshotSpokeLiqConfigs(spokes);
    snapshot.hubAssets = _snapshotHubAssets(hubs);
    snapshot.hubSpokeCaps = _snapshotHubSpokeCaps(hubs);
  }

  /// @notice Write a V4 snapshot to JSON file.
  function writeV4SnapshotJson(string memory name, Types.V4Snapshot memory snap) internal {
    V4DiffWriter.writeSnapshotJson(name, snap);
  }

  /// @notice Generate markdown diff between two snapshots.
  function diffV4Snapshots(
    string memory reportName,
    Types.V4Snapshot memory snapBefore,
    Types.V4Snapshot memory snapAfter
  ) internal {
    V4DiffWriter.writeDiff(reportName, snapBefore, snapAfter);
  }

  // ---------------------------------------------------------------------------
  // Spoke reserves
  // ---------------------------------------------------------------------------

  function _snapshotSpokeReserves(
    ISpoke[] memory spokes
  ) private view returns (Types.SpokeReserveSnapshot[] memory) {
    uint256 total;
    for (uint256 s; s < spokes.length; s++) total += spokes[s].getReserveCount();

    Types.SpokeReserveSnapshot[] memory result = new Types.SpokeReserveSnapshot[](total);
    uint256 idx;
    for (uint256 s; s < spokes.length; s++) {
      uint256 count = spokes[s].getReserveCount();
      for (uint256 i; i < count; i++) {
        result[idx++] = _snapshotReserve(spokes[s], i);
      }
    }
    return result;
  }

  function _snapshotReserve(
    ISpoke spoke,
    uint256 reserveId
  ) private view returns (Types.SpokeReserveSnapshot memory snap) {
    ISpoke.Reserve memory reserve = spoke.getReserve(reserveId);
    ISpoke.ReserveConfig memory config = spoke.getReserveConfig(reserveId);
    ISpoke.DynamicReserveConfig memory dyn = spoke.getDynamicReserveConfig(
      reserveId,
      reserve.dynamicConfigKey
    );

    snap.spokeAddress = address(spoke);
    snap.reserveId = reserveId;
    snap.underlying = reserve.underlying;
    snap.symbol = _safeSymbol(reserve.underlying);
    snap.hub = address(reserve.hub);
    snap.assetId = reserve.assetId;
    snap.decimals = reserve.decimals;
    snap.collateralRisk = config.collateralRisk;
    snap.paused = config.paused;
    snap.frozen = config.frozen;
    snap.borrowable = config.borrowable;
    snap.receiveSharesEnabled = config.receiveSharesEnabled;
    snap.dynamicConfigKey = reserve.dynamicConfigKey;
    snap.collateralFactor = dyn.collateralFactor;
    snap.maxLiquidationBonus = dyn.maxLiquidationBonus;
    snap.liquidationFee = dyn.liquidationFee;

    address oracleAddr = spoke.ORACLE();
    snap.oracleAddress = oracleAddr;
    try IAaveOracle(oracleAddr).getReserveSource(reserveId) returns (address src) {
      snap.priceSource = src;
    } catch {}
    try IAaveOracle(oracleAddr).getReservePrice(reserveId) returns (uint256 price) {
      snap.oraclePrice = price;
    } catch {}
  }

  // ---------------------------------------------------------------------------
  // Spoke liquidation configs
  // ---------------------------------------------------------------------------

  function _snapshotSpokeLiqConfigs(
    ISpoke[] memory spokes
  ) private view returns (Types.SpokeLiquidationSnapshot[] memory) {
    Types.SpokeLiquidationSnapshot[] memory result = new Types.SpokeLiquidationSnapshot[](
      spokes.length
    );
    for (uint256 s; s < spokes.length; s++) {
      ISpoke.LiquidationConfig memory liq = spokes[s].getLiquidationConfig();
      result[s] = Types.SpokeLiquidationSnapshot({
        spokeAddress: address(spokes[s]),
        targetHealthFactor: liq.targetHealthFactor,
        healthFactorForMaxBonus: liq.healthFactorForMaxBonus,
        liquidationBonusFactor: liq.liquidationBonusFactor,
        maxUserReservesLimit: spokes[s].MAX_USER_RESERVES_LIMIT()
      });
    }
    return result;
  }

  // ---------------------------------------------------------------------------
  // Hub assets
  // ---------------------------------------------------------------------------

  function _snapshotHubAssets(
    IHub[] memory hubs
  ) private view returns (Types.HubAssetSnapshot[] memory) {
    uint256 total;
    for (uint256 h; h < hubs.length; h++) total += hubs[h].getAssetCount();

    Types.HubAssetSnapshot[] memory result = new Types.HubAssetSnapshot[](total);
    uint256 idx;
    for (uint256 h; h < hubs.length; h++) {
      uint256 count = hubs[h].getAssetCount();
      for (uint256 a; a < count; a++) {
        result[idx++] = _snapshotHubAsset(hubs[h], a);
      }
    }
    return result;
  }

  function _snapshotHubAsset(
    IHub hub,
    uint256 assetId
  ) private view returns (Types.HubAssetSnapshot memory snap) {
    IHub.AssetConfig memory config = hub.getAssetConfig(assetId);
    (address underlying, uint8 decimals) = hub.getAssetUnderlyingAndDecimals(assetId);

    snap.hubAddress = address(hub);
    snap.assetId = assetId;
    snap.underlying = underlying;
    snap.symbol = _safeSymbol(underlying);
    snap.decimals = decimals;
    snap.liquidityFee = config.liquidityFee;
    snap.irStrategy = config.irStrategy;
    snap.feeReceiver = config.feeReceiver;
    snap.reinvestmentController = config.reinvestmentController;

    if (config.irStrategy != address(0)) {
      try IAssetInterestRateStrategy(config.irStrategy).getInterestRateData(assetId) returns (
        IAssetInterestRateStrategy.InterestRateData memory irData
      ) {
        snap.optimalUsageRatio = irData.optimalUsageRatio;
        snap.baseDrawnRate = irData.baseDrawnRate;
        snap.rateGrowthBeforeOptimal = irData.rateGrowthBeforeOptimal;
        snap.rateGrowthAfterOptimal = irData.rateGrowthAfterOptimal;
      } catch {}
      try IAssetInterestRateStrategy(config.irStrategy).getMaxDrawnRate(assetId) returns (
        uint256 rate
      ) {
        snap.maxDrawnRate = rate;
      } catch {}
    }
  }

  // ---------------------------------------------------------------------------
  // Hub spoke caps
  // ---------------------------------------------------------------------------

  function _snapshotHubSpokeCaps(
    IHub[] memory hubs
  ) private view returns (Types.HubSpokeCapSnapshot[] memory) {
    uint256 total;
    for (uint256 h; h < hubs.length; h++) {
      uint256 ac = hubs[h].getAssetCount();
      for (uint256 a; a < ac; a++) total += hubs[h].getSpokeCount(a);
    }

    Types.HubSpokeCapSnapshot[] memory result = new Types.HubSpokeCapSnapshot[](total);
    uint256 idx;
    for (uint256 h; h < hubs.length; h++) {
      idx = _snapshotCapsForHub(hubs[h], result, idx);
    }
    return result;
  }

  function _snapshotCapsForHub(
    IHub hub,
    Types.HubSpokeCapSnapshot[] memory result,
    uint256 idx
  ) private view returns (uint256) {
    uint256 ac = hub.getAssetCount();
    for (uint256 a; a < ac; a++) {
      (address underlying, ) = hub.getAssetUnderlyingAndDecimals(a);
      string memory sym = _safeSymbol(underlying);
      uint256 sc = hub.getSpokeCount(a);
      for (uint256 sp; sp < sc; sp++) {
        address spokeAddr = hub.getSpokeAddress(a, sp);
        IHub.SpokeConfig memory cfg = hub.getSpokeConfig(a, spokeAddr);
        result[idx++] = Types.HubSpokeCapSnapshot({
          hubAddress: address(hub),
          assetId: a,
          assetSymbol: sym,
          spokeAddress: spokeAddr,
          addCap: cfg.addCap,
          drawCap: cfg.drawCap,
          riskPremiumThreshold: cfg.riskPremiumThreshold,
          active: cfg.active,
          halted: cfg.halted
        });
      }
    }
    return idx;
  }
}
