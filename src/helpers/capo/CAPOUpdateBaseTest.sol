// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {BasicIACLManager, IPool, IAaveOracle, DataTypes} from 'aave-address-book/AaveV3.sol';
import {ReserveConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';
import {IPriceCapAdapter} from 'src/interfaces/IPriceCapAdapter.sol';
import {BlockUtils} from './utils/BlockUtils.sol';

abstract contract CAPOUpdateBaseTest is Test {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  uint256 internal constant SECONDS_PER_DAY = 86400;
  uint256 internal constant SECONDS_PER_YEAR = 365 days;
  uint256 internal constant PERCENTAGE_FACTOR = 1e4;
  uint256 internal constant MAX_SPREAD_BPS_OF_CURRENT = 200;
  uint256 internal constant MIN_SPREAD_REDUCTION_BPS = 5000;
  uint256 internal constant RETROSPECTIVE_DAYS = 30;
  uint256 internal constant HEALTH_FACTOR_BASE = 1e18;
  // 0.5% (50 bps), expressed as the 18-decimal fixed-point fraction used by `assertApproxEqRel`.
  uint256 internal constant PRICE_APPROX_EQ_TOLERANCE = 0.005e18;

  struct OracleExpectation {
    string label;
    address adapter;
    uint104 expectedSnapshotRatio;
    uint48 expectedSnapshotTimestamp;
    uint16 expectedMaxYearlyGrowthPercent;
  }

  struct PriceParams {
    int256 sourcePrice;
    int256 referencePrice;
    uint256 blockNumber;
    uint256 timestamp;
    int256 ratio;
    int256 dayToDayGrowth;
    int256 smoothedGrowth;
  }

  PriceParams[] internal _retrospectivePrices;

  function _executePayload() internal virtual;

  function _network() internal view virtual returns (string memory);

  function _reportPrefix() internal view virtual returns (string memory);

  function _pool() internal view virtual returns (IPool);

  function test_dynamicSnapshotAnchored_allChangedAdapters() public {
    IPool pool = _pool();
    IAaveOracle oracle = IAaveOracle(pool.ADDRESSES_PROVIDER().getPriceOracle());
    address[] memory reserves = pool.getReservesList();

    address[] memory capoAdapters = new address[](reserves.length);
    uint256[] memory preSnapshotRatios = new uint256[](reserves.length);
    uint256[] memory preSnapshotTimestamps = new uint256[](reserves.length);
    uint256[] memory preMaxYearlyGrowths = new uint256[](reserves.length);
    uint256 capoCount = 0;

    for (uint256 i = 0; i < reserves.length; i++) {
      if (!_isReserveActive(pool, reserves[i])) continue;

      address adapter = oracle.getSourceOfAsset(reserves[i]);
      assertTrue(adapter != address(0), 'source of asset is address(0)');
      if (!_isPriceCapAdapter(adapter)) continue;

      capoAdapters[capoCount] = adapter;
      preSnapshotRatios[capoCount] = IPriceCapAdapter(adapter).getSnapshotRatio();
      preSnapshotTimestamps[capoCount] = IPriceCapAdapter(adapter).getSnapshotTimestamp();
      preMaxYearlyGrowths[capoCount] = IPriceCapAdapter(adapter).getMaxYearlyGrowthRatePercent();
      capoCount++;
    }

    _executePayload();

    uint256[] memory postSnapshotRatios = new uint256[](capoCount);
    uint256[] memory postSnapshotTimestamps = new uint256[](capoCount);
    uint256[] memory postMaxYearlyGrowths = new uint256[](capoCount);
    for (uint256 i = 0; i < capoCount; i++) {
      postSnapshotRatios[i] = IPriceCapAdapter(capoAdapters[i]).getSnapshotRatio();
      postSnapshotTimestamps[i] = IPriceCapAdapter(capoAdapters[i]).getSnapshotTimestamp();
      postMaxYearlyGrowths[i] = IPriceCapAdapter(capoAdapters[i]).getMaxYearlyGrowthRatePercent();
    }

    uint256 changedCount = 0;
    for (uint256 i = 0; i < capoCount; i++) {
      bool changed = postSnapshotRatios[i] != preSnapshotRatios[i] ||
        postSnapshotTimestamps[i] != preSnapshotTimestamps[i] ||
        postMaxYearlyGrowths[i] != preMaxYearlyGrowths[i];
      if (!changed) continue;

      _runSnapshotAnchoredTest(capoAdapters[i], postSnapshotRatios[i], postSnapshotTimestamps[i]);
      changedCount++;
    }

    assertGt(changedCount, 0, 'no CAPO adapters were updated by the payload');
  }

  function test_assetSourcesUnchanged_forActiveReserves() public {
    IPool pool = _pool();
    IAaveOracle oracle = IAaveOracle(pool.ADDRESSES_PROVIDER().getPriceOracle());
    address[] memory reserves = pool.getReservesList();

    address[] memory sourcesBefore = new address[](reserves.length);
    for (uint256 i = 0; i < reserves.length; i++) {
      if (!_isReserveActive(pool, reserves[i])) continue;
      sourcesBefore[i] = oracle.getSourceOfAsset(reserves[i]);
    }

    _executePayload();

    for (uint256 i = 0; i < reserves.length; i++) {
      if (!_isReserveActive(pool, reserves[i])) continue;
      assertEq(
        oracle.getSourceOfAsset(reserves[i]),
        sourcesBefore[i],
        'oracle source changed for an active reserve'
      );
    }
  }

  function test_assetPricesUnchanged_forActiveReserves() public {
    IPool pool = _pool();
    IAaveOracle oracle = IAaveOracle(pool.ADDRESSES_PROVIDER().getPriceOracle());
    address[] memory reserves = pool.getReservesList();

    uint256[] memory pricesBefore = new uint256[](reserves.length);
    for (uint256 i = 0; i < reserves.length; i++) {
      if (!_isReserveActive(pool, reserves[i])) continue;
      pricesBefore[i] = oracle.getAssetPrice(reserves[i]);
    }

    _executePayload();

    for (uint256 i = 0; i < reserves.length; i++) {
      if (!_isReserveActive(pool, reserves[i])) continue;
      assertEq(
        oracle.getAssetPrice(reserves[i]),
        pricesBefore[i],
        'asset price changed for an active reserve'
      );
    }
  }

  function _assertAddressBookOracleMatchesLive(
    address underlying,
    address addressBookOracle
  ) internal view {
    IAaveOracle oracle = IAaveOracle(_pool().ADDRESSES_PROVIDER().getPriceOracle());
    assertEq(
      oracle.getSourceOfAsset(underlying),
      addressBookOracle,
      'address-book oracle does not match live source for asset'
    );
  }

  function _assertOraclePriceApproxEq(
    address asset,
    uint256 expectedPrice,
    uint256 maxPercentDelta
  ) internal view {
    IAaveOracle oracle = IAaveOracle(_pool().ADDRESSES_PROVIDER().getPriceOracle());
    assertApproxEqRel(
      oracle.getAssetPrice(asset),
      expectedPrice,
      maxPercentDelta,
      'oracle price out of expected tolerance'
    );
  }

  function _runSupplyBorrowNearLtv(
    address collateralAsset,
    uint256 collateralAmount,
    address debtAsset
  ) internal {
    IPool pool = _pool();
    IAaveOracle oracle = IAaveOracle(pool.ADDRESSES_PROVIDER().getPriceOracle());
    address user = makeAddr('CAPONearLtvBorrower');

    DataTypes.ReserveConfigurationMap memory cfg = pool.getConfiguration(collateralAsset);
    uint256 ltv = cfg.getLtv();
    uint256 liquidationThreshold = cfg.getLiquidationThreshold();
    uint256 collateralPrice = oracle.getAssetPrice(collateralAsset);
    uint256 collateralUnit = 10 ** IERC20Metadata(collateralAsset).decimals();
    uint256 expectedAvailableBorrowsBase = (collateralAmount * collateralPrice * ltv) /
      (collateralUnit * PERCENTAGE_FACTOR);

    deal(collateralAsset, user, collateralAmount);

    vm.startPrank(user);
    IERC20(collateralAsset).approve(address(pool), collateralAmount);
    pool.supply(collateralAsset, collateralAmount, user, 0);
    pool.setUserUseReserveAsCollateral(collateralAsset, true);

    (, , uint256 availableBorrowsBase, , , ) = pool.getUserAccountData(user);
    assertApproxEqRel(
      availableBorrowsBase,
      expectedAvailableBorrowsBase,
      0.001e18,
      'available borrows deviated from collateral * ltv'
    );

    uint256 debtUnit = 10 ** IERC20Metadata(debtAsset).decimals();
    uint256 borrowAmount = (availableBorrowsBase * 99_00 * debtUnit) /
      (PERCENTAGE_FACTOR * oracle.getAssetPrice(debtAsset));

    pool.borrow(debtAsset, borrowAmount, 2, 0, user);
    vm.stopPrank();

    // Borrowing 99% of available power => HF = liquidationThreshold / (0.99 * ltv).
    uint256 expectedHf = (liquidationThreshold * PERCENTAGE_FACTOR * HEALTH_FACTOR_BASE) /
      (99_00 * ltv);

    (, , , , , uint256 hfBefore) = pool.getUserAccountData(user);
    assertApproxEqRel(hfBefore, expectedHf, 0.001e18, 'pre-payload HF off expected');

    _executePayload();

    (, , , , , uint256 hfAfter) = pool.getUserAccountData(user);
    assertApproxEqRel(hfAfter, hfBefore, 0.001e18, 'post-payload HF drifted');
  }

  function _isReserveActive(IPool pool, address asset) internal view returns (bool) {
    DataTypes.ReserveConfigurationMap memory config = pool.getConfiguration(asset);
    return config.getActive();
  }

  function _isPriceCapAdapter(address adapter) internal view returns (bool) {
    try IPriceCapAdapter(adapter).getSnapshotRatio() returns (uint256) {
      return true;
    } catch {
      return false;
    }
  }

  function _runPostExecutionAssertions(OracleExpectation memory e) internal {
    IPriceCapAdapter adapter = IPriceCapAdapter(e.adapter);
    uint256 oldMaxRatio = _getMaxRatio(adapter);
    uint256 currentRatio = uint256(adapter.getRatio());
    _executePayload();
    _assertSnapshotApplied(e);
    _assertLatestAnswerSane(e.adapter);
    _assertConfiguration(e.adapter);
    _assertSpreadTightened(e.adapter, oldMaxRatio, currentRatio);
    _assertCapTriggers(e.adapter);
  }

  function _runRetrospective(address adapter, string memory symbol) internal {
    _runRetrospectiveAndReport({
      adapterAddr: adapter,
      retrospectiveDays: RETROSPECTIVE_DAYS,
      network: _network(),
      reportName: string.concat(_reportPrefix(), '_', symbol, '_Capo')
    });
  }

  function _runSnapshotAnchoredTest(
    address adapter,
    uint256 expectedSnapshotRatio,
    uint256 expectedSnapshotTimestamp
  ) internal {
    uint256 historicalBlock = _findBlockByExactTimestamp(expectedSnapshotTimestamp);
    vm.createSelectFork(vm.rpcUrl(_network()), historicalBlock);
    assertEq(
      vm.getBlockTimestamp(),
      expectedSnapshotTimestamp,
      'cast find-block did not return a block with exact timestamp match'
    );
    uint256 historicalRatio = uint256(IPriceCapAdapter(adapter).getRatio());
    assertEq(
      historicalRatio,
      expectedSnapshotRatio,
      'snapshot ratio does not match on-chain ratio at snapshot timestamp'
    );
  }

  function _findBlockByExactTimestamp(uint256 ts) internal returns (uint256) {
    string memory rpc = vm.rpcUrl(_network());
    string[] memory inputs = new string[](3);
    inputs[0] = 'sh';
    inputs[1] = '-c';
    inputs[2] = string.concat(
      'printf "n:" && cast find-block ',
      vm.toString(ts),
      ' --rpc-url ',
      rpc
    );
    bytes memory raw = vm.ffi(inputs);
    return vm.parseUint(_stripPrefixAndTrim(raw, 2));
  }

  function _stripPrefixAndTrim(
    bytes memory raw,
    uint256 prefixLen
  ) internal pure returns (string memory) {
    uint256 end = raw.length;
    while (
      end > prefixLen &&
      (raw[end - 1] == 0x0a || raw[end - 1] == 0x0d || raw[end - 1] == 0x20 || raw[end - 1] == 0x09)
    ) {
      end--;
    }
    bytes memory trimmed = new bytes(end - prefixLen);
    for (uint256 i = 0; i < trimmed.length; i++) {
      trimmed[i] = raw[prefixLen + i];
    }
    return string(trimmed);
  }

  function _assertSpreadTightened(
    address adapter,
    uint256 oldMaxRatio,
    uint256 currentRatio
  ) internal view {
    uint256 newMaxRatio = _getMaxRatio(IPriceCapAdapter(adapter));
    assertGt(oldMaxRatio, currentRatio, 'pre-AIP cap upper bound was not above current ratio');
    assertLt(newMaxRatio, oldMaxRatio, 'cap upper bound (max ratio) did not tighten');

    uint256 oldSpread = oldMaxRatio - currentRatio;
    uint256 newSpread = newMaxRatio > currentRatio ? newMaxRatio - currentRatio : 0;

    assertLe(
      newSpread * PERCENTAGE_FACTOR,
      currentRatio * MAX_SPREAD_BPS_OF_CURRENT,
      'new spread exceeds max allowed bps of current ratio'
    );

    assertLe(
      newSpread * PERCENTAGE_FACTOR,
      oldSpread * (PERCENTAGE_FACTOR - MIN_SPREAD_REDUCTION_BPS),
      'spread reduction is below minimum threshold'
    );
  }

  function _preservedGrowth(address adapter) internal view returns (uint16) {
    return uint16(IPriceCapAdapter(adapter).getMaxYearlyGrowthRatePercent());
  }

  function _assertSnapshotApplied(OracleExpectation memory e) internal view {
    IPriceCapAdapter adapter = IPriceCapAdapter(e.adapter);
    assertEq(adapter.getSnapshotRatio(), uint256(e.expectedSnapshotRatio));
    assertEq(adapter.getSnapshotTimestamp(), uint256(e.expectedSnapshotTimestamp));
    assertEq(adapter.getMaxYearlyGrowthRatePercent(), uint256(e.expectedMaxYearlyGrowthPercent));
  }

  function _assertLatestAnswerSane(address adapter) internal view {
    IPriceCapAdapter a = IPriceCapAdapter(adapter);
    assertGt(a.latestAnswer(), 0);
    assertFalse(a.isCapped());
  }

  function _assertConfiguration(address adapter) internal view {
    IPriceCapAdapter a = IPriceCapAdapter(adapter);
    _validateDecimals(a);
    _validateGrowth(a);
  }

  function _assertCapTriggers(address adapter) internal {
    IPriceCapAdapter a = IPriceCapAdapter(adapter);

    if (a.getMaxYearlyGrowthRatePercent() == 0) return;
    if (uint256(a.getRatio()) <= a.getSnapshotRatio()) return;

    uint256 snap = vm.snapshotState();

    _setCapParametersByAdmin(
      a,
      uint104(a.getSnapshotRatio()),
      uint48(a.getSnapshotTimestamp() + 1),
      uint16(10)
    );
    assertTrue(a.isCapped());

    vm.revertToState(snap);
  }

  function _setCapParametersByAdmin(
    IPriceCapAdapter adapter,
    uint104 snapshotRatio,
    uint48 snapshotTimestamp,
    uint16 maxYearlyRatioGrowthPercent
  ) internal {
    vm.mockCall(
      address(adapter.ACL_MANAGER()),
      abi.encodeWithSelector(BasicIACLManager.isRiskAdmin.selector),
      abi.encode(true)
    );

    adapter.setCapParameters(
      IPriceCapAdapter.PriceCapUpdateParams({
        snapshotRatio: snapshotRatio,
        snapshotTimestamp: snapshotTimestamp,
        maxYearlyRatioGrowthPercent: maxYearlyRatioGrowthPercent
      })
    );
  }

  function _validateGrowth(IPriceCapAdapter adapter) private view {
    uint256 maxYearlyGrowthRatePercent = adapter.getMaxYearlyGrowthRatePercent();

    if (maxYearlyGrowthRatePercent > 0) {
      assertGe(adapter.getMaxRatioGrowthPerSecond(), 0);
    }

    assertLe(maxYearlyGrowthRatePercent, PERCENTAGE_FACTOR);
  }

  function _validateDecimals(IPriceCapAdapter adapter) private view {
    uint256 currentRatio = uint256(adapter.getRatio());
    uint256 snapshotRatio = adapter.getSnapshotRatio();
    uint256 maxRatio = _getMaxRatio(adapter);
    uint256 ratioDecimals = 10 ** adapter.RATIO_DECIMALS();

    assertEq(currentRatio / (ratioDecimals * 10), 0);
    assertEq(snapshotRatio / (ratioDecimals * 10), 0);
    assertEq(maxRatio / (ratioDecimals * 10), 0);
  }

  function _getMaxRatio(IPriceCapAdapter adapter) internal view returns (uint256) {
    return
      adapter.getSnapshotRatio() +
      adapter.getMaxRatioGrowthPerSecond() *
      (vm.getBlockTimestamp() - adapter.getSnapshotTimestamp());
  }

  function _runRetrospectiveAndReport(
    address adapterAddr,
    uint256 retrospectiveDays,
    string memory network,
    string memory reportName
  ) internal {
    delete _retrospectivePrices;

    IPriceCapAdapter adapter = IPriceCapAdapter(adapterAddr);
    uint256 finishBlock = block.number;
    uint256 step = BlockUtils.getBlocksPerDayByNetwork(network);
    uint256 currentBlock = finishBlock - retrospectiveDays * step;
    uint256 snapshotDelayDays = uint256(adapter.MINIMUM_SNAPSHOT_DELAY()) / SECONDS_PER_DAY;

    uint256 i = 0;
    while (currentBlock <= finishBlock) {
      vm.createSelectFork(vm.rpcUrl(network), currentBlock);

      int256 price = adapter.latestAnswer();
      int256 referencePrice = adapter.BASE_TO_USD_AGGREGATOR().latestAnswer();
      int256 ratio = adapter.getRatio();

      int256 dayToDayGrowth = 0;
      if (i > 0) {
        dayToDayGrowth = _calculateGrowthPercent(
          ratio,
          _retrospectivePrices[i - 1].ratio,
          vm.getBlockTimestamp(),
          _retrospectivePrices[i - 1].timestamp
        );
      }

      int256 smoothedGrowth = 0;
      if (i >= snapshotDelayDays && snapshotDelayDays > 0) {
        smoothedGrowth = _calculateGrowthPercent(
          ratio,
          _retrospectivePrices[i - snapshotDelayDays].ratio,
          vm.getBlockTimestamp(),
          _retrospectivePrices[i - snapshotDelayDays].timestamp
        );
      }

      _retrospectivePrices.push(
        PriceParams({
          sourcePrice: price,
          referencePrice: referencePrice,
          blockNumber: currentBlock,
          timestamp: vm.getBlockTimestamp(),
          ratio: ratio,
          dayToDayGrowth: dayToDayGrowth,
          smoothedGrowth: smoothedGrowth
        })
      );

      currentBlock += step;
      i++;
    }

    _generateReport(
      adapter.description(),
      adapter.BASE_TO_USD_AGGREGATOR().description(),
      adapter.decimals(),
      uint16(adapter.getMaxYearlyGrowthRatePercent()),
      snapshotDelayDays,
      reportName
    );

    vm.createSelectFork(vm.rpcUrl(network), finishBlock);
  }

  function _calculateGrowthPercent(
    int256 ratio,
    int256 previousRatio,
    uint256 currentTimestamp,
    uint256 previousTimestamp
  ) private pure returns (int256) {
    return
      (((ratio - previousRatio) * int256(SECONDS_PER_YEAR)) * 100_00) /
      (previousRatio * int256(currentTimestamp - previousTimestamp));
  }

  function _generateReport(
    string memory sourceName,
    string memory referenceName,
    uint8 decimals,
    uint16 maxYearlyGrowthPercent,
    uint256 snapshotDelayDays,
    string memory reportName
  ) private {
    string memory jsonPath = _generateJsonReport(
      sourceName,
      referenceName,
      decimals,
      maxYearlyGrowthPercent,
      snapshotDelayDays,
      reportName
    );
    _generateMdReport(jsonPath, reportName);

    string[] memory rmInputs = new string[](2);
    rmInputs[0] = 'rm';
    rmInputs[1] = jsonPath;
    vm.ffi(rmInputs);
  }

  function _generateJsonReport(
    string memory sourceName,
    string memory referenceName,
    uint8 decimals,
    uint16 maxYearlyGrowthPercent,
    uint256 snapshotDelayDays,
    string memory reportName
  ) private returns (string memory) {
    string memory path = string(abi.encodePacked('./reports/', reportName, '.json'));

    vm.serializeString('root', 'source', sourceName);
    vm.serializeString('root', 'reference', referenceName);
    vm.serializeUint('root', 'decimals', decimals);
    vm.serializeUint('root', 'maxYearlyGrowthPercent', maxYearlyGrowthPercent);
    vm.serializeUint('root', 'minSnapshotDelay', snapshotDelayDays);

    string memory pricesKey = 'prices';
    vm.serializeJson(pricesKey, '{}');
    string memory content = '{}';

    for (uint256 i = 0; i < _retrospectivePrices.length; i++) {
      string memory key = vm.toString(_retrospectivePrices[i].blockNumber);
      vm.serializeJson(key, '{}');
      vm.serializeUint(key, 'timestamp', _retrospectivePrices[i].timestamp);
      vm.serializeInt(key, 'sourcePrice', _retrospectivePrices[i].sourcePrice);
      vm.serializeInt(key, 'referencePrice', _retrospectivePrices[i].referencePrice);
      vm.serializeInt(key, 'dayToDayGrowth', _retrospectivePrices[i].dayToDayGrowth);
      string memory object = vm.serializeInt(
        key,
        'smoothedGrowth',
        _retrospectivePrices[i].smoothedGrowth
      );
      content = vm.serializeString(pricesKey, key, object);
    }

    string memory output = vm.serializeString('root', pricesKey, content);
    vm.writeJson(output, path);

    return path;
  }

  function _generateMdReport(string memory sourcePath, string memory reportName) private {
    string memory outPath = string(abi.encodePacked('./diffs/', reportName, '.md'));

    string[] memory inputs = new string[](8);
    inputs[0] = 'npx';
    inputs[1] = '--yes';
    inputs[2] = 'tsx';
    inputs[3] = './src/helpers/capo/capo-report.ts';
    inputs[4] = '-i';
    inputs[5] = sourcePath;
    inputs[6] = '-o';
    inputs[7] = outPath;
    vm.ffi(inputs);
  }
}
