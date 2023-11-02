// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV3PolygonEModes} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title test
 * @author test
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Polygon_Test_20231102 is AaveV3PayloadPolygon {
  using SafeERC20 for IERC20;

  address public constant DAI = 0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063;
  uint256 internal constant DAI_SEED_AMOUNT = 10 ** 18;

  function _postExecute() internal override {
    IERC20(DAI).forceApprove(address(AaveV3Polygon.POOL), DAI_SEED_AMOUNT);
    AaveV3Polygon.POOL.supply(DAI, DAI_SEED_AMOUNT, address(AaveV3Polygon.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: DAI,
      assetSymbol: 'DAI',
      priceFeed: 0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063,
      eModeCategory: AaveV3PolygonEModes.NONE,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 40_00,
      liqThreshold: 50_00,
      liqBonus: 5_00,
      reserveFactor: 20_00,
      supplyCap: 10_000,
      borrowCap: 5_000,
      debtCeiling: 100_000,
      liqProtocolFee: 20_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(80_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(10_00),
        variableRateSlope2: _bpsToRay(100_00),
        stableRateSlope1: _bpsToRay(10_00),
        stableRateSlope2: _bpsToRay(100_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(0),
        optimalStableToTotalDebtRatio: _bpsToRay(10_00)
      })
    });

    return listings;
  }
}
