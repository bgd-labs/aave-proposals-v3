// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console2 as console} from 'forge-std/console2.sol';
import {IERC20} from 'aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/forge-std/src/interfaces/IERC20.sol';
import {IPool} from 'aave-v3-origin/contracts/interfaces/IPool.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IPoolAddressesProvider} from 'aave-v3-origin/contracts/interfaces/IPoolAddressesProvider.sol';
import {IPoolConfigurator} from 'aave-v3-origin/contracts/interfaces/IPoolConfigurator.sol';

/**
 * @dev Adapted from ProtocolV3TestBase for the Horizon market (currently at Aave v3.3).
 * - GHO is listed as a normal reserve like prime market, removes special branches.
 * - Enable eMode before supplying if available.
 * - Skip liquidation with receiveAToken=true when collateral is RWA, since it is disabled.
 * - Adds helper to return all actors used in E2E test such that they may be whitelisted to hold RWA tokens.
 * - Update errors to v3.3 string format.
 */
abstract contract ProtocolV3HorizonTestBase is ProtocolV3TestBase {
  string public constant BORROW_CAP_EXCEEDED = '50';
  string public constant SUPPLY_CAP_EXCEEDED = '51';

  /**
   * @dev runs the default test suite that should run on any proposal touching the aave protocol which includes:
   * - diffing the config
   * - checking if the changes are plausible (no conflicting config changes etc)
   * - running an e2e testsuite over all assets
   */
  function defaultTest_v3_3(
    string memory reportName,
    IPool pool,
    address payload
  ) public returns (ReserveConfig[] memory, ReserveConfig[] memory) {
    string memory beforeString = string(abi.encodePacked(reportName, '_before'));
    ReserveConfig[] memory configBefore = createConfigurationSnapshot(beforeString, pool);

    uint256 startGas = gasleft();

    vm.startStateDiffRecording();
    executePayload(vm, payload);
    string memory rawDiff = vm.getStateDiffJson();

    uint256 gasUsed = startGas - gasleft();
    assertLt(gasUsed, (block.gaslimit * 95) / 100, 'BLOCK_GAS_LIMIT_EXCEEDED'); // 5% is kept as a buffer

    string memory afterString = string(abi.encodePacked(reportName, '_after'));
    ReserveConfig[] memory configAfter = createConfigurationSnapshot(afterString, pool);
    string memory output = vm.serializeString('root', 'raw', rawDiff);
    vm.writeJson(output, string(abi.encodePacked('./reports/', afterString, '.json')));

    diffReports(beforeString, afterString);

    configChangePlausibilityTest(configBefore, configAfter);

    e2eTest_v3_3(pool);
    return (configBefore, configAfter);
  }

  /**
   * @dev Makes a e2e test including withdrawals/borrows and supplies to various reserves.
   * @param pool the pool that should be tested
   */
  function e2eTest_v3_3(IPool pool) public {
    ReserveConfig[] memory configs = _getReservesConfigs(pool);
    ReserveConfig memory collateralConfig = _goodCollateral(configs);
    uint256 snapshot = vm.snapshotState();
    for (uint256 i; i < configs.length; i++) {
      if (_includeInE2e(configs[i])) {
        e2eTestAsset_v3_3(pool, collateralConfig, configs[i]);
        vm.revertToState(snapshot);
      } else {
        console.log('E2E: TestAsset %s SKIPPED', configs[i].symbol);
      }
    }
  }

  struct E2ETestAssetLocalVars {
    address collateralSupplier;
    address testAssetSupplier;
    address liquidator;
    uint256 collateralAssetAmount;
    uint256 testAssetAmount;
    uint256 snapshotAfterDeposits;
    uint256 aTokenTotalSupply;
    uint256 variableDebtTokenTotalSupply;
    uint256 borrowAmount;
    uint256 snapshotBeforeRepay;
  }

  function e2eTestAsset_v3_3(
    IPool pool,
    ReserveConfig memory collateralConfig,
    ReserveConfig memory testAssetConfig
  ) public {
    console.log(
      'E2E: Collateral %s, TestAsset %s',
      collateralConfig.symbol,
      testAssetConfig.symbol
    );
    E2ETestAssetLocalVars memory vars;
    vars.collateralSupplier = makeAddr('collateralSupplier');
    vars.testAssetSupplier = makeAddr('testAssetSupplier');
    vars.liquidator = makeAddr('liquidator');
    require(collateralConfig.usageAsCollateralEnabled, 'COLLATERAL_CONFIG_MUST_BE_COLLATERAL');
    vars.collateralAssetAmount = _getTokenAmountByDollarValue(pool, collateralConfig, 100_000);
    vars.testAssetAmount = _getTokenAmountByDollarValue(pool, testAssetConfig, 10_000);

    // remove caps as they should not prevent testing
    IPoolAddressesProvider addressesProvider = IPoolAddressesProvider(pool.ADDRESSES_PROVIDER());
    IPoolConfigurator poolConfigurator = IPoolConfigurator(addressesProvider.getPoolConfigurator());
    vm.startPrank(addressesProvider.getACLAdmin());
    if (collateralConfig.supplyCap != 0) {
      poolConfigurator.setSupplyCap(collateralConfig.underlying, 0);
    }
    if (testAssetConfig.supplyCap != 0) {
      poolConfigurator.setSupplyCap(testAssetConfig.underlying, 0);
    }
    if (testAssetConfig.borrowCap != 0) {
      poolConfigurator.setBorrowCap(testAssetConfig.underlying, 0);
    }
    vm.stopPrank();

    _enableIfEMode(collateralConfig, pool, vars.collateralSupplier);
    _deposit(collateralConfig, pool, vars.collateralSupplier, vars.collateralAssetAmount);
    _deposit(testAssetConfig, pool, vars.testAssetSupplier, vars.testAssetAmount);

    uint256 snapshotAfterDeposits = vm.snapshotState();

    // test deposits and withdrawals
    vars.aTokenTotalSupply = IERC20(testAssetConfig.aToken).totalSupply();
    vars.variableDebtTokenTotalSupply = IERC20(testAssetConfig.variableDebtToken).totalSupply();

    vm.prank(addressesProvider.getACLAdmin());
    poolConfigurator.setSupplyCap(
      testAssetConfig.underlying,
      vars.aTokenTotalSupply / 10 ** testAssetConfig.decimals + 1
    );
    vm.prank(addressesProvider.getACLAdmin());
    poolConfigurator.setBorrowCap(
      testAssetConfig.underlying,
      vars.variableDebtTokenTotalSupply / 10 ** testAssetConfig.decimals + 1
    );

    // caps should revert when supplying slightly more
    vm.expectRevert(bytes(SUPPLY_CAP_EXCEEDED));
    vm.prank(vars.testAssetSupplier);
    pool.deposit({
      asset: testAssetConfig.underlying,
      amount: 11 ** testAssetConfig.decimals,
      onBehalfOf: vars.testAssetSupplier,
      referralCode: 0
    });
    if (testAssetConfig.borrowingEnabled) {
      vars.borrowAmount = 11 ** testAssetConfig.decimals;

      if (vars.aTokenTotalSupply < vars.borrowAmount) {
        vm.prank(addressesProvider.getACLAdmin());
        poolConfigurator.setSupplyCap(testAssetConfig.underlying, 0);

        // aTokenTotalSupply == 10'000$
        // borrowAmount > 10'000$
        // need to add more test asset in order to be able to borrow it
        // right now there is not enough underlying tokens in the aToken
        _deposit(
          testAssetConfig,
          pool,
          vars.testAssetSupplier,
          vars.borrowAmount - vars.aTokenTotalSupply
        );

        // need to add more collateral in order to be able to borrow
        // collateralAssetAmount == 100'000$
        _deposit(
          collateralConfig,
          pool,
          vars.collateralSupplier,
          (vars.collateralAssetAmount * vars.borrowAmount) / vars.aTokenTotalSupply
        );
      }

      vm.expectRevert(bytes(BORROW_CAP_EXCEEDED));
      vm.prank(vars.collateralSupplier);
      pool.borrow({
        asset: testAssetConfig.underlying,
        amount: vars.borrowAmount,
        interestRateMode: 2,
        referralCode: 0,
        onBehalfOf: vars.collateralSupplier
      });
    }

    vm.revertToState(snapshotAfterDeposits);

    _withdraw(testAssetConfig, pool, vars.testAssetSupplier, vars.testAssetAmount / 2);
    _withdraw(testAssetConfig, pool, vars.testAssetSupplier, type(uint256).max);

    vm.revertToState(snapshotAfterDeposits);

    // test borrows, repayments and liquidations
    if (testAssetConfig.borrowingEnabled) {
      // test borrowing and repayment
      _borrow({
        config: testAssetConfig,
        pool: pool,
        user: vars.collateralSupplier,
        amount: vars.testAssetAmount
      });

      uint256 snapshotBeforeRepay = vm.snapshotState();

      _repay({
        config: testAssetConfig,
        pool: pool,
        user: vars.collateralSupplier,
        amount: vars.testAssetAmount,
        withATokens: false
      });

      vm.revertToState(snapshotBeforeRepay);

      _repay({
        config: testAssetConfig,
        pool: pool,
        user: vars.collateralSupplier,
        amount: vars.testAssetAmount,
        withATokens: true
      });

      vm.revertToState(snapshotAfterDeposits);

      // test liquidations
      _borrow({
        config: testAssetConfig,
        pool: pool,
        user: vars.collateralSupplier,
        amount: vars.testAssetAmount
      });

      if (testAssetConfig.underlying != collateralConfig.underlying) {
        _changeAssetPrice(pool, testAssetConfig, 1000_00); // price increases to 1'000%
      } else {
        _setAssetLtvAndLiquidationThreshold({
          pool: pool,
          config: testAssetConfig,
          newLtv: 5_00,
          newLiquidationThreshold: 5_00
        });
      }

      uint256 snapshotBeforeLiquidation = vm.snapshotState();

      // receive underlying tokens
      _liquidationCall({
        collateralConfig: collateralConfig,
        debtConfig: testAssetConfig,
        pool: pool,
        liquidator: makeAddr('liquidator'),
        borrower: vars.collateralSupplier,
        debtToCover: type(uint256).max,
        receiveAToken: false
      });

      vm.revertToState(snapshotBeforeLiquidation);

      // receive ATokens
      if (!_isRwaToken(collateralConfig)) {
        // cannot receive ATokens for RWA collateral liquidations
        _liquidationCall({
          collateralConfig: collateralConfig,
          debtConfig: testAssetConfig,
          pool: pool,
          liquidator: makeAddr('liquidator'),
          borrower: vars.collateralSupplier,
          debtToCover: type(uint256).max,
          receiveAToken: true
        });
      }

      vm.revertToState(snapshotAfterDeposits);
    }

    // test flashloans
    if (testAssetConfig.isFlashloanable) {
      _flashLoan({
        config: testAssetConfig,
        pool: pool,
        user: vars.collateralSupplier,
        receiverAddress: address(this),
        amount: vars.testAssetAmount,
        interestRateMode: 0
      });

      if (testAssetConfig.borrowingEnabled) {
        _flashLoan({
          config: testAssetConfig,
          pool: pool,
          user: vars.collateralSupplier,
          receiverAddress: address(this),
          amount: vars.testAssetAmount,
          interestRateMode: 2
        });
      }
    }
  }

  function _isRwaToken(ReserveConfig memory config) internal view returns (bool) {
    address RWA_A_TOKEN_INSTANCE = 0x1d0Da70de08987b1888befECe0024443Bf3c2450;
    bytes32 IMPL_SLOT = bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1);
    return address(uint160(uint256(vm.load(config.aToken, IMPL_SLOT)))) == RWA_A_TOKEN_INSTANCE;
  }

  function _enableIfEMode(ReserveConfig memory config, IPool pool, address user) internal {
    vm.prank(user);
    pool.setUserEMode(0);

    // eMode id 0 is skipped intentionally as it is the reserved default
    for (uint8 id = 1; id < 256; ++id) {
      uint256 reserveId = pool.getReserveData(config.underlying).id;
      if ((pool.getEModeCategoryCollateralBitmap(id) >> reserveId) & 1 != 0) {
        vm.prank(user);
        pool.setUserEMode(id);
        break;
      }
    }
  }

  /**
   * @dev returns a "good" collateral in the list
   */
  function _goodCollateral(
    ReserveConfig[] memory configs
  ) internal pure returns (ReserveConfig memory config) {
    for (uint256 i = 0; i < configs.length; i++) {
      if (
        // not frozen etc
        // usable as collateral
        // not isolated asset as we can only borrow stablecoins against it
        // ltv is not 0
        _includeInE2e(configs[i]) &&
        configs[i].usageAsCollateralEnabled &&
        configs[i].debtCeiling == 0 &&
        configs[i].ltv != 0
      ) return configs[i];
    }
    revert('ERROR: No usable collateral found');
  }

  function _testActors() internal returns (address[] memory actors) {
    actors = new address[](3);
    actors[0] = makeAddr('collateralSupplier');
    actors[1] = makeAddr('testAssetSupplier');
    actors[2] = makeAddr('liquidator');
  }
}
