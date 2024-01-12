// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadPolygonZkEvm} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygonZkEvm.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {AaveV3PolygonZkEvm} from 'aave-address-book/AaveV3PolygonZkEvm.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title Aave v3 Polygon ZkEvm activation
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x8fd34012029bec536f779b7bf46813beb57f42705b24acaf239e42353ddf7b8c
 * - Discussion: https://governance.aave.com/t/arfc-aave-v3-deployment-on-zkevm-l2/12615
 */
contract AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112 is AaveV3PayloadPolygonZkEvm {
  using SafeERC20 for IERC20;

  address public constant USDC = 0x37eAA0eF3549a5Bb7D431be78a3D99BD360d19e5;
  uint256 public constant USDC_SEED_AMOUNT = 10e6;
  address public constant WETH = 0x4F9A0e7FD2Bf6067db6994CF12E4495Df938E6e9;
  uint256 public constant WETH_SEED_AMOUNT = 0.005e18;
  address public constant MATIC = 0xa2036f0538221a77A3937F1379699f44945018d0;
  uint256 public constant MATIC_SEED_AMOUNT = 10e18;

  function _postExecute() internal override {
    IERC20(USDC).forceApprove(address(AaveV3PolygonZkEvm.POOL), USDC_SEED_AMOUNT);
    AaveV3PolygonZkEvm.POOL.supply(
      USDC,
      USDC_SEED_AMOUNT,
      address(AaveV3PolygonZkEvm.COLLECTOR),
      0
    );
    IERC20(WETH).forceApprove(address(AaveV3PolygonZkEvm.POOL), WETH_SEED_AMOUNT);
    AaveV3PolygonZkEvm.POOL.supply(
      WETH,
      WETH_SEED_AMOUNT,
      address(AaveV3PolygonZkEvm.COLLECTOR),
      0
    );
    IERC20(MATIC).forceApprove(address(AaveV3PolygonZkEvm.POOL), MATIC_SEED_AMOUNT);
    AaveV3PolygonZkEvm.POOL.supply(
      MATIC,
      MATIC_SEED_AMOUNT,
      address(AaveV3PolygonZkEvm.COLLECTOR),
      0
    );
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](3);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDC,
      assetSymbol: 'USDC',
      priceFeed: 0x0167D934CB7240e65c35e347F00Ca5b12567523a,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 77_00,
      liqThreshold: 80_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 525_000,
      borrowCap: 500_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(6_00),
        variableRateSlope2: _bpsToRay(80_00),
        stableRateSlope1: _bpsToRay(6_00),
        stableRateSlope2: _bpsToRay(80_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: WETH,
      assetSymbol: 'WETH',
      priceFeed: 0x97d9F9A00dEE0004BE8ca0A8fa374d486567eE2D,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 5_00,
      reserveFactor: 15_00,
      supplyCap: 350,
      borrowCap: 280,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(80_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(3_30),
        variableRateSlope2: _bpsToRay(80_00),
        stableRateSlope1: _bpsToRay(3_30),
        stableRateSlope2: _bpsToRay(80_00),
        baseStableRateOffset: _bpsToRay(2_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });
    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: MATIC,
      assetSymbol: 'MATIC',
      priceFeed: 0x7C85dD6eBc1d318E909F22d51e756Cf066643341,
      eModeCategory: 0,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 68_00,
      liqThreshold: 73_00,
      liqBonus: 7_50,
      reserveFactor: 20_00,
      supplyCap: 700_000,
      borrowCap: 525_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(75_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(5_00),
        variableRateSlope2: _bpsToRay(100_00),
        stableRateSlope1: _bpsToRay(5_00),
        stableRateSlope2: _bpsToRay(100_00),
        baseStableRateOffset: _bpsToRay(2_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });

    return listings;
  }
}
