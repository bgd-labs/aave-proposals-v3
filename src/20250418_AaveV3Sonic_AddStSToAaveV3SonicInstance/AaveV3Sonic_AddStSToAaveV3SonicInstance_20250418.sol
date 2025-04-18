// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Sonic, AaveV3SonicAssets} from 'aave-address-book/AaveV3Sonic.sol';
import {AaveV3PayloadSonic} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadSonic.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Add stS to Aave v3 Sonic Instance
 * @author Aave-Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xb49491fa374865c309723a992da4d2b1f24e96f310b8842a01cf6215a48e5c6d
 * - Discussion: https://governance.aave.com/t/arfc-add-sts-to-aave-v3-sonic-instance/21445
 */
contract AaveV3Sonic_AddStSToAaveV3SonicInstance_20250418 is AaveV3PayloadSonic {
  using SafeERC20 for IERC20;

  address public constant stS = 0xE5DA20F15420aD15DE0fa650600aFc998bbE3955;
  uint256 public constant stS_SEED_AMOUNT = 200e18;
  address public constant stS_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(stS).forceApprove(address(AaveV3Sonic.POOL), stS_SEED_AMOUNT);
    AaveV3Sonic.POOL.supply(stS, stS_SEED_AMOUNT, AaveV3Sonic.DUST_BIN, 0);

    address astS = AaveV3Sonic.POOL.getReserveAToken(stS);
    IEmissionManager(AaveV3Sonic.EMISSION_MANAGER).setEmissionAdmin(stS, stS_LM_ADMIN);
    IEmissionManager(AaveV3Sonic.EMISSION_MANAGER).setEmissionAdmin(astS, stS_LM_ADMIN);
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
      eModeCategory: 1,
      ltv: 87_00,
      liqThreshold: 90_00,
      liqBonus: 1_00,
      label: 'stS/wS'
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
      asset: stS,
      eModeCategory: 1,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3SonicAssets.wS_UNDERLYING,
      eModeCategory: 1,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: stS,
      assetSymbol: 'stS',
      priceFeed: 0x5BA5D5213B47DFE020B1F8d6fB54Db3F74F9ea9a,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 66_00,
      liqThreshold: 68_00,
      liqBonus: 10_00,
      reserveFactor: 10_00,
      supplyCap: 30_000_000,
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
