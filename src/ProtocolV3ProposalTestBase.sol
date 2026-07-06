// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool} from 'aave-address-book/AaveV3.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';

abstract contract ProtocolV3ProposalTestBase is ProtocolV3TestBase {
  struct ReserveFreezeUpdate {
    address asset;
    bool frozen;
  }

  struct ExpectedReserveListing {
    IAaveV3ConfigEngine.Listing listing;
    uint256 decimals;
  }

  function _expectedListings() internal pure virtual returns (ExpectedReserveListing[] memory) {
    return new ExpectedReserveListing[](0);
  }

  function _expectedCustomListings()
    internal
    pure
    virtual
    returns (ExpectedReserveListing[] memory)
  {
    return new ExpectedReserveListing[](0);
  }

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

  function _expectedBorrowChanges()
    internal
    pure
    virtual
    returns (IAaveV3ConfigEngine.BorrowUpdate[] memory)
  {
    return new IAaveV3ConfigEngine.BorrowUpdate[](0);
  }

  function _expectedFreezeChanges() internal pure virtual returns (ReserveFreezeUpdate[] memory) {
    return new ReserveFreezeUpdate[](0);
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
    ExpectedReserveListing[] memory listings = _expectedListings();
    ExpectedReserveListing[] memory customListings = _expectedCustomListings();
    IAaveV3ConfigEngine.CollateralUpdate[] memory collateralUpdates = _expectedCollateralChanges();
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdates = _expectedCapsChanges();
    IAaveV3ConfigEngine.BorrowUpdate[] memory borrowUpdates = _expectedBorrowChanges();
    ReserveFreezeUpdate[] memory freezeUpdates = _expectedFreezeChanges();

    _validateNewListings(allConfigsBefore, allConfigsAfter, listings, customListings);

    address[] memory touchedAssets = _getTouchedAssets(
      collateralUpdates,
      capsUpdates,
      borrowUpdates,
      freezeUpdates
    );

    for (uint256 i = 0; i < touchedAssets.length; i++) {
      ReserveConfig memory expectedConfig = _findReserveConfig(allConfigsBefore, touchedAssets[i]);
      _applyCollateralUpdates(expectedConfig, collateralUpdates);
      _applyCapsUpdates(expectedConfig, capsUpdates);
      _applyBorrowUpdates(expectedConfig, borrowUpdates);
      _applyFreezeUpdates(expectedConfig, freezeUpdates);
      _validateReserveConfig(expectedConfig, allConfigsAfter);
    }

    _noExistingReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, touchedAssets);
  }

  function _validateNewListings(
    ReserveConfig[] memory allConfigsBefore,
    ReserveConfig[] memory allConfigsAfter,
    ExpectedReserveListing[] memory listings,
    ExpectedReserveListing[] memory customListings
  ) internal pure {
    _validateCountOfListings(
      listings.length + customListings.length,
      allConfigsBefore,
      allConfigsAfter
    );

    for (uint256 i = 0; i < listings.length; i++) {
      _validateListedReserveConfig(listings[i], allConfigsAfter);
    }
    for (uint256 i = 0; i < customListings.length; i++) {
      _validateListedReserveConfig(customListings[i], allConfigsAfter);
    }
  }

  function _validateListedReserveConfig(
    ExpectedReserveListing memory expectedListing,
    ReserveConfig[] memory allConfigsAfter
  ) internal pure {
    IAaveV3ConfigEngine.Listing memory listing = expectedListing.listing;
    ReserveConfig memory config = _findReserveConfig(allConfigsAfter, listing.asset);

    require(
      keccak256(bytes(config.symbol)) == keccak256(bytes(listing.assetSymbol)),
      '_validateListedReserveConfig() : INVALID_SYMBOL'
    );
    require(
      config.decimals == expectedListing.decimals,
      '_validateListedReserveConfig() : INVALID_DECIMALS'
    );

    if (listing.liqThreshold != 0) {
      require(config.ltv == listing.ltv, '_validateListedReserveConfig() : INVALID_LTV');
      require(
        config.liquidationThreshold == listing.liqThreshold,
        '_validateListedReserveConfig() : INVALID_LIQ_THRESHOLD'
      );
      require(
        config.liquidationBonus == 100_00 + listing.liqBonus,
        '_validateListedReserveConfig() : INVALID_LIQ_BONUS'
      );
      require(
        config.liquidationProtocolFee == listing.liqProtocolFee,
        '_validateListedReserveConfig() : INVALID_LIQ_PROTOCOL_FEE'
      );
      require(
        config.usageAsCollateralEnabled,
        '_validateListedReserveConfig() : INVALID_USAGE_AS_COLLATERAL'
      );
    } else {
      require(config.ltv == 0, '_validateListedReserveConfig() : INVALID_LTV');
      require(
        config.liquidationThreshold == 0,
        '_validateListedReserveConfig() : INVALID_LIQ_THRESHOLD'
      );
      require(
        !config.usageAsCollateralEnabled,
        '_validateListedReserveConfig() : INVALID_USAGE_AS_COLLATERAL'
      );
    }

    require(
      config.borrowingEnabled == EngineFlags.toBool(listing.enabledToBorrow),
      '_validateListedReserveConfig() : INVALID_BORROWING_ENABLED'
    );
    require(
      config.isFlashloanable == EngineFlags.toBool(listing.flashloanable),
      '_validateListedReserveConfig() : INVALID_IS_FLASHLOANABLE'
    );
    require(
      config.reserveFactor == listing.reserveFactor,
      '_validateListedReserveConfig() : INVALID_RESERVE_FACTOR'
    );
    require(
      config.supplyCap == listing.supplyCap,
      '_validateListedReserveConfig() : INVALID_SUPPLY_CAP'
    );
    require(
      config.borrowCap == listing.borrowCap,
      '_validateListedReserveConfig() : INVALID_BORROW_CAP'
    );
    require(config.isActive, '_validateListedReserveConfig() : INVALID_IS_ACTIVE');
    require(!config.isFrozen, '_validateListedReserveConfig() : INVALID_IS_FROZEN');
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

  function _applyBorrowUpdates(
    ReserveConfig memory expectedConfig,
    IAaveV3ConfigEngine.BorrowUpdate[] memory borrowUpdates
  ) internal pure {
    for (uint256 i = 0; i < borrowUpdates.length; i++) {
      IAaveV3ConfigEngine.BorrowUpdate memory update = borrowUpdates[i];
      if (update.asset != expectedConfig.underlying) continue;

      if (update.enabledToBorrow != EngineFlags.KEEP_CURRENT) {
        expectedConfig.borrowingEnabled = EngineFlags.toBool(update.enabledToBorrow);
      }
      if (update.reserveFactor != EngineFlags.KEEP_CURRENT) {
        expectedConfig.reserveFactor = update.reserveFactor;
      }
      if (update.flashloanable != EngineFlags.KEEP_CURRENT) {
        expectedConfig.isFlashloanable = EngineFlags.toBool(update.flashloanable);
      }
    }
  }

  function _applyFreezeUpdates(
    ReserveConfig memory expectedConfig,
    ReserveFreezeUpdate[] memory freezeUpdates
  ) internal pure {
    for (uint256 i = 0; i < freezeUpdates.length; i++) {
      ReserveFreezeUpdate memory update = freezeUpdates[i];
      if (update.asset != expectedConfig.underlying) continue;

      expectedConfig.isFrozen = update.frozen;
    }
  }

  function _getTouchedAssets(
    IAaveV3ConfigEngine.CollateralUpdate[] memory collateralUpdates,
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdates,
    IAaveV3ConfigEngine.BorrowUpdate[] memory borrowUpdates,
    ReserveFreezeUpdate[] memory freezeUpdates
  ) internal pure returns (address[] memory) {
    address[] memory assets = new address[](
      collateralUpdates.length + capsUpdates.length + borrowUpdates.length + freezeUpdates.length
    );
    uint256 assetsCount;

    for (uint256 i = 0; i < collateralUpdates.length; i++) {
      assetsCount = _appendUnique(assets, assetsCount, collateralUpdates[i].asset);
    }
    for (uint256 i = 0; i < capsUpdates.length; i++) {
      assetsCount = _appendUnique(assets, assetsCount, capsUpdates[i].asset);
    }
    for (uint256 i = 0; i < borrowUpdates.length; i++) {
      assetsCount = _appendUnique(assets, assetsCount, borrowUpdates[i].asset);
    }
    for (uint256 i = 0; i < freezeUpdates.length; i++) {
      assetsCount = _appendUnique(assets, assetsCount, freezeUpdates[i].asset);
    }

    address[] memory touchedAssets = new address[](assetsCount);
    for (uint256 i = 0; i < assetsCount; i++) {
      touchedAssets[i] = assets[i];
    }
    return touchedAssets;
  }

  function _noExistingReservesConfigsChangesApartFrom(
    ReserveConfig[] memory allConfigsBefore,
    ReserveConfig[] memory allConfigsAfter,
    address[] memory assetChangedUnderlying
  ) internal pure {
    for (uint256 i = 0; i < allConfigsBefore.length; i++) {
      bool isAssetExpectedToChange;
      for (uint256 j = 0; j < assetChangedUnderlying.length; j++) {
        if (assetChangedUnderlying[j] == allConfigsBefore[i].underlying) {
          isAssetExpectedToChange = true;
          break;
        }
      }
      if (!isAssetExpectedToChange) {
        _requireNoChangeInConfigs(
          allConfigsBefore[i],
          _findReserveConfig(allConfigsAfter, allConfigsBefore[i].underlying)
        );
      }
    }
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
