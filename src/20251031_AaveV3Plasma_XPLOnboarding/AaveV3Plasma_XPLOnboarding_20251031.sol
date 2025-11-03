// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {AaveV3PayloadPlasma} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadPlasma.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title XPL Onboarding
 * @author ACI
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-xpl-on-aave-v3-plasma-instance/23197
 */
contract AaveV3Plasma_XPLOnboarding_20251031 is AaveV3PayloadPlasma {
  using SafeERC20 for IERC20;

  address public constant WXPL = 0x6100E367285b01F48D07953803A2d8dCA5D19873;
  uint256 public constant WXPL_SEED_AMOUNT = 350e18;
  address public constant WXPL_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(WXPL, WXPL_SEED_AMOUNT, WXPL_LM_ADMIN);
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_XplUsdt0 = new address[](1);
    address[] memory borrowableAssets_XplUsdt0 = new address[](1);

    collateralAssets_XplUsdt0[0] = WXPL;
    borrowableAssets_XplUsdt0[0] = AaveV3PlasmaAssets.USDT0_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 50_00,
      liqThreshold: 55_00,
      liqBonus: 10_00,
      label: 'WXPL__Stablecoins',
      collaterals: collateralAssets_XplUsdt0,
      borrowables: borrowableAssets_XplUsdt0
    });

    return eModeCreations;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: WXPL,
      assetSymbol: 'XPL',
      priceFeed: 0xF932477C37715aE6657Ab884414Bd9876FE3f750,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 10_00,
      reserveFactor: 10_00,
      supplyCap: 14_000_000,
      borrowCap: 1,
      debtCeiling: 1,
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
  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount, address lmAdmin) internal {
    IERC20(asset).forceApprove(address(AaveV3Plasma.POOL), seedAmount);
    AaveV3Plasma.POOL.supply(asset, seedAmount, address(AaveV3Plasma.DUST_BIN), 0);

    if (lmAdmin != address(0)) {
      address aToken = AaveV3Plasma.POOL.getReserveAToken(asset);
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
    }
  }
}
