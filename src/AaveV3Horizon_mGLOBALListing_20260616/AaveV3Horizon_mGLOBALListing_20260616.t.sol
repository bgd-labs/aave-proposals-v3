// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool} from 'aave-v3-origin/contracts/interfaces/IPool.sol';
import {IERC20} from 'aave-v3-origin/contracts/dependencies/openzeppelin/contracts/IERC20.sol';
import {IDefaultInterestRateStrategyV2} from 'aave-v3-origin/contracts/interfaces/IDefaultInterestRateStrategyV2.sol';
import {Errors} from 'src/dependencies/Errors.sol';
import {ProtocolV3HorizonTestBase, ReserveConfig} from 'tests/utils/ProtocolV3HorizonTestBase.sol';
import {HorizonConfigAssertionHelper} from 'tests/utils/HorizonConfigAssertionHelper.sol';
import {AaveV3Horizon_mGLOBALListing_20260616} from 'src/AaveV3Horizon_mGLOBALListing_20260616/AaveV3Horizon_mGLOBALListing_20260616.sol';
import {AaveV3EthereumHorizonCustom} from 'src/utils/AaveV3EthereumHorizonCustom.sol';
import {AaveV3EthereumHorizonAssets} from 'aave-address-book-latest/AaveV3EthereumHorizon.sol';

abstract contract AaveV3Horizon_mGLOBALListing_20260616_TestBase is ProtocolV3HorizonTestBase {
  AaveV3Horizon_mGLOBALListing_20260616 internal proposal;

  ExpectedAssetConfig internal expectedAssetConfig;
  ExpectedEModeConfig internal expectedEModeConfig;

  function setUp() public virtual {
    _setExpectedConfig();
  }

  function _setExpectedConfig() internal virtual override {
    expectedAssetConfig = ExpectedAssetConfig({
      underlying: AaveV3EthereumHorizonCustom.MGLOBAL_UNDERLYING,
      isRwa: true,
      oracle: AaveV3EthereumHorizonCustom.MGLOBAL_PRICE_FEED,
      aTokenName: 'Aave Horizon RWA mGLOBAL',
      aTokenSymbol: 'aHorRwamGLOBAL',
      variableDebtTokenName: 'Aave Horizon RWA Variable Debt mGLOBAL',
      variableDebtTokenSymbol: 'variableDebtHorRwamGLOBAL',
      supplyCap: 50_000_000,
      borrowCap: 0,
      reserveFactor: 0,
      borrowingEnabled: false,
      flashloanable: false,
      ltv: 5,
      liquidationThreshold: 10,
      liquidationBonus: 100_00 + 6_00,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateData: IDefaultInterestRateStrategyV2.InterestRateData({
        optimalUsageRatio: 99_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 0,
        variableRateSlope2: 0
      })
    });
    expectedEModeConfig = ExpectedEModeConfig({
      eModeCategory: 5,
      ltv: 75_00,
      liquidationThreshold: 80_00,
      liquidationBonus: 100_00 + 6_00,
      label: 'mGLOBAL Stablecoins',
      collateralAssets: _toAddressArray(AaveV3EthereumHorizonCustom.MGLOBAL_UNDERLYING),
      borrowableAssets: _toAddressArray(
        AaveV3EthereumHorizonAssets.USDC_UNDERLYING,
        AaveV3EthereumHorizonAssets.RLUSD_UNDERLYING
      )
    });
  }
}

/**
 * @dev Test for Horizon mGLOBAL listing (pre-execution).
 * command: FOUNDRY_PROFILE=test forge test --match-contract AaveV3Horizon_mGLOBALListing_20260616_Test -vv
 */
contract AaveV3Horizon_mGLOBALListing_20260616_Test is
  AaveV3Horizon_mGLOBALListing_20260616_TestBase
{
  function setUp() public virtual override {
    super.setUp();
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25352313);
    proposal = new AaveV3Horizon_mGLOBALListing_20260616();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function _executeMGLOBALListing() internal {
    _executeHorizonPayload(address(proposal));
  }

  function test_defaultProposalExecution() public virtual {
    defaultTest_v3_3('AaveV3Horizon_mGLOBALListing_20260616', _pool(), _executeMGLOBALListing);
  }

  /**
   * @dev verifies the exact config values set by the mGLOBAL listing payload
   */
  function test_mglobalConfig() public virtual {
    IPool pool = _pool();
    uint8 eModeCategory = proposal.MGLOBAL_EMODE_CATEGORY();

    // the eMode category must be unused before execution (no collateral/borrowable assets, no label)
    assertEq(pool.getEModeCategoryCollateralBitmap(eModeCategory), 0, 'emode collateral not empty');
    assertEq(pool.getEModeCategoryBorrowableBitmap(eModeCategory), 0, 'emode borrowable not empty');
    assertEq(bytes(pool.getEModeCategoryLabel(eModeCategory)).length, 0, 'emode label not empty');

    // execute payload
    _executeHorizonPayload(address(proposal));

    // verify mGLOBAL asset config
    _assertAssetConfig(pool, expectedAssetConfig);

    // verify mGLOBAL Stablecoins eMode
    _assertEModeConfig(pool, expectedEModeConfig);
  }

  /**
   * @dev mGLOBAL's near-zero default params must prevent borrowing a meaningful amount of a
   *      stablecoin against it outside of the eMode.
   */
  function test_mglobalDefaultModeBorrowReverts() public {
    IPool pool = _pool();
    _executeHorizonPayload(address(proposal));

    _initTestActors();
    _whitelistRwaUsers(_testActorsArray());
    _whitelistRwaPool(pool);

    address user = regularCollateralSupplier;
    address mGlobal = AaveV3EthereumHorizonCustom.MGLOBAL_UNDERLYING;
    uint256 supplyAmount = 100_000e18;

    // supply mGLOBAL as collateral in the default eMode (category 0)
    deal(mGlobal, user, supplyAmount);
    vm.startPrank(user);
    IERC20(mGlobal).approve(address(pool), supplyAmount);
    pool.supply(mGlobal, supplyAmount, user, 0);

    // borrowing a stablecoin against it in default mode must revert (near-zero default LTV)
    vm.expectRevert(bytes(Errors.COLLATERAL_CANNOT_COVER_NEW_BORROW));
    pool.borrow(AaveV3EthereumHorizonAssets.USDC_UNDERLYING, 10_000e6, 2, 0, user);

    vm.expectRevert(bytes(Errors.COLLATERAL_CANNOT_COVER_NEW_BORROW));
    pool.borrow(AaveV3EthereumHorizonAssets.GHO_UNDERLYING, 10_000e18, 2, 0, user);
    vm.stopPrank();
  }
}

/**
 * @dev Post-execution fork test. Run after the payload has been executed on mainnet
 *      to validate the live state matches expected config and run full E2E.
 * command: FOUNDRY_PROFILE=test forge test --match-contract AaveV3Horizon_mGLOBALListing_20260616_PostExecution_Test -vv
 */
contract AaveV3Horizon_mGLOBALListing_20260616_PostExecution_Test is
  AaveV3Horizon_mGLOBALListing_20260616_TestBase
{
  function setUp() public virtual override {
    super.setUp();
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25380179);
  }

  function test_defaultProposalExecution() public {
    defaultTest_v3_3_postExecution(_pool());
  }

  function test_mglobalConfig() public {
    _assertAssetConfig(_pool(), expectedAssetConfig);
    _assertEModeConfig(_pool(), expectedEModeConfig);
  }
}
