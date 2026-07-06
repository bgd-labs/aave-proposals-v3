// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool} from 'aave-address-book/AaveV3.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';

abstract contract ProtocolV3ProposalTestBase is ProtocolV3TestBase {
  function _expectedCollateralChanges()
    internal
    pure
    virtual
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    return new IAaveV3ConfigEngine.CollateralUpdate[](0);
  }

  function _expectedCapsChanges()
    internal
    pure
    virtual
    returns (IAaveV3ConfigEngine.CapsUpdate[] memory)
  {
    return new IAaveV3ConfigEngine.CapsUpdate[](0);
  }

  function reserveConfigChangesTest(
    IPool pool,
    address payload
  ) internal returns (ReserveConfig[] memory, ReserveConfig[] memory) {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(pool);
    executePayload(vm, payload, pool);
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(pool);

    _validateReserveConfigChanges(allConfigsBefore, allConfigsAfter);

    return (allConfigsBefore, allConfigsAfter);
  }

  function _validateReserveConfigChanges(
    ReserveConfig[] memory allConfigsBefore,
    ReserveConfig[] memory allConfigsAfter
  ) internal pure {
    IAaveV3ConfigEngine.CollateralUpdate[] memory collateralUpdates = _expectedCollateralChanges();
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdates = _expectedCapsChanges();

    address[] memory touchedAssets = _getTouchedAssets(collateralUpdates, capsUpdates);

    for (uint256 i = 0; i < touchedAssets.length; i++) {
      ReserveConfig memory expectedConfig = _findReserveConfig(allConfigsBefore, touchedAssets[i]);
      _applyCollateralUpdates(expectedConfig, collateralUpdates);
      _applyCapsUpdates(expectedConfig, capsUpdates);
      _validateReserveConfig(expectedConfig, allConfigsAfter);
    }

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, touchedAssets);
  }

  function _applyCollateralUpdates(
    ReserveConfig memory expectedConfig,
    IAaveV3ConfigEngine.CollateralUpdate[] memory collateralUpdates
  ) internal pure {
    for (uint256 i = 0; i < collateralUpdates.length; i++) {
      IAaveV3ConfigEngine.CollateralUpdate memory update = collateralUpdates[i];
      if (update.asset != expectedConfig.underlying) continue;

      if (update.ltv != EngineFlags.KEEP_CURRENT) {
        expectedConfig.ltv = update.ltv;
      }
      if (update.liqThreshold != EngineFlags.KEEP_CURRENT) {
        expectedConfig.liquidationThreshold = update.liqThreshold;
        expectedConfig.usageAsCollateralEnabled = update.liqThreshold != 0;
      }
      if (update.liqBonus != EngineFlags.KEEP_CURRENT) {
        expectedConfig.liquidationBonus = 100_00 + update.liqBonus;
      }
      if (update.liqProtocolFee != EngineFlags.KEEP_CURRENT) {
        expectedConfig.liquidationProtocolFee = update.liqProtocolFee;
      }
    }
  }

  function _applyCapsUpdates(
    ReserveConfig memory expectedConfig,
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdates
  ) internal pure {
    for (uint256 i = 0; i < capsUpdates.length; i++) {
      IAaveV3ConfigEngine.CapsUpdate memory update = capsUpdates[i];
      if (update.asset != expectedConfig.underlying) continue;

      if (update.supplyCap != EngineFlags.KEEP_CURRENT) {
        expectedConfig.supplyCap = update.supplyCap;
      }
      if (update.borrowCap != EngineFlags.KEEP_CURRENT) {
        expectedConfig.borrowCap = update.borrowCap;
      }
    }
  }

  function _getTouchedAssets(
    IAaveV3ConfigEngine.CollateralUpdate[] memory collateralUpdates,
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdates
  ) internal pure returns (address[] memory) {
    address[] memory assets = new address[](collateralUpdates.length + capsUpdates.length);
    uint256 assetsCount;

    for (uint256 i = 0; i < collateralUpdates.length; i++) {
      assetsCount = _appendUnique(assets, assetsCount, collateralUpdates[i].asset);
    }
    for (uint256 i = 0; i < capsUpdates.length; i++) {
      assetsCount = _appendUnique(assets, assetsCount, capsUpdates[i].asset);
    }

    address[] memory touchedAssets = new address[](assetsCount);
    for (uint256 i = 0; i < assetsCount; i++) {
      touchedAssets[i] = assets[i];
    }
    return touchedAssets;
  }

  function _appendUnique(
    address[] memory assets,
    uint256 assetsCount,
    address asset
  ) internal pure returns (uint256) {
    for (uint256 i = 0; i < assetsCount; i++) {
      if (assets[i] == asset) return assetsCount;
    }
    assets[assetsCount] = asset;
    return assetsCount + 1;
  }
}
