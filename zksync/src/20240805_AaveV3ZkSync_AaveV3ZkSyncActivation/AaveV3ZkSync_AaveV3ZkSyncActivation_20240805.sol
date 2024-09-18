// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync, IPool} from 'aave-address-book/AaveV3ZkSync.sol';
import {MiscZkSync} from 'aave-address-book/MiscZkSync.sol';
import {AaveV3PayloadZkSync} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadZkSync.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Aave v3 zkSync Activation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb74537a0528f484e9cc76d8c7931eedef7b6290e7d2dc725b2c98e623a214f95
 * - Discussion: https://governance.aave.com/t/arfc-deployment-of-aave-on-zksync/17937
 */
contract AaveV3ZkSync_AaveV3ZkSyncActivation_20240805 is AaveV3PayloadZkSync {
  using SafeERC20 for IERC20;

  address public constant USDC = 0x1d17CBcF0D6D143135aE902365D2E5e2A16538D4;
  uint256 public constant USDC_SEED_AMOUNT = 100e6;
  address public constant USDT = 0x493257fD37EDB34451f62EDf8D2a0C418852bA4C;
  uint256 public constant USDT_SEED_AMOUNT = 100e6;
  address public constant WETH = 0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91;
  uint256 public constant WETH_SEED_AMOUNT = 0.1 ether;
  address public constant wstETH = 0x703b52F2b28fEbcB60E1372858AF5b18849FE867;
  uint256 public constant wstETH_SEED_AMOUNT = 0.1 ether;
  address public constant ZK = 0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E;
  uint256 public constant ZK_SEED_AMOUNT = 1_000 ether;
  address public constant ACI_MULTISIG = 0x95Cbff6e45C499d45dd8627f3ce179057B5Fbfcc;

  function _postExecute() internal override {
    AaveV3ZkSync.ACL_MANAGER.addPoolAdmin(MiscZkSync.PROTOCOL_GUARDIAN);
    IEmissionManager(AaveV3ZkSync.EMISSION_MANAGER).setEmissionAdmin(ZK, ACI_MULTISIG);

    _supply(AaveV3ZkSync.POOL, USDC, USDC_SEED_AMOUNT, address(AaveV3ZkSync.COLLECTOR));
    _supply(AaveV3ZkSync.POOL, USDT, USDT_SEED_AMOUNT, address(AaveV3ZkSync.COLLECTOR));
    _supply(AaveV3ZkSync.POOL, WETH, WETH_SEED_AMOUNT, address(AaveV3ZkSync.COLLECTOR));
    _supply(AaveV3ZkSync.POOL, wstETH, wstETH_SEED_AMOUNT, address(AaveV3ZkSync.COLLECTOR));
    _supply(AaveV3ZkSync.POOL, ZK, ZK_SEED_AMOUNT, address(AaveV3ZkSync.COLLECTOR));
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
      ltv: 90_00,
      liqThreshold: 93_00,
      liqBonus: 1_00,
      priceSource: 0x0000000000000000000000000000000000000000,
      label: 'ETH correlated'
    });

    return eModeUpdates;
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](5);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDC,
      assetSymbol: 'USDC',
      priceFeed: 0x22A46593A7f93Aaec788bE3e27C1838E15781222,
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
      supplyCap: 10_000,
      borrowCap: 9_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_50,
        variableRateSlope2: 60_00
      })
    });

    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: USDT,
      assetSymbol: 'USDT',
      priceFeed: 0xE8D6d2dffCFfFc6b1f3606b7552e80319D01A8E9,
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
      supplyCap: 10_000,
      borrowCap: 9_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_50,
        variableRateSlope2: 60_00
      })
    });

    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: WETH,
      assetSymbol: 'WETH',
      priceFeed: 0x6D41d1dc818112880b40e26BD6FD347E41008eDA,
      eModeCategory: 1,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 6_00,
      reserveFactor: 15_00,
      supplyCap: 5,
      borrowCap: 4,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 2_70,
        variableRateSlope2: 80_00
      })
    });

    listings[3] = IAaveV3ConfigEngine.Listing({
      asset: wstETH,
      assetSymbol: 'wstETH',
      priceFeed: 0xdea7DE07B8275564Af6135F7E9340411246EB7A2,
      eModeCategory: 1,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 71_00,
      liqThreshold: 76_00,
      liqBonus: 7_00,
      reserveFactor: 5_00,
      supplyCap: 3,
      borrowCap: 1,
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
      supplyCap: 100_000,
      borrowCap: 55_000,
      debtCeiling: 800_000,
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

  function _supply(IPool pool, address asset, uint256 amount, address onBehalfOf) internal {
    IERC20(asset).forceApprove(address(pool), amount);
    pool.supply(asset, amount, onBehalfOf, 0);
  }
}
