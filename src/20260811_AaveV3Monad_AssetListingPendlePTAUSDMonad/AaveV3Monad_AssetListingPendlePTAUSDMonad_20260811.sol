// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Monad, AaveV3MonadAssets} from 'aave-address-book/AaveV3Monad.sol';
import {AaveV3PayloadMonad} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadMonad.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

/**
 * @title Asset Listing - Pendle PT-AUSD Monad
 * @author @TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x1d5029f1b99b62843590e28d027a1a5aa21f4fe19f175284197c58779db14027
 * - Discussion: https://governance.aave.com/t/arfc-onboard-pt-ausd-8oct2026-to-aave-v3-monad-instance/25331
 */
contract AaveV3Monad_AssetListingPendlePTAUSDMonad_20260811 is AaveV3PayloadMonad {
  using SafeERC20 for IERC20;

  // https://monadscan.com/address/0x9FC74f8Ed616B5BaF52a170caa97d6d3898602d1
  address public constant PT_AUSD_8OCT2026 = 0x9FC74f8Ed616B5BaF52a170caa97d6d3898602d1;
  uint256 public constant PT_AUSD_8OCT2026_SEED_AMOUNT = 100e6;
  // https://monadscan.com/address/0x6D8f31268E94Bec0b0E07bc06b561b8B749F3127
  address public constant PT_AUSD_8OCT2026_PRICE_FEED = 0x6D8f31268E94Bec0b0E07bc06b561b8B749F3127;

  function _postExecute() internal override {
    IERC20(PT_AUSD_8OCT2026).forceApprove(address(AaveV3Monad.POOL), PT_AUSD_8OCT2026_SEED_AMOUNT);
    AaveV3Monad.POOL.supply(
      PT_AUSD_8OCT2026,
      PT_AUSD_8OCT2026_SEED_AMOUNT,
      address(AaveV3Monad.DUST_BIN),
      0
    );
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PT_AUSD_8OCT2026,
      assetSymbol: 'PT_AUSD_8OCT2026',
      priceFeed: PT_AUSD_8OCT2026_PRICE_FEED,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 20_00,
      supplyCap: 20_000_000,
      borrowCap: 1,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_PTAgoraStablecoins = new address[](1);
    address[] memory borrowableAssets_PTAgoraStablecoins = new address[](4);

    collateralAssets_PTAgoraStablecoins[0] = PT_AUSD_8OCT2026;
    borrowableAssets_PTAgoraStablecoins[0] = AaveV3MonadAssets.USDT0_UNDERLYING;
    borrowableAssets_PTAgoraStablecoins[1] = AaveV3MonadAssets.USDC_UNDERLYING;
    borrowableAssets_PTAgoraStablecoins[2] = AaveV3MonadAssets.GHO_UNDERLYING;
    borrowableAssets_PTAgoraStablecoins[3] = AaveV3MonadAssets.USDe_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 2_44,
      label: 'PT_Agora__Stablecoins',
      isolated: true,
      collaterals: collateralAssets_PTAgoraStablecoins,
      borrowables: borrowableAssets_PTAgoraStablecoins
    });

    return eModeCreations;
  }
}
