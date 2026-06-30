// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Monad} from 'aave-address-book/AaveV3Monad.sol';
import {AaveV3PayloadMonad} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadMonad.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title AaveV3MonadActivation
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-protocol-on-monad/24943
 */
contract AaveV3Monad_AaveV3MonadActivation_20260623 is AaveV3PayloadMonad {
  using SafeERC20 for IERC20;

  // https://monadscan.com/address/0x98217A06721Ebf727f2C8d9aD7718ec28b7aAe34
  address public constant RISK_STEWARD = 0x98217A06721Ebf727f2C8d9aD7718ec28b7aAe34;

  // https://monadscan.com/address/0xe7cd86e13AC4309349F30B3435a9d337750fC82D
  address public constant USDT0 = 0xe7cd86e13AC4309349F30B3435a9d337750fC82D;
  uint256 public constant USDT0_SEED_AMOUNT = 100e6;
  // https://monadscan.com/address/0x3c187a25f0f05E009DA794069682653e40062730
  address public constant USDT0_PRICE_FEED = 0x3c187a25f0f05E009DA794069682653e40062730;

  // https://monadscan.com/address/0x754704Bc059F8C67012fEd69BC8A327a5aafb603
  address public constant USDC = 0x754704Bc059F8C67012fEd69BC8A327a5aafb603;
  uint256 public constant USDC_SEED_AMOUNT = 100e6;
  // https://monadscan.com/address/0x787962943811D279d01eC973Bd3A15f1b3e1F0D9
  address public constant USDC_PRICE_FEED = 0x787962943811D279d01eC973Bd3A15f1b3e1F0D9;

  // https://monadscan.com/address/0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34
  address public constant USDe = 0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34;
  uint256 public constant USDe_SEED_AMOUNT = 100e18;
  // https://monadscan.com/address/0x3abA25B23378A84FD7638E20F9Af86A66000f090
  address public constant USDe_PRICE_FEED = 0x3abA25B23378A84FD7638E20F9Af86A66000f090;

  // https://monadscan.com/address/0xacA92E438df0B2401fF60dA7E4337B687a2435DA
  address public constant mUSD = 0xacA92E438df0B2401fF60dA7E4337B687a2435DA;
  uint256 public constant mUSD_SEED_AMOUNT = 100e6;
  // https://monadscan.com/address/0xbbb58AA3a251c9f19653771c44481c39500b71A3
  address public constant mUSD_PRICE_FEED = 0xbbb58AA3a251c9f19653771c44481c39500b71A3;

  // https://monadscan.com/address/0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a
  address public constant AUSD = 0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a;
  uint256 public constant AUSD_SEED_AMOUNT = 100e6;
  // https://monadscan.com/address/0x6b7c151653c35845a5826b15435fc055A9Db1D0C
  address public constant AUSD_PRICE_FEED = 0x6b7c151653c35845a5826b15435fc055A9Db1D0C;

  // https://monadscan.com/address/0xEE8c0E9f1BFFb4Eb878d8f15f368A02a35481242
  address public constant WETH = 0xEE8c0E9f1BFFb4Eb878d8f15f368A02a35481242;
  uint256 public constant WETH_SEED_AMOUNT = 0.0025e18;
  // https://monadscan.com/address/0x47F1D18329Ae59341617B7a5BE59605B63f0e373
  address public constant WETH_PRICE_FEED = 0x47F1D18329Ae59341617B7a5BE59605B63f0e373;

  // https://monadscan.com/address/0xd18B7EC58Cdf4876f6AFebd3Ed1730e4Ce10414b
  address public constant cbBTC = 0xd18B7EC58Cdf4876f6AFebd3Ed1730e4Ce10414b;
  uint256 public constant cbBTC_SEED_AMOUNT = 0.0005e8;
  // https://monadscan.com/address/0x48692d15DA2636E1b0335344104Ce9d92f231DdA
  address public constant cbBTC_PRICE_FEED = 0x48692d15DA2636E1b0335344104Ce9d92f231DdA;

  // https://monadscan.com/address/0x10Aeaf63194db8d453d4D85a06E5eFE1dd0b5417
  address public constant wstETH = 0x10Aeaf63194db8d453d4D85a06E5eFE1dd0b5417;
  uint256 public constant wstETH_SEED_AMOUNT = 0.0025e18;
  // https://monadscan.com/address/0x7c1DbD7879C421ebd1A2dE397Ea6Bedb5D3795A5
  address public constant wstETH_PRICE_FEED = 0x7c1DbD7879C421ebd1A2dE397Ea6Bedb5D3795A5;

  // https://monadscan.com/address/0xA3D68b74bF0528fdD07263c60d6488749044914b
  address public constant weETH = 0xA3D68b74bF0528fdD07263c60d6488749044914b;
  uint256 public constant weETH_SEED_AMOUNT = 0.0025e18;
  // https://monadscan.com/address/0x53E2d62Cd8c36104DEC69bA0CB3Bb599d6D42FE1
  address public constant weETH_PRICE_FEED = 0x53E2d62Cd8c36104DEC69bA0CB3Bb599d6D42FE1;

  // https://monadscan.com/address/0xaB6e5a0C3799d020c790D34F7B2C02639e238AF7
  address public constant syrupUSDC = 0xaB6e5a0C3799d020c790D34F7B2C02639e238AF7;
  uint256 public constant syrupUSDC_SEED_AMOUNT = 100e6;
  // https://monadscan.com/address/0xB1f36c815761a3F77CE26c013F646cdCdCd06384
  address public constant syrupUSDC_PRICE_FEED = 0xB1f36c815761a3F77CE26c013F646cdCdCd06384;

  // https://monadscan.com/address/0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2
  address public constant sUSDe = 0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2;
  uint256 public constant sUSDe_SEED_AMOUNT = 100e18;
  // https://monadscan.com/address/0x99946Fe1a49D8650a31eFE0fcFee0508892742f0
  address public constant sUSDe_PRICE_FEED = 0x99946Fe1a49D8650a31eFE0fcFee0508892742f0;

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](11);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDT0,
      assetSymbol: 'USDT0',
      priceFeed: USDT0_PRICE_FEED,
      enabledToBorrow: EngineFlags.ENABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 7_50,
      reserveFactor: 10_00,
      supplyCap: 100_000_000,
      borrowCap: 100_000_000,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 4_00,
        variableRateSlope2: 40_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: USDC,
      assetSymbol: 'USDC',
      priceFeed: USDC_PRICE_FEED,
      enabledToBorrow: EngineFlags.ENABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 7_50,
      reserveFactor: 10_00,
      supplyCap: 75_000_000,
      borrowCap: 50_000_000,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 4_00,
        variableRateSlope2: 40_00
      })
    });
    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: USDe,
      assetSymbol: 'USDe',
      priceFeed: USDe_PRICE_FEED,
      enabledToBorrow: EngineFlags.ENABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 25_00,
      supplyCap: 60_000_000,
      borrowCap: 50_000_000,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 4_00,
        variableRateSlope2: 40_00
      })
    });
    listings[3] = IAaveV3ConfigEngine.Listing({
      asset: mUSD,
      assetSymbol: 'mUSD',
      priceFeed: mUSD_PRICE_FEED,
      enabledToBorrow: EngineFlags.ENABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 100_000_000,
      borrowCap: 50_000_000,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 80_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 4_00,
        variableRateSlope2: 40_00
      })
    });
    listings[4] = IAaveV3ConfigEngine.Listing({
      asset: AUSD,
      assetSymbol: 'AUSD',
      priceFeed: AUSD_PRICE_FEED,
      enabledToBorrow: EngineFlags.ENABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 20_000_000,
      borrowCap: 18_000_000,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 80_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 4_00,
        variableRateSlope2: 40_00
      })
    });
    listings[5] = IAaveV3ConfigEngine.Listing({
      asset: WETH,
      assetSymbol: 'WETH',
      priceFeed: WETH_PRICE_FEED,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 80_50,
      liqThreshold: 84_00,
      liqBonus: 5_50,
      reserveFactor: 15_00,
      supplyCap: 40_000,
      borrowCap: 36_000,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 2_20,
        variableRateSlope2: 20_00
      })
    });
    listings[6] = IAaveV3ConfigEngine.Listing({
      asset: cbBTC,
      assetSymbol: 'cbBTC',
      priceFeed: cbBTC_PRICE_FEED,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 73_00,
      liqThreshold: 78_00,
      liqBonus: 7_00,
      reserveFactor: 7_00,
      supplyCap: 1_000,
      borrowCap: 1,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });
    listings[7] = IAaveV3ConfigEngine.Listing({
      asset: wstETH,
      assetSymbol: 'wstETH',
      priceFeed: wstETH_PRICE_FEED,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 5_00,
      supplyCap: 35_000,
      borrowCap: 1,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });
    listings[8] = IAaveV3ConfigEngine.Listing({
      asset: weETH,
      assetSymbol: 'weETH',
      priceFeed: weETH_PRICE_FEED,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 45_00,
      supplyCap: 30_000,
      borrowCap: 1,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });
    listings[9] = IAaveV3ConfigEngine.Listing({
      asset: syrupUSDC,
      assetSymbol: 'syrupUSDC',
      priceFeed: syrupUSDC_PRICE_FEED,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 40_000_000,
      borrowCap: 1,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });
    listings[10] = IAaveV3ConfigEngine.Listing({
      asset: sUSDe,
      assetSymbol: 'sUSDe',
      priceFeed: sUSDe_PRICE_FEED,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 60_000_000,
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
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](4);

    address[] memory collateralAssets_syrupUSDC__Stablecoins = new address[](1);
    address[] memory borrowableAssets_syrupUSDC__Stablecoins = new address[](4);

    collateralAssets_syrupUSDC__Stablecoins[0] = syrupUSDC;
    borrowableAssets_syrupUSDC__Stablecoins[0] = USDT0;
    borrowableAssets_syrupUSDC__Stablecoins[1] = USDC;
    borrowableAssets_syrupUSDC__Stablecoins[2] = mUSD;
    borrowableAssets_syrupUSDC__Stablecoins[3] = AUSD;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 92_00,
      liqBonus: 4_00,
      label: 'syrupUSDC__Stablecoins',
      isolated: false,
      collaterals: collateralAssets_syrupUSDC__Stablecoins,
      borrowables: borrowableAssets_syrupUSDC__Stablecoins
    });

    address[] memory collateralAssets_USDe_sUSDe__Stablecoins = new address[](2);
    address[] memory borrowableAssets_USDe_sUSDe__Stablecoins = new address[](3);

    collateralAssets_USDe_sUSDe__Stablecoins[0] = USDe;
    collateralAssets_USDe_sUSDe__Stablecoins[1] = sUSDe;
    borrowableAssets_USDe_sUSDe__Stablecoins[0] = USDT0;
    borrowableAssets_USDe_sUSDe__Stablecoins[1] = USDC;
    borrowableAssets_USDe_sUSDe__Stablecoins[2] = AUSD;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 92_00,
      liqBonus: 4_00,
      label: 'USDe_sUSDe__Stablecoins',
      isolated: false,
      collaterals: collateralAssets_USDe_sUSDe__Stablecoins,
      borrowables: borrowableAssets_USDe_sUSDe__Stablecoins
    });

    address[] memory collateralAssets_wstETH__WETH = new address[](1);
    address[] memory borrowableAssets_wstETH__WETH = new address[](1);

    collateralAssets_wstETH__WETH[0] = wstETH;
    borrowableAssets_wstETH__WETH[0] = WETH;

    eModeCreations[2] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 94_00,
      liqThreshold: 96_00,
      liqBonus: 1_00,
      label: 'wstETH__WETH',
      isolated: true,
      collaterals: collateralAssets_wstETH__WETH,
      borrowables: borrowableAssets_wstETH__WETH
    });

    address[] memory collateralAssets_weETH__WETH = new address[](1);
    address[] memory borrowableAssets_weETH__WETH = new address[](1);

    collateralAssets_weETH__WETH[0] = weETH;
    borrowableAssets_weETH__WETH[0] = WETH;

    eModeCreations[3] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'weETH__WETH',
      isolated: true,
      collaterals: collateralAssets_weETH__WETH,
      borrowables: borrowableAssets_weETH__WETH
    });

    return eModeCreations;
  }

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(USDT0, USDT0_SEED_AMOUNT, address(0));

    _supplyAndConfigureLMAdmin(USDC, USDC_SEED_AMOUNT, address(0));

    _supplyAndConfigureLMAdmin(USDe, USDe_SEED_AMOUNT, address(0));

    _supplyAndConfigureLMAdmin(mUSD, mUSD_SEED_AMOUNT, address(0));

    _supplyAndConfigureLMAdmin(AUSD, AUSD_SEED_AMOUNT, address(0));

    _supplyAndConfigureLMAdmin(WETH, WETH_SEED_AMOUNT, address(0));

    _supplyAndConfigureLMAdmin(cbBTC, cbBTC_SEED_AMOUNT, address(0));

    _supplyAndConfigureLMAdmin(wstETH, wstETH_SEED_AMOUNT, address(0));

    _supplyAndConfigureLMAdmin(weETH, weETH_SEED_AMOUNT, address(0));

    _supplyAndConfigureLMAdmin(syrupUSDC, syrupUSDC_SEED_AMOUNT, address(0));

    _supplyAndConfigureLMAdmin(sUSDe, sUSDe_SEED_AMOUNT, address(0));

    AaveV3Monad.ACL_MANAGER.addRiskAdmin(RISK_STEWARD);
  }

  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount, address lmAdmin) internal {
    IERC20(asset).forceApprove(address(AaveV3Monad.POOL), seedAmount);
    AaveV3Monad.POOL.supply(asset, seedAmount, address(AaveV3Monad.DUST_BIN), 0);

    if (lmAdmin != address(0)) {
      address aToken = AaveV3Monad.POOL.getReserveAToken(asset);
      address vToken = AaveV3Monad.POOL.getReserveVariableDebtToken(asset);
      IEmissionManager(AaveV3Monad.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3Monad.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
      IEmissionManager(AaveV3Monad.EMISSION_MANAGER).setEmissionAdmin(vToken, lmAdmin);
    }
  }
}
