// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3XLayer, AaveV3XLayerAssets, AaveV3XLayerEModes} from 'aave-address-book/AaveV3XLayer.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {IDefaultInterestRateStrategyV2} from 'aave-v3-origin/contracts/interfaces/IDefaultInterestRateStrategyV2.sol';
import {Errors} from 'aave-v3-origin/contracts/protocol/libraries/helpers/Errors.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ExpectedListing} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3XLayer_AaveV3XLayerUSDeListing_20261013} from './AaveV3XLayer_AaveV3XLayerUSDeListing_20261013.sol';
import {IPriceCapAdapterStable} from '../interfaces/IPriceCapAdapterStable.sol';

/**
 * @dev Test for AaveV3XLayer_AaveV3XLayerUSDeListing_20261013
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20261013_AaveV3XLayer_AaveV3XLayerUSDeListing/AaveV3XLayer_AaveV3XLayerUSDeListing_20261013.t.sol -vv
 */
contract AaveV3XLayer_AaveV3XLayerUSDeListing_20261013_Test is ProtocolV3TestBase {
  AaveV3XLayer_AaveV3XLayerUSDeListing_20261013 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('xlayer'), 73119417);
    proposal = new AaveV3XLayer_AaveV3XLayerUSDeListing_20261013();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3XLayer_AaveV3XLayerUSDeListing_20261013',
      AaveV3XLayer.POOL,
      address(proposal)
    );
  }

  /**
   * @dev checks whether reserve configurations changed or stayed unchanged as expected
   */
  function test_reserveConfigChanges() public {
    address[] memory updatedAssets = new address[](0);

    reserveConfigChangesTest(AaveV3XLayer.POOL, address(proposal), updatedAssets);
  }

  function test_dustBinHasUSDeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3XLayer.POOL.getReserveAToken(proposal.USDe());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3XLayer.DUST_BIN)),
      proposal.USDe_SEED_AMOUNT(),
      'dust bin should hold at least the seeded aUSDe amount'
    );
  }

  function test_liquidationProtocolFee() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      AaveV3XLayer.AAVE_PROTOCOL_DATA_PROVIDER.getLiquidationProtocolFee(proposal.USDe()),
      10_00
    );
  }

  function _expectedListings() internal pure override returns (ExpectedListing[] memory listings) {
    listings = new ExpectedListing[](1);

    listings[0] = ExpectedListing({
      listing: IAaveV3ConfigEngine.Listing({
        asset: 0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34,
        assetSymbol: 'USDe',
        priceFeed: 0x7ec7E5497EAf312FE82F8307D05eb0E5f0f157D3,
        enabledToBorrow: EngineFlags.ENABLED,
        flashloanable: EngineFlags.ENABLED,
        ltv: 0,
        liqThreshold: 0,
        liqBonus: 0,
        reserveFactor: 25_00,
        supplyCap: 100_000_000,
        borrowCap: 20_000_000,
        liqProtocolFee: 10_00,
        rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
          optimalUsageRatio: 85_00,
          baseVariableBorrowRate: 6_30,
          variableRateSlope1: 25,
          variableRateSlope2: 45_00
        })
      }),
      decimals: 18
    });
  }

  function test_priceFeed() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _validateAssetSourceOnOracle(
      AaveV3XLayer.POOL_ADDRESSES_PROVIDER,
      proposal.USDe(),
      AaveV3XLayerAssets.USDT_ORACLE
    );
    assertEq(proposal.USDe_PRICE_FEED(), 0x7ec7E5497EAf312FE82F8307D05eb0E5f0f157D3);

    uint256 price = AaveV3XLayer.ORACLE.getAssetPrice(proposal.USDe());
    assertGt(price, 0.95e8, 'USDe price should trade near 1 USD');
    assertLt(price, 1.05e8, 'USDe price should trade near 1 USD');

    IPriceCapAdapterStable adapter = IPriceCapAdapterStable(AaveV3XLayerAssets.USDT_ORACLE);
    assertEq(adapter.getPriceCap(), 1.04e8, 'price cap should be 1.04 USD');
    assertEq(
      adapter.ASSET_TO_USD_AGGREGATOR(),
      0xb928a0678352005a2e51F614efD0b54C9830dB80,
      'underlying aggregator should be the USDT / USD feed'
    );
  }

  function test_rates() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address strategy = AaveV3XLayer.POOL.RESERVE_INTEREST_RATE_STRATEGY();
    _validateInterestRateStrategy(
      proposal.USDe(),
      AaveV3XLayer.POOL.getReserveData(proposal.USDe()).interestRateStrategyAddress,
      strategy,
      IDefaultInterestRateStrategyV2.InterestRateDataRay({
        optimalUsageRatio: 0.85e27,
        baseVariableBorrowRate: 0.063e27,
        variableRateSlope1: 0.0025e27,
        variableRateSlope2: 0.45e27
      })
    );
  }

  function test_eModeConfiguration() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    uint8 eMode_USDe__Stablecoins = _findEModeCategoryId('USDe__Stablecoins');
    assertEq(eMode_USDe__Stablecoins, 9, 'new eMode should take the next free id');
    _assertEModeCollateralConfig({
      id: eMode_USDe__Stablecoins,
      ltv: 91_00,
      liquidationThreshold: 93_00,
      liquidationBonus: 100_00 + 2_00,
      isolated: false
    });

    address[] memory collaterals_USDe__Stablecoins = new address[](1);
    collaterals_USDe__Stablecoins[0] = proposal.USDe();
    assertEq(
      AaveV3XLayer.POOL.getEModeCategoryCollateralBitmap(eMode_USDe__Stablecoins),
      _toBitmap(collaterals_USDe__Stablecoins)
    );

    address[] memory borrowables_USDe__Stablecoins = new address[](4);
    borrowables_USDe__Stablecoins[0] = AaveV3XLayerAssets.USDT_UNDERLYING;
    borrowables_USDe__Stablecoins[1] = AaveV3XLayerAssets.USDG_UNDERLYING;
    borrowables_USDe__Stablecoins[2] = AaveV3XLayerAssets.USDC_UNDERLYING;
    borrowables_USDe__Stablecoins[3] = AaveV3XLayerAssets.GHO_UNDERLYING;
    assertEq(
      AaveV3XLayer.POOL.getEModeCategoryBorrowableBitmap(eMode_USDe__Stablecoins),
      _toBitmap(borrowables_USDe__Stablecoins)
    );
  }

  function test_usdeInExistingEModes() public {
    uint256 before_ = AaveV3XLayer.POOL.getEModeCategoryBorrowableBitmap(
      AaveV3XLayerEModes.PT_USDG_29OCT2026__USDT_USDG_GHO_USDC
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    uint256 usdeId = AaveV3XLayer.POOL.getReserveData(proposal.USDe()).id;

    uint8[4] memory joined = [
      AaveV3XLayerEModes.xBTC__USDT_USDG_GHO_USDC,
      AaveV3XLayerEModes.xETH__USDT_USDG_GHO_USDC,
      AaveV3XLayerEModes.xSOL__USDT_USDG_GHO_USDC,
      AaveV3XLayerEModes.WOKB__USDT_USDG_GHO_USDC
    ];
    for (uint256 i = 0; i < joined.length; i++) {
      assertEq(
        (AaveV3XLayer.POOL.getEModeCategoryBorrowableBitmap(joined[i]) >> usdeId) & 1,
        1,
        'USDe should be borrowable'
      );
      assertEq(
        (AaveV3XLayer.POOL.getEModeCategoryCollateralBitmap(joined[i]) >> usdeId) & 1,
        0,
        'USDe should not be collateral'
      );
    }

    uint8[4] memory untouched = [
      AaveV3XLayerEModes.xBETH__xETH,
      AaveV3XLayerEModes.xOKSOL__xSOL,
      AaveV3XLayerEModes.PT_USDG_29OCT2026__USDT_USDG_GHO_USDC,
      AaveV3XLayerEModes.PT_USDG_29OCT2026__USDG
    ];
    for (uint256 i = 0; i < untouched.length; i++) {
      assertEq(
        (AaveV3XLayer.POOL.getEModeCategoryBorrowableBitmap(untouched[i]) >> usdeId) & 1,
        0,
        'USDe should not be borrowable'
      );
      assertEq(
        (AaveV3XLayer.POOL.getEModeCategoryCollateralBitmap(untouched[i]) >> usdeId) & 1,
        0,
        'USDe should not be collateral'
      );
    }
    assertEq(
      AaveV3XLayer.POOL.getEModeCategoryBorrowableBitmap(
        AaveV3XLayerEModes.PT_USDG_29OCT2026__USDT_USDG_GHO_USDC
      ),
      before_,
      'eMode 7 borrowable bitmap should not change'
    );
    assertEq(
      AaveV3XLayer.POOL.getEModeCategoryLabel(AaveV3XLayerEModes.xBTC__USDT_USDG_GHO_USDC),
      'xBTC__Stablecoins',
      'existing labels should not change'
    );
    assertEq(
      AaveV3XLayer.POOL.getEModeCategoryLabel(
        AaveV3XLayerEModes.PT_USDG_29OCT2026__USDT_USDG_GHO_USDC
      ),
      'PT_USDG__Stablecoins',
      'existing labels should not change'
    );
  }

  function test_eMode_USDe__Stablecoins_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyAndBorrowInEMode(
      'USDe__Stablecoins',
      proposal.USDe(),
      AaveV3XLayerAssets.USDT_UNDERLYING
    );
  }

  function test_USDeBorrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('borrowWithoutEModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(proposal.USDe()).decimals();
    deal(proposal.USDe(), user, supplyAmount);

    vm.startPrank(user);

    IERC20(proposal.USDe()).approve(address(AaveV3XLayer.POOL), supplyAmount);
    AaveV3XLayer.POOL.supply(proposal.USDe(), supplyAmount, user, 0);

    // LTV is 0 outside the e-mode, so the borrow must revert
    vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
    AaveV3XLayer.POOL.borrow(AaveV3XLayerAssets.USDT_UNDERLYING, 1, 2, 0, user);

    vm.stopPrank();
  }

  function _findEModeCategoryId(string memory label) internal view returns (uint8) {
    for (uint8 i = 1; i < 255; i++) {
      if (keccak256(bytes(AaveV3XLayer.POOL.getEModeCategoryLabel(i))) == keccak256(bytes(label))) {
        return i;
      }
    }
    revert('eMode category not found');
  }

  function _assertEModeCollateralConfig(
    uint8 id,
    uint256 ltv,
    uint256 liquidationThreshold,
    uint256 liquidationBonus,
    bool isolated
  ) internal view {
    DataTypes.CollateralConfig memory cfg = AaveV3XLayer.POOL.getEModeCategoryCollateralConfig(id);
    assertEq(cfg.ltv, ltv);
    assertEq(cfg.liquidationThreshold, liquidationThreshold);
    assertEq(cfg.liquidationBonus, liquidationBonus);
    assertEq(AaveV3XLayer.POOL.getIsEModeCategoryIsolated(id), isolated);
  }

  function _toBitmap(address[] memory assets) internal view returns (uint128 bitmap) {
    for (uint256 i = 0; i < assets.length; i++) {
      bitmap |= uint128(1) << AaveV3XLayer.POOL.getReserveData(assets[i]).id;
    }
  }

  function _supplyAndBorrowInEMode(
    string memory label,
    address collateral,
    address borrowAsset
  ) internal {
    uint8 eModeId = _findEModeCategoryId(label);

    address user = makeAddr('eModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(collateral).decimals();
    deal(collateral, user, supplyAmount);

    vm.startPrank(user);

    AaveV3XLayer.POOL.setUserEMode(eModeId);

    IERC20(collateral).approve(address(AaveV3XLayer.POOL), supplyAmount);
    AaveV3XLayer.POOL.supply(collateral, supplyAmount, user, 0);

    uint256 borrowAmount = 10 * 10 ** IERC20Metadata(borrowAsset).decimals();
    AaveV3XLayer.POOL.borrow(borrowAsset, borrowAmount, 2, 0, user);

    address vToken = AaveV3XLayer.POOL.getReserveVariableDebtToken(borrowAsset);
    assertApproxEqAbs(IERC20(vToken).balanceOf(user), borrowAmount, 1);

    IERC20(borrowAsset).approve(address(AaveV3XLayer.POOL), borrowAmount);
    AaveV3XLayer.POOL.repay(borrowAsset, borrowAmount, 2, user);
    AaveV3XLayer.POOL.withdraw(collateral, supplyAmount / 2, user);

    vm.stopPrank();
  }
}
