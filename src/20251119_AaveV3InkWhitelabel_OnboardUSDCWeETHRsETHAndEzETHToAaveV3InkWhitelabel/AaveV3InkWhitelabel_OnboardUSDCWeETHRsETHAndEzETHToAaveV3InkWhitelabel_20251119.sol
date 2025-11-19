// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabel, AaveV3InkWhitelabelAssets} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {AaveV3PayloadInkWhitelabel} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadInkWhitelabel.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Onboard USDC, weETH, rsETH and ezETH to AaveV3InkWhitelabel
 * @author ACI
 */
contract AaveV3InkWhitelabel_OnboardUSDCWeETHRsETHAndEzETHToAaveV3InkWhitelabel_20251119 is
  AaveV3PayloadInkWhitelabel
{
  using SafeERC20 for IERC20;

  address public constant USDC = 0x2D270e6886d130D724215A266106e6832161EAEd;
  uint256 public constant USDC_SEED_AMOUNT = 100 * 1e6;
  address public constant USDC_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  address public constant weETH = 0xA3D68b74bF0528fdD07263c60d6488749044914b;
  uint256 public constant weETH_SEED_AMOUNT = 0.03 * 1e18;
  address public constant weETH_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  address public constant rsETH = 0xc3eACf0612346366Db554C991D7858716db09f58;
  uint256 public constant rsETH_SEED_AMOUNT = 0.03 * 1e18;
  address public constant rsETH_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  address public constant ezETH = 0x2416092f143378750bb29b79eD961ab195CcEea5;
  uint256 public constant ezETH_SEED_AMOUNT = 0.03 * 1e18;
  address public constant ezETH_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(USDC, USDC_SEED_AMOUNT, USDC_LM_ADMIN);

    _supplyAndConfigureLMAdmin(weETH, weETH_SEED_AMOUNT, weETH_LM_ADMIN);

    _supplyAndConfigureLMAdmin(rsETH, rsETH_SEED_AMOUNT, rsETH_LM_ADMIN);

    _supplyAndConfigureLMAdmin(ezETH, ezETH_SEED_AMOUNT, ezETH_LM_ADMIN);
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_LRTMain = new address[](3);
    address[] memory borrowableAssets_LRTMain = new address[](1);

    collateralAssets_LRTMain[0] = weETH;
    collateralAssets_LRTMain[1] = rsETH;
    collateralAssets_LRTMain[2] = ezETH;
    borrowableAssets_LRTMain[0] = USDC;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'LRT Main',
      collaterals: collateralAssets_LRTMain,
      borrowables: borrowableAssets_LRTMain
    });

    return eModeCreations;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](4);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDC,
      assetSymbol: 'USDC',
      priceFeed: 0xd910061259A256B99654Cff414c3bfD503E7F6ea,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 10_000_000,
      borrowCap: 9_500_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_50,
        variableRateSlope2: 40_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: weETH,
      assetSymbol: 'weETH',
      priceFeed: 0x68B7Ed7Df658Ed065BcaA415f0Ce0b057Dfcf318,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 10_00,
      reserveFactor: 10_00,
      supplyCap: 6_000,
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
    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: rsETH,
      assetSymbol: 'rsETH',
      priceFeed: 0x771a1668f973f2485D32580aB53F5C4934e81531,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 10_00,
      reserveFactor: 10_00,
      supplyCap: 6_000,
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
    listings[3] = IAaveV3ConfigEngine.Listing({
      asset: ezETH,
      assetSymbol: 'ezETH',
      priceFeed: 0x51e5242698Cf425A558BCe440357Fd20f00D9671,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 10_00,
      reserveFactor: 10_00,
      supplyCap: 6_000,
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
    IERC20(asset).forceApprove(address(AaveV3InkWhitelabel.POOL), seedAmount);
    AaveV3InkWhitelabel.POOL.supply(asset, seedAmount, address(AaveV3InkWhitelabel.DUST_BIN), 0);

    if (lmAdmin != address(0)) {
      address aToken = AaveV3InkWhitelabel.POOL.getReserveAToken(asset);
      IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
    }
  }
}
