// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Sonic} from 'aave-address-book/AaveV3Sonic.sol';
import {AaveV3PayloadSonic} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadSonic.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

/**
 * @title Aave V3.3 Sonic Activation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x8d41750cae27326ac50a84a25846747baeb99c57d371c536ec9219ff662f7497
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-v3-on-sonic/20543/3
 */
contract AaveV3Sonic_AaveV33SonicActivation_20250217 is AaveV3PayloadSonic {
  using SafeERC20 for IERC20;

  address public constant WETH = 0x50c42dEAcD8Fc9773493ED674b675bE577f2634b;
  uint256 public constant WETH_SEED_AMOUNT = 0.025e18;

  address public constant USDC = 0x29219dd400f2Bf60E5a23d13Be72B486D4038894;
  uint256 public constant USDC_SEED_AMOUNT = 1e6;

  address public constant wS = 0x039e2fB66102314Ce7b64Ce5Ce3E5183bc94aD38;
  uint256 public constant wS_SEED_AMOUNT = 1e18;

  function _postExecute() internal override {
    IERC20(WETH).forceApprove(address(AaveV3Sonic.POOL), WETH_SEED_AMOUNT);
    AaveV3Sonic.POOL.supply(WETH, WETH_SEED_AMOUNT, address(AaveV3Sonic.COLLECTOR), 0);

    IERC20(USDC).forceApprove(address(AaveV3Sonic.POOL), USDC_SEED_AMOUNT);
    AaveV3Sonic.POOL.supply(USDC, USDC_SEED_AMOUNT, address(AaveV3Sonic.COLLECTOR), 0);

    IERC20(wS).forceApprove(address(AaveV3Sonic.POOL), wS_SEED_AMOUNT);
    AaveV3Sonic.POOL.supply(wS, wS_SEED_AMOUNT, address(AaveV3Sonic.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](3);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: WETH,
      assetSymbol: 'WETH',
      priceFeed: 0x824364077993847f71293B24ccA8567c00c2de11,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 80_00,
      liqThreshold: 83_00,
      liqBonus: 6_00,
      reserveFactor: 15_00,
      supplyCap: 400,
      borrowCap: 370,
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
      asset: USDC,
      assetSymbol: 'USDC',
      priceFeed: 0x7A8443a2a5D772db7f1E40DeFe32db485108F128,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 2_000_000,
      borrowCap: 1_900_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 9_50,
        variableRateSlope2: 40_00
      })
    });
    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: wS,
      assetSymbol: 'wS',
      priceFeed: 0xc76dFb89fF298145b417d221B2c747d84952e01d,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 35_00,
      liqThreshold: 40_00,
      liqBonus: 10_00,
      reserveFactor: 20_00,
      supplyCap: 3_000_000,
      borrowCap: 1_500_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 7_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
}
