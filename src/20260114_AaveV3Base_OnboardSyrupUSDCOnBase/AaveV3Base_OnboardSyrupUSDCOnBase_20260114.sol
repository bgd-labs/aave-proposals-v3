// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3PayloadBase} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBase.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Onboard syrupUSDC on Base
 * @author Maple Finance (implemented by Aavechan Initiative @aci via Skyward)
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-syrupusdc-to-aave-v3-base-instance/23234
 */
contract AaveV3Base_OnboardSyrupUSDCOnBase_20260114 is AaveV3PayloadBase {
  using SafeERC20 for IERC20;

  address public constant syrupUSDC = 0x660975730059246A68521a3e2FBD4740173100f5;
  uint256 public constant syrupUSDC_SEED_AMOUNT = 100e6;
  address public constant syrupUSDC_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(syrupUSDC, syrupUSDC_SEED_AMOUNT, syrupUSDC_LM_ADMIN);
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_SyrupUSDC__USDC_GHO = new address[](1);
    address[] memory borrowableAssets_SyrupUSDC__USDC_GHO = new address[](2);

    collateralAssets_SyrupUSDC__USDC_GHO[0] = syrupUSDC;
    borrowableAssets_SyrupUSDC__USDC_GHO[0] = AaveV3BaseAssets.USDC_UNDERLYING;
    borrowableAssets_SyrupUSDC__USDC_GHO[1] = AaveV3BaseAssets.GHO_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 92_00,
      liqBonus: 4_00,
      label: 'SyrupUSDC__USDC_GHO',
      collaterals: collateralAssets_SyrupUSDC__USDC_GHO,
      borrowables: borrowableAssets_SyrupUSDC__USDC_GHO
    });

    return eModeCreations;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: syrupUSDC,
      assetSymbol: 'syrupUSDC',
      priceFeed: 0xa61f10Bb2f05A94728734A8a95673ADbCA9B8397,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 50_00,
      supplyCap: 50_000_000,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount, address lmAdmin) internal {
    IERC20(asset).forceApprove(address(AaveV3Base.POOL), seedAmount);
    AaveV3Base.POOL.supply(asset, seedAmount, address(AaveV3Base.DUST_BIN), 0);

    if (lmAdmin != address(0)) {
      address aToken = AaveV3Base.POOL.getReserveAToken(asset);
      IEmissionManager(AaveV3Base.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3Base.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
    }
  }
}
