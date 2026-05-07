// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {BasicIACLManager} from 'aave-address-book/AaveV3.sol';
import {IPriceCapAdapter} from 'src/interfaces/IPriceCapAdapter.sol';
import {BlockUtils} from './utils/BlockUtils.sol';

abstract contract CAPOUpdateBaseTest is Test {
  uint256 internal constant SECONDS_PER_DAY = 86400;
  uint256 internal constant SECONDS_PER_YEAR = 365 days;
  uint256 internal constant PERCENTAGE_FACTOR = 1e4;

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

  function _runPostExecutionAssertions(OracleExpectation memory e) internal {
    _executePayload();
    _assertSnapshotApplied(e);
    _assertLatestAnswerSane(e.adapter);
    _assertConfiguration(e.adapter);
    _assertCapTriggers(e.adapter);
  }

  function _preservedGrowth(address adapter) internal view returns (uint16) {
    // cast down should be safe
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

  function _getMaxRatio(IPriceCapAdapter adapter) private view returns (uint256) {
    return
      adapter.getSnapshotRatio() +
      adapter.getMaxRatioGrowthPerSecond() *
      (block.timestamp - adapter.getSnapshotTimestamp());
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
          block.timestamp,
          _retrospectivePrices[i - 1].timestamp
        );
      }

      int256 smoothedGrowth = 0;
      if (i >= snapshotDelayDays && snapshotDelayDays > 0) {
        smoothedGrowth = _calculateGrowthPercent(
          ratio,
          _retrospectivePrices[i - snapshotDelayDays].ratio,
          block.timestamp,
          _retrospectivePrices[i - snapshotDelayDays].timestamp
        );
      }

      _retrospectivePrices.push(
        PriceParams({
          sourcePrice: price,
          referencePrice: referencePrice,
          blockNumber: currentBlock,
          timestamp: block.timestamp,
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

    string[] memory inputs = new string[](6);
    inputs[0] = './node_modules/.bin/tsx';
    inputs[1] = './src/helpers/capo/capo-report.ts';
    inputs[2] = '-i';
    inputs[3] = sourcePath;
    inputs[4] = '-o';
    inputs[5] = outPath;
    vm.ffi(inputs);
  }
}
