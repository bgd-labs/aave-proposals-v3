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
 * @title Onboard syrupUSDT to Aave V3 Plasma Instance
 * @author Aave-chan Initiative
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-syrupusdt-to-aave-v3-plasma-instance/23204
 */
contract AaveV3Plasma_OnboardSyrupUSDTToAaveV3PlasmaInstance_20251016 is AaveV3PayloadPlasma {
  using SafeERC20 for IERC20;

  address public constant syrupUSDT = 0xC4374775489CB9C56003BF2C9b12495fC64F0771;
  uint256 public constant syrupUSDT_SEED_AMOUNT = 100e6;
  address public constant syrupUSDT_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(syrupUSDT).forceApprove(address(AaveV3Plasma.POOL), syrupUSDT_SEED_AMOUNT);
    AaveV3Plasma.POOL.supply(syrupUSDT, syrupUSDT_SEED_AMOUNT, AaveV3Plasma.DUST_BIN, 0);

    address asyrupUSDT = AaveV3Plasma.POOL.getReserveAToken(syrupUSDT);
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(syrupUSDT, syrupUSDT_LM_ADMIN);
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(
      asyrupUSDT,
      syrupUSDT_LM_ADMIN
    );
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_SyrupUSDTUSDT0 = new address[](1);
    address[] memory borrowableAssets_SyrupUSDTUSDT0 = new address[](1);

    collateralAssets_SyrupUSDTUSDT0[0] = syrupUSDT;
    borrowableAssets_SyrupUSDTUSDT0[0] = AaveV3PlasmaAssets.USDT0_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 92_00,
      liqBonus: 4_00,
      label: 'syrupUSDT/USDT0',
      collaterals: collateralAssets_SyrupUSDTUSDT0,
      borrowables: borrowableAssets_SyrupUSDTUSDT0
    });

    return eModeCreations;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: syrupUSDT,
      assetSymbol: 'syrupUSDT',
      priceFeed: 0x0A3F8218a98337Ef37dCAE4F8a8cfaB0711C64cF,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 6_00,
      reserveFactor: 45_00,
      supplyCap: 150_000_000,
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
