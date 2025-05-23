// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Soneium} from 'aave-address-book/AaveV3Soneium.sol';
import {MiscSoneium} from 'aave-address-book/MiscSoneium.sol';
import {AaveV3PayloadSoneium} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadSoneium.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Aave V3.3 Soneium Activation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xb996bda7e60f85de7f6f2d9f7f6c15ddddfbd871465d8f00b846f8ab014a5953
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-on-soneium/21204/9
 */
contract AaveV3Soneium_AaveV33SoneiumActivation_20250518 is AaveV3PayloadSoneium {
  using SafeERC20 for IERC20;

  address public constant LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  address public constant USDCe = 0xbA9986D2381edf1DA03B0B9c1f8b00dc4AacC369;
  uint256 public constant USDCe_SEED_AMOUNT = 10e6;

  address public constant USDT = 0x3A337a6adA9d885b6Ad95ec48F9b75f197b5AE35;
  uint256 public constant USDT_SEED_AMOUNT = 10e6;

  address public constant WETH = 0x4200000000000000000000000000000000000006;
  uint256 public constant WETH_SEED_AMOUNT = 0.01e18;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(USDCe, USDCe_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(USDT, USDT_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(WETH, WETH_SEED_AMOUNT);

    AaveV3Soneium.ACL_MANAGER.addPoolAdmin(MiscSoneium.PROTOCOL_GUARDIAN);
    AaveV3Soneium.ACL_MANAGER.addRiskAdmin(AaveV3Soneium.RISK_STEWARD);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](3);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: WETH,
      assetSymbol: 'WETH',
      priceFeed: 0x291cF980BA12505D65ee01BDe0882F1d5e533525,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 80_00,
      liqThreshold: 83_00,
      liqBonus: 6_00,
      reserveFactor: 15_00,
      supplyCap: 800,
      borrowCap: 720,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 2_70,
        variableRateSlope2: 80_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: USDCe,
      assetSymbol: 'USDCe',
      priceFeed: 0xe9d6696fc74A8ef545D2c9C842f820763407E778,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 8_000_000,
      borrowCap: 7_200_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_50,
        variableRateSlope2: 40_00
      })
    });
    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: USDT,
      assetSymbol: 'USDT',
      priceFeed: 0x01bcEb741614D4388028EaF3284DCB04386c30D2,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 5_000_000,
      borrowCap: 4_500_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_50,
        variableRateSlope2: 40_00
      })
    });

    return listings;
  }

  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount) internal {
    IERC20(asset).forceApprove(address(AaveV3Soneium.POOL), seedAmount);
    AaveV3Soneium.POOL.supply(asset, seedAmount, address(AaveV3Soneium.DUST_BIN), 0);

    address aToken = AaveV3Soneium.POOL.getReserveAToken(asset);
    IEmissionManager(AaveV3Soneium.EMISSION_MANAGER).setEmissionAdmin(asset, LM_ADMIN);
    IEmissionManager(AaveV3Soneium.EMISSION_MANAGER).setEmissionAdmin(aToken, LM_ADMIN);
  }
}
