// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base, AaveV3BaseAssets, AaveV3BaseEModes} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3PayloadBase} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBase.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
/**
 * @title Core & Base - BTC Correlated Asset Update
 * @author TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x9efbc881d7db09b549a4c342387c31149c066de4bc51b625e2213d43aee0e977
 * - Discussion: https://governance.aave.com/t/arfc-core-base-btc-correlated-asset-update/20940
 */
contract AaveV3Base_CoreBaseBTCCorrelatedAssetUpdate_20250211 is AaveV3PayloadBase {
  using SafeERC20 for IERC20;

  // https://etherscan.io/address/0xecAc9C5F704e954931349Da37F60E39f515c11c1
  address public constant LBTC = 0xecAc9C5F704e954931349Da37F60E39f515c11c1;
  uint256 public constant LBTC_SEED_AMOUNT = 1e5;

  function _postExecute() internal override {
    IERC20(LBTC).forceApprove(address(AaveV3Base.POOL), LBTC_SEED_AMOUNT);
    AaveV3Base.POOL.supply(LBTC, LBTC_SEED_AMOUNT, AaveV3Base.DUST_BIN, 0);
  }

  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV3ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV3ConfigEngine.RateStrategyUpdate[](1);
    rateStrategies[0] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3BaseAssets.cbBTC_UNDERLYING,
      params: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 80_00,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: 60_00
      })
    });

    return rateStrategies;
  }

  function borrowsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.BorrowUpdate[] memory)
  {
    IAaveV3ConfigEngine.BorrowUpdate[]
      memory borrowUpdates = new IAaveV3ConfigEngine.BorrowUpdate[](1);

    borrowUpdates[0] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3BaseAssets.cbBTC_UNDERLYING,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: 50_00 // 50%
    });

    return borrowUpdates;
  }

  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](1);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 4,
      ltv: 82_00,
      liqThreshold: 84_00,
      liqBonus: 3_00,
      label: 'LBTC_cbBTC'
    });

    return eModeUpdates;
  }

  function assetsEModeUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.AssetEModeUpdate[] memory)
  {
    IAaveV3ConfigEngine.AssetEModeUpdate[]
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](2);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: LBTC,
      eModeCategory: 4,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3BaseAssets.cbBTC_UNDERLYING,
      eModeCategory: 4,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: LBTC,
      assetSymbol: 'LBTC',
      priceFeed: 0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 68_00,
      liqThreshold: 73_00,
      liqBonus: 8_50,
      reserveFactor: 50_00,
      supplyCap: 400,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 4_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
}
