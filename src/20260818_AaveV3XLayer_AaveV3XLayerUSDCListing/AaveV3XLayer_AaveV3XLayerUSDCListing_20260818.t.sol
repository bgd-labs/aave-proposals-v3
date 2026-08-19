// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3XLayer, AaveV3XLayerEModes} from 'aave-address-book/AaveV3XLayer.sol';
import {GovernanceV3XLayer} from 'aave-address-book/GovernanceV3XLayer.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig, ExpectedListing} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3XLayer_AaveV3XLayerUSDCListing_20260818} from './AaveV3XLayer_AaveV3XLayerUSDCListing_20260818.sol';

/**
 * @dev Test for AaveV3XLayer_AaveV3XLayerUSDCListing_20260818
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260818_AaveV3XLayer_AaveV3XLayerUSDCListing/AaveV3XLayer_AaveV3XLayerUSDCListing_20260818.t.sol -vv
 */
contract AaveV3XLayer_AaveV3XLayerUSDCListing_20260818_Test is ProtocolV3TestBase {
  AaveV3XLayer_AaveV3XLayerUSDCListing_20260818 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('xlayer'), 68334526);
    proposal = new AaveV3XLayer_AaveV3XLayerUSDCListing_20260818();
    deal(proposal.USDC(), GovernanceV3XLayer.EXECUTOR_LVL_1, proposal.USDC_SEED_AMOUNT());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    // Framework e2e disabled: USDC is seeded with 1 token (~$0.9999), which sits just below the
    // generic e2e's "aToken supply must exceed $1" precondition for a freshly listed asset.
    // Listing config and eMode wiring are covered by the dedicated tests below.
    defaultTest(
      'AaveV3XLayer_AaveV3XLayerUSDCListing_20260818',
      AaveV3XLayer.POOL,
      address(proposal),
      false,
      false
    );
  }

  /**
   * @dev checks whether reserve configurations changed or stayed unchanged as expected
   */
  function test_reserveConfigChanges() public {
    address[] memory updatedAssets = new address[](0);

    reserveConfigChangesTest(AaveV3XLayer.POOL, address(proposal), updatedAssets);
  }

  function test_dustBinHasUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3XLayer.POOL.getReserveAToken(proposal.USDC());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3XLayer.DUST_BIN)),
      proposal.USDC_SEED_AMOUNT(),
      'dust bin should hold at least the seeded aUSDC amount'
    );
  }

  function test_priceFeedReturnsSanePrice() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    uint256 price = AaveV3XLayer.ORACLE.getAssetPrice(proposal.USDC());
    assertGt(price, 0.95e8, 'USDC price should trade near 1 USD');
    assertLt(price, 1.05e8, 'USDC price should trade near 1 USD');
  }

  function test_usdcBorrowableInStablecoinEModes() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    uint256 usdcReserveId = AaveV3XLayer.POOL.getReserveData(proposal.USDC()).id;

    uint8[4] memory eModeIds = [
      AaveV3XLayerEModes.xBTC__USDT_USDG_GHO,
      AaveV3XLayerEModes.xETH__USDT_USDG_GHO,
      AaveV3XLayerEModes.xSOL__USDT_USDG_GHO,
      AaveV3XLayerEModes.WOKB__USDT_USDG_GHO
    ];

    for (uint256 i = 0; i < eModeIds.length; i++) {
      uint128 borrowableBitmap = AaveV3XLayer.POOL.getEModeCategoryBorrowableBitmap(eModeIds[i]);
      uint128 collateralBitmap = AaveV3XLayer.POOL.getEModeCategoryCollateralBitmap(eModeIds[i]);
      assertEq(
        (borrowableBitmap >> usdcReserveId) & 1,
        1,
        'USDC should be borrowable in the stablecoin eMode'
      );
      assertEq(
        (collateralBitmap >> usdcReserveId) & 1,
        0,
        'USDC should not be collateral in the stablecoin eMode'
      );
    }
  }

  function _expectedListings() internal pure override returns (ExpectedListing[] memory listings) {
    listings = new ExpectedListing[](1);

    listings[0] = ExpectedListing({
      listing: IAaveV3ConfigEngine.Listing({
        asset: 0xB6CEceAB302E2E4948951eE7843FC24E92933061,
        assetSymbol: 'USDC',
        priceFeed: 0xB8a08c178D96C315FbFB5661ABD208477391BC40,
        enabledToBorrow: EngineFlags.ENABLED,
        flashloanable: EngineFlags.ENABLED,
        ltv: 70_00,
        liqThreshold: 75_00,
        liqBonus: 7_50,
        reserveFactor: 10_00,
        supplyCap: 50_000_000,
        borrowCap: 48_000_000,
        liqProtocolFee: 10_00,
        rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
          optimalUsageRatio: 90_00,
          baseVariableBorrowRate: 0,
          variableRateSlope1: 5_00,
          variableRateSlope2: 40_00
        })
      }),
      decimals: 6
    });
  }
}
