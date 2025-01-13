// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync, AaveV3ZkSyncAssets} from 'aave-address-book/AaveV3ZkSync.sol';
import {AaveV3PayloadZkSync} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadZkSync.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Onboard sUSDe, USDe and weETH to Aave v3 on zkSync
 * @author Aave-chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x6709151a1efa71370a6a0f9a7592d983ed401ac0311cce861fba347081384520
 * - Discussion: https://governance.aave.com/t/arfc-onboard-susde-usde-and-weeth-to-aave-v3-on-zksync/19204
 */
contract AaveV3ZkSync_OnboardSUSDeUSDeAndWeETHToAaveV3OnZkSync_20250110 is AaveV3PayloadZkSync {
  using SafeERC20 for IERC20;

  address public constant weETH = 0xc1Fa6E2E8667d9bE0Ca938a54c7E0285E9Df924a;
  uint256 public constant weETH_SEED_AMOUNT = 25e15;
  address public constant weETH_LM_ADMIN = 0x95Cbff6e45C499d45dd8627f3ce179057B5Fbfcc;

  address public constant sUSDe = 0xAD17Da2f6Ac76746EF261E835C50b2651ce36DA8;
  uint256 public constant sUSDe_SEED_AMOUNT = 100e18;
  address public constant sUSDe_LM_ADMIN = 0x95Cbff6e45C499d45dd8627f3ce179057B5Fbfcc;

  function _postExecute() internal override {
    IERC20(weETH).forceApprove(address(AaveV3ZkSync.POOL), weETH_SEED_AMOUNT);
    AaveV3ZkSync.POOL.supply(weETH, weETH_SEED_AMOUNT, address(AaveV3ZkSync.COLLECTOR), 0);

    (address aweETH, , ) = AaveV3ZkSync.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      weETH
    );
    IEmissionManager(AaveV3ZkSync.EMISSION_MANAGER).setEmissionAdmin(weETH, weETH_LM_ADMIN);
    IEmissionManager(AaveV3ZkSync.EMISSION_MANAGER).setEmissionAdmin(aweETH, weETH_LM_ADMIN);

    IERC20(sUSDe).forceApprove(address(AaveV3ZkSync.POOL), sUSDe_SEED_AMOUNT);
    AaveV3ZkSync.POOL.supply(sUSDe, sUSDe_SEED_AMOUNT, address(AaveV3ZkSync.COLLECTOR), 0);

    (address asUSDe, , ) = AaveV3ZkSync.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      sUSDe
    );
    IEmissionManager(AaveV3ZkSync.EMISSION_MANAGER).setEmissionAdmin(sUSDe, sUSDe_LM_ADMIN);
    IEmissionManager(AaveV3ZkSync.EMISSION_MANAGER).setEmissionAdmin(asUSDe, sUSDe_LM_ADMIN);
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
      eModeCategory: 2,
      ltv: 90_00,
      liqThreshold: 93_00,
      liqBonus: 1_00,
      label: 'weETH correlated'
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
      asset: weETH,
      eModeCategory: 2,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });

    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3ZkSyncAssets.WETH_UNDERLYING,
      eModeCategory: 2,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](2);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: weETH,
      assetSymbol: 'weETH',
      priceFeed: 0x32aF9A0a47B332761c8C90E9eC9f53e46e852b2B,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 72_50,
      liqThreshold: 75_00,
      liqBonus: 7_50,
      reserveFactor: 45_00,
      supplyCap: 300,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 30_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 7_00,
        variableRateSlope2: 300_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: sUSDe,
      assetSymbol: 'sUSDe',
      priceFeed: 0xDaec4cC3a41E423d678428A8Bb29fa1ADF26869a,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 65_00,
      liqThreshold: 75_00,
      liqBonus: 8_50,
      reserveFactor: 20_00,
      supplyCap: 400_000,
      borrowCap: 1,
      debtCeiling: 400_000,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 80_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 9_00,
        variableRateSlope2: 75_00
      })
    });

    return listings;
  }
}
