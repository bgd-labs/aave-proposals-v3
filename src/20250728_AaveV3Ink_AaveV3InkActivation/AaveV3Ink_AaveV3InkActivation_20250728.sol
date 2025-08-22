// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {AaveV3PayloadInkWhitelabel} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadInkWhitelabel.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

/**
 * @title Aave V3 Ink Activation
 * @author BGD Labs (@bgdlabs)
 */
contract AaveV3Ink_AaveV3InkActivation_20250728 is AaveV3PayloadInkWhitelabel {
  using SafeERC20 for IERC20;

  address public constant WETH = 0x4200000000000000000000000000000000000006;
  uint256 public constant WETH_SEED_AMOUNT = 0.005e18;

  address public constant KBTC = 0x73E0C0d45E048D25Fc26Fa3159b0aA04BfA4Db98;
  uint256 public constant KBTC_SEED_AMOUNT = 0.001e8;

  address public constant USDT = 0x0200C29006150606B650577BBE7B6248F58470c1;
  uint256 public constant USDT_SEED_AMOUNT = 10e6;

  address public constant USDG = 0xe343167631d89B6Ffc58B88d6b7fB0228795491D;
  uint256 public constant USDG_SEED_AMOUNT = 10e6;

  address public constant LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(WETH, WETH_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(KBTC, KBTC_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(USDT, USDT_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(USDG, USDG_SEED_AMOUNT);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](4);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: WETH,
      assetSymbol: 'WETH',
      priceFeed: 0x163131609562E578754aF12E998635BfCa56712C,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 80_00,
      liqThreshold: 83_00,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 32_000,
      borrowCap: 1_500,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 2_70,
        variableRateSlope2: 40_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: KBTC,
      assetSymbol: 'KBTC',
      priceFeed: 0xAe48F22903d43f13f66Cc650F57Bd4654ac222cb,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 72_00,
      liqThreshold: 77_00,
      liqBonus: 7_50,
      reserveFactor: 50_00,
      supplyCap: 350,
      borrowCap: 10,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 4_00,
        variableRateSlope2: 80_00
      })
    });
    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: USDT,
      assetSymbol: 'USDT',
      priceFeed: 0x24FdD142b34C6B5D55299709DB0966681933c9aF,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 190_000_000,
      borrowCap: 6_000_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_50,
        variableRateSlope2: 40_00
      })
    });
    listings[3] = IAaveV3ConfigEngine.Listing({
      asset: USDG,
      assetSymbol: 'USDG',
      priceFeed: 0x38758C93672A9F3F4297016BE4Ac1aCA70DcE82A,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 20_000_000,
      borrowCap: 1_600_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 80_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_50,
        variableRateSlope2: 50_00
      })
    });

    return listings;
  }

  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount) internal {
    IERC20(asset).forceApprove(address(AaveV3InkWhitelabel.POOL), seedAmount);
    AaveV3InkWhitelabel.POOL.supply(asset, seedAmount, address(AaveV3InkWhitelabel.DUST_BIN), 0);

    address aToken = AaveV3InkWhitelabel.POOL.getReserveAToken(asset);
    IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).setEmissionAdmin(asset, LM_ADMIN);
    IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).setEmissionAdmin(aToken, LM_ADMIN);
  }
}
