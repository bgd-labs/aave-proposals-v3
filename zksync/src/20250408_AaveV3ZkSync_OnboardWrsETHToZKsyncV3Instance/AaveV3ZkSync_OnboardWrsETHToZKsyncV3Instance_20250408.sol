// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync, AaveV3ZkSyncAssets} from 'aave-address-book/AaveV3ZkSync.sol';
import {AaveV3PayloadZkSync} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadZkSync.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Onboard wrsETH to ZKsync V3 Instance
 * @author Aave-Chan Initiative
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-onboard-wrseth-to-zksync-v3-instance/20727
 */
contract AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance_20250408 is AaveV3PayloadZkSync {
  using SafeERC20 for IERC20;

  address public constant wrsETH = 0xd4169E045bcF9a86cC00101225d9ED61D2F51af2;
  uint256 public constant wrsETH_SEED_AMOUNT = 0.035e18;
  address public constant wrsETH_LM_ADMIN = 0x95Cbff6e45C499d45dd8627f3ce179057B5Fbfcc;

  function _postExecute() internal override {
    IERC20(wrsETH).forceApprove(address(AaveV3ZkSync.POOL), wrsETH_SEED_AMOUNT);
    AaveV3ZkSync.POOL.supply(wrsETH, wrsETH_SEED_AMOUNT, AaveV3ZkSync.DUST_BIN, 0);

    address awrsETH = AaveV3ZkSync.POOL.getReserveAToken(wrsETH);
    IEmissionManager(AaveV3ZkSync.EMISSION_MANAGER).setEmissionAdmin(wrsETH, wrsETH_LM_ADMIN);
    IEmissionManager(AaveV3ZkSync.EMISSION_MANAGER).setEmissionAdmin(awrsETH, wrsETH_LM_ADMIN);
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
      eModeCategory: 3,
      ltv: 92_50,
      liqThreshold: 94_50,
      liqBonus: 1_00,
      label: 'wrsETH/wstETH'
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
      asset: wrsETH,
      eModeCategory: 3,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3ZkSyncAssets.wstETH_UNDERLYING,
      eModeCategory: 3,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: wrsETH,
      assetSymbol: 'wrsETH',
      priceFeed: 0x8d25c9de6DBAd9a9eadfB2CA4706034F6721d555,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 10_00,
      supplyCap: 700,
      borrowCap: 1,
      debtCeiling: 0,
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
}
