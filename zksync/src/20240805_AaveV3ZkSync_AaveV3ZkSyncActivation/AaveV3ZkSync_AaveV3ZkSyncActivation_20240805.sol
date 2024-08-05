// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';
import {AaveV3PayloadZkSync} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadZkSync.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title Aave v3 zkSync Activation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb74537a0528f484e9cc76d8c7931eedef7b6290e7d2dc725b2c98e623a214f95
 * - Discussion: https://governance.aave.com/t/arfc-deployment-of-aave-on-zksync/17937
 */
contract AaveV3ZkSync_AaveV3ZkSyncActivation_20240805 is AaveV3PayloadZkSync {
  using SafeERC20 for IERC20;

  address public constant USDC = 0x1d17CBcF0D6D143135aE902365D2E5e2A16538D4;
  uint256 public constant USDC_SEED_AMOUNT = 10e6;
  address public constant USDT = 0x493257fD37EDB34451f62EDf8D2a0C418852bA4C;
  uint256 public constant USDT_SEED_AMOUNT = 10e6;
  address public constant WETH = 0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91;
  uint256 public constant WETH_SEED_AMOUNT = 0.01 ether;
  address public constant wstETH = 0x703b52F2b28fEbcB60E1372858AF5b18849FE867;
  uint256 public constant wstETH_SEED_AMOUNT = 0.01 ether;
  address public constant ZK = 0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E;
  uint256 public constant ZK_SEED_AMOUNT = 10 ether;

  function _postExecute() internal override {
    IERC20(USDC).forceApprove(address(AaveV3ZkSync.POOL), USDC_SEED_AMOUNT);
    AaveV3ZkSync.POOL.supply(USDC, USDC_SEED_AMOUNT, address(AaveV3ZkSync.COLLECTOR), 0);
    IERC20(USDT).forceApprove(address(AaveV3ZkSync.POOL), USDT_SEED_AMOUNT);
    AaveV3ZkSync.POOL.supply(USDT, USDT_SEED_AMOUNT, address(AaveV3ZkSync.COLLECTOR), 0);
    IERC20(WETH).forceApprove(address(AaveV3ZkSync.POOL), WETH_SEED_AMOUNT);
    AaveV3ZkSync.POOL.supply(WETH, WETH_SEED_AMOUNT, address(AaveV3ZkSync.COLLECTOR), 0);
    IERC20(wstETH).forceApprove(address(AaveV3ZkSync.POOL), wstETH_SEED_AMOUNT);
    AaveV3ZkSync.POOL.supply(wstETH, wstETH_SEED_AMOUNT, address(AaveV3ZkSync.COLLECTOR), 0);
    IERC20(ZK).forceApprove(address(AaveV3ZkSync.POOL), ZK_SEED_AMOUNT);
    AaveV3ZkSync.POOL.supply(ZK, ZK_SEED_AMOUNT, address(AaveV3ZkSync.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](5);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDC,
      assetSymbol: 'USDC',
      priceFeed: 0xA715ED3eC1C078EEf8437Cf717Cf76004f29eAED,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 1_000_000,
      borrowCap: 900_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 9_00,
        variableRateSlope2: 75_00
      })
    });

    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: USDT,
      assetSymbol: 'USDT',
      priceFeed: 0x336EC4bcb65C1A141318fBd3f8E7379c085E8B15,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 3_000_000,
      borrowCap: 2_700_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 9_00,
        variableRateSlope2: 75_00
      })
    });

    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: WETH,
      assetSymbol: 'WETH',
      priceFeed: 0x6D41d1dc818112880b40e26BD6FD347E41008eDA,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 6_00,
      reserveFactor: 15_00,
      supplyCap: 1_000,
      borrowCap: 800,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 80_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 3_30,
        variableRateSlope2: 80_00
      })
    });

    listings[3] = IAaveV3ConfigEngine.Listing({
      asset: wstETH,
      assetSymbol: 'wstETH',
      priceFeed: 0x624FEc7DDeb62Dcbce1fc456D7cc5c6A47cC69aF,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 71_00,
      liqThreshold: 76_00,
      liqBonus: 7_00,
      reserveFactor: 15_00,
      supplyCap: 500,
      borrowCap: 50,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 4_50,
        variableRateSlope2: 80_00
      })
    });

    listings[4] = IAaveV3ConfigEngine.Listing({
      asset: ZK,
      assetSymbol: 'ZK',
      priceFeed: 0xD1ce60dc8AE060DDD17cA8716C96f193bC88DD13,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 40_00,
      liqThreshold: 45_00,
      liqBonus: 10_00,
      reserveFactor: 20_00,
      supplyCap: 24_000_000,
      borrowCap: 10_000_000,
      debtCeiling: 1_000_000,
      liqProtocolFee: 20_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 9_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
}
