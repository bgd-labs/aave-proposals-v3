// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorInterface} from 'aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/dependencies/chainlink/AggregatorInterface.sol';
import {IAaveOracle} from 'aave-v3-origin/contracts/interfaces/IAaveOracle.sol';
import {IPool} from 'aave-v3-origin/contracts/interfaces/IPool.sol';
import {IPoolAddressesProvider} from 'aave-v3-origin/contracts/interfaces/IPoolAddressesProvider.sol';
import {ProtocolV3HorizonTestBase, ReserveConfig} from 'tests/utils/ProtocolV3HorizonTestBase.sol';
import {AaveV3EthereumHorizon, AaveV3EthereumHorizonAssets} from 'aave-address-book-latest/AaveV3EthereumHorizon.sol';
import {AaveV3EthereumHorizonCustom} from 'src/utils/AaveV3EthereumHorizonCustom.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book-latest/AaveV3Ethereum.sol';
import {ChainlinkEthereum} from 'aave-address-book/ChainlinkEthereum.sol';
import {IPriceCapAdapterStable} from 'src/interfaces/IPriceCapAdapterStable.sol';
import {AaveV3Horizon_PriceFeed_20260404} from './AaveV3Horizon_PriceFeed_20260404.sol';

/**
 * @dev Test for RLUSD & USDC price feed update on Horizon.
 * command: FOUNDRY_PROFILE=test forge test --match-contract AaveV3Horizon_PriceFeed_20260404_Test -vv
 */
contract AaveV3Horizon_PriceFeed_20260404_Test is ProtocolV3HorizonTestBase {
  AaveV3Horizon_PriceFeed_20260404 internal proposal;

  address internal constant OLD_RLUSD_ORACLE = AaveV3EthereumHorizonAssets.RLUSD_ORACLE;
  address internal constant OLD_USDC_ORACLE = AaveV3EthereumHorizonAssets.USDC_ORACLE;

  address internal newRlusdOracle; // stable cap adapter
  address internal newUsdcOracle; // stable cap adapter

  IPriceCapAdapterStable internal rlusdAdapter;
  IPriceCapAdapterStable internal usdcAdapter;

  /// 10200 bps expressed in the 8-decimal feed precision used by the adapter.
  int256 internal constant EXPECTED_PRICE_CAP = int256(10200) * 1e4;
  /// 1 BPS = 0.01% expressed in 1e18 precision for approxEqRel assertion
  uint256 internal constant ONE_BPS = 1e14;

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25424006);
    proposal = new AaveV3Horizon_PriceFeed_20260404();

    newRlusdOracle = proposal.NEW_RLUSD_ORACLE();
    newUsdcOracle = proposal.NEW_USDC_ORACLE();

    rlusdAdapter = IPriceCapAdapterStable(newRlusdOracle);
    usdcAdapter = IPriceCapAdapterStable(newUsdcOracle);
  }

  /**
   * @dev Full test suite: snapshots, state diff, validations, e2e.
   */
  function test_defaultProposalExecution() public virtual {
    defaultTest_v3_3('AaveV3Horizon_PriceFeed_20260404', _pool(), _executePayload);
  }

  function test_addressBook_oracle_matches() public view virtual {
    // address book ORACLE constant matches the live pool oracle
    assertEq(
      IPoolAddressesProvider(_pool().ADDRESSES_PROVIDER()).getPriceOracle(),
      address(AaveV3EthereumHorizon.ORACLE),
      'address book ORACLE != live pool oracle'
    );
  }

  /// @dev BEFORE: RLUSD source matches address book, differs from V3 core
  function test_RLUSD_oracleSource_before() public virtual {
    IAaveOracle oracle = IAaveOracle(AaveV3EthereumHorizon.ORACLE);
    address RLUSD = AaveV3EthereumHorizonAssets.RLUSD_UNDERLYING;

    assertEq(
      oracle.getSourceOfAsset(RLUSD),
      AaveV3EthereumHorizonAssets.RLUSD_ORACLE,
      'live RLUSD source != address book RLUSD_ORACLE'
    );
    assertEq(oracle.getSourceOfAsset(RLUSD), OLD_RLUSD_ORACLE, 'RLUSD oracle before');
    assertNotEq(
      oracle.getSourceOfAsset(RLUSD),
      AaveV3EthereumAssets.RLUSD_ORACLE,
      'RLUSD oracle should differ from V3 core before'
    );
  }

  /// @dev AFTER: payload wires RLUSD to the new cap adapter and the pool reports a positive price
  function test_RLUSD_oracleSource_after() public virtual {
    IAaveOracle oracle = IAaveOracle(AaveV3EthereumHorizon.ORACLE);
    address RLUSD = AaveV3EthereumHorizonAssets.RLUSD_UNDERLYING;

    _executePayload();

    assertEq(oracle.getSourceOfAsset(RLUSD), newRlusdOracle, 'RLUSD oracle after');
    assertGt(oracle.getAssetPrice(RLUSD), 0, 'RLUSD price must be > 0 after');
  }

  /// @dev BEFORE: USDC source matches address book entry, differs from V3 core
  function test_USDC_oracleSource_before() public virtual {
    IAaveOracle oracle = IAaveOracle(AaveV3EthereumHorizon.ORACLE);
    address USDC = AaveV3EthereumHorizonAssets.USDC_UNDERLYING;

    assertEq(
      oracle.getSourceOfAsset(USDC),
      AaveV3EthereumHorizonAssets.USDC_ORACLE,
      'live USDC source != address book USDC_ORACLE'
    );
    assertEq(oracle.getSourceOfAsset(USDC), OLD_USDC_ORACLE, 'USDC oracle before');
    assertNotEq(
      oracle.getSourceOfAsset(USDC),
      AaveV3EthereumAssets.USDC_ORACLE,
      'USDC oracle should differ from V3 core before'
    );
  }

  /// @dev AFTER: USDC source is updated to the new cap adapter and the pool reports a positive price
  function test_USDC_oracleSource_after() public virtual {
    IAaveOracle oracle = IAaveOracle(AaveV3EthereumHorizon.ORACLE);
    address USDC = AaveV3EthereumHorizonAssets.USDC_UNDERLYING;

    _executePayload();

    assertEq(oracle.getSourceOfAsset(USDC), newUsdcOracle, 'USDC oracle after');
    assertGt(oracle.getAssetPrice(USDC), 0, 'USDC price must be > 0 after');
  }

  /// @dev DELTA: end-to-end price stays within 1 BPS
  function test_RLUSD_price_delta() public virtual {
    IAaveOracle oracle = IAaveOracle(AaveV3EthereumHorizon.ORACLE);
    address RLUSD = AaveV3EthereumHorizonAssets.RLUSD_UNDERLYING;
    uint256 priceBefore = oracle.getAssetPrice(RLUSD);

    _executePayload();

    uint256 priceAfter = oracle.getAssetPrice(RLUSD);
    assertApproxEqRel(
      priceAfter,
      priceBefore,
      ONE_BPS,
      'RLUSD price must be within 1 BPS of prior'
    );
  }

  /// @dev DELTA: end-to-end USDC price stays within 1 BPS
  function test_USDC_price_delta() public virtual {
    IAaveOracle oracle = IAaveOracle(AaveV3EthereumHorizon.ORACLE);
    address USDC = AaveV3EthereumHorizonAssets.USDC_UNDERLYING;
    uint256 priceBefore = oracle.getAssetPrice(USDC);

    _executePayload();

    uint256 priceAfter = oracle.getAssetPrice(USDC);
    assertApproxEqRel(priceAfter, priceBefore, ONE_BPS, 'USDC price must be within 1 BPS of prior');
  }

  /// @dev GHO already matches V3 core pre-exec (no migration needed)
  function test_GHO_oracleMatchesV3Core() public virtual {
    IAaveOracle oracle = IAaveOracle(AaveV3EthereumHorizon.ORACLE);
    assertEq(
      oracle.getSourceOfAsset(AaveV3EthereumHorizonAssets.GHO_UNDERLYING),
      AaveV3EthereumAssets.GHO_ORACLE,
      'GHO oracle should already match V3 core'
    );

    _executePayload();

    assertEq(
      oracle.getSourceOfAsset(AaveV3EthereumHorizonAssets.GHO_UNDERLYING),
      AaveV3EthereumAssets.GHO_ORACLE,
      'GHO oracle should still match V3 core after execution'
    );
  }

  /// @dev RLUSD stable cap adapter constructor params.
  function test_RLUSD_AdapterParams() public view virtual {
    assertEq(
      rlusdAdapter.ACL_MANAGER(),
      address(AaveV3EthereumHorizon.ACL_MANAGER),
      'RLUSD adapter ACL_MANAGER mismatch'
    );
    assertEq(
      rlusdAdapter.ASSET_TO_USD_AGGREGATOR(),
      AaveV3EthereumHorizonAssets.RLUSD_ORACLE,
      'RLUSD adapter underlying must be Horizon feed'
    );
    assertEq(
      rlusdAdapter.ASSET_TO_USD_AGGREGATOR(),
      ChainlinkEthereum.RLUSD_USD,
      'RLUSD adapter underlying must equal the non-SVR Chainlink RLUSD/USD feed'
    );
    assertEq(rlusdAdapter.getPriceCap(), EXPECTED_PRICE_CAP, 'RLUSD adapter price cap mismatch');
  }

  /// @dev USDC stable cap adapter constructor params.
  function test_USDC_AdapterParams() public view virtual {
    assertEq(
      usdcAdapter.ACL_MANAGER(),
      address(AaveV3EthereumHorizon.ACL_MANAGER),
      'USDC adapter ACL_MANAGER mismatch'
    );
    assertEq(
      usdcAdapter.ASSET_TO_USD_AGGREGATOR(),
      AaveV3EthereumHorizonAssets.USDC_ORACLE,
      'USDC adapter underlying must be Horizon feed'
    );
    assertEq(
      usdcAdapter.ASSET_TO_USD_AGGREGATOR(),
      ChainlinkEthereum.USDC_USD,
      'USDC adapter underlying must equal the non-SVR Chainlink USDC/USD feed'
    );
    assertEq(usdcAdapter.getPriceCap(), EXPECTED_PRICE_CAP, 'USDC adapter price cap mismatch');
  }

  /// @dev New adapters must report 8 decimals to match the oracle convention
  function test_newAdapters_decimals() public view virtual {
    assertEq(AggregatorInterface(newRlusdOracle).decimals(), 8, 'RLUSD adapter decimals');
    assertEq(AggregatorInterface(newUsdcOracle).decimals(), 8, 'USDC adapter decimals');
  }

  /// @dev underlying Chainlink aggregators feeding each adapter report a fresh
  /// updatedAt (within USDC/USD and RLUSD/USD heartbeats)
  function test_oracleFreshness_before() public virtual {
    uint256 maxStaleness = 26 hours;

    address rlusdUnderlyingFeed = rlusdAdapter.ASSET_TO_USD_AGGREGATOR();
    (, int256 rlusdAnswer, , uint256 rlusdUpdatedAt, ) = AggregatorInterface(rlusdUnderlyingFeed)
      .latestRoundData();
    assertGt(rlusdAnswer, 0, 'RLUSD underlying answer should be > 0');
    assertGt(rlusdUpdatedAt, 0, 'RLUSD underlying updatedAt should be > 0');
    assertLt(
      block.timestamp - rlusdUpdatedAt,
      maxStaleness,
      'RLUSD underlying updatedAt older than heartbeat'
    );

    address usdcUnderlyingFeed = usdcAdapter.ASSET_TO_USD_AGGREGATOR();
    (, int256 usdcAnswer, , uint256 usdcUpdatedAt, ) = AggregatorInterface(usdcUnderlyingFeed)
      .latestRoundData();
    assertGt(usdcAnswer, 0, 'USDC underlying answer should be > 0');
    assertGt(usdcUpdatedAt, 0, 'USDC underlying updatedAt should be > 0');
    assertLt(
      block.timestamp - usdcUpdatedAt,
      maxStaleness,
      'USDC underlying updatedAt older than heartbeat'
    );
  }

  /// @dev new adapters are already deployed and live (latestAnswer > 0)
  /// and aligned with the currently configured oracles to within 1 BPS
  function test_priceFeeds_aligned_before() public virtual {
    int256 oldRlusd = AggregatorInterface(OLD_RLUSD_ORACLE).latestAnswer();
    int256 newRlusd = AggregatorInterface(newRlusdOracle).latestAnswer();
    assertGt(newRlusd, 0, 'new RLUSD adapter latestAnswer should be > 0');
    assertGt(oldRlusd, 0, 'old RLUSD oracle latestAnswer should be > 0');
    assertApproxEqRel(
      uint256(newRlusd),
      uint256(oldRlusd),
      ONE_BPS,
      'RLUSD: new adapter vs old oracle pre-exec diff > 1 BPS'
    );

    int256 oldUsdc = AggregatorInterface(OLD_USDC_ORACLE).latestAnswer();
    int256 newUsdc = AggregatorInterface(newUsdcOracle).latestAnswer();
    assertGt(newUsdc, 0, 'new USDC adapter latestAnswer should be > 0');
    assertGt(oldUsdc, 0, 'old USDC oracle latestAnswer should be > 0');
    assertApproxEqRel(
      uint256(newUsdc),
      uint256(oldUsdc),
      ONE_BPS,
      'USDC: new adapter vs old oracle pre-exec diff > 1 BPS'
    );
  }

  /// @dev after exec, exactly the two target reserves had
  /// their oracle source changed, all other reserves keep their prior source
  function test_noOldFeedRemains_delta() public virtual {
    IPool pool = _pool();
    IAaveOracle oracle = IAaveOracle(AaveV3EthereumHorizon.ORACLE);
    address[] memory reserves = pool.getReservesList();

    address[] memory sourcesBefore = new address[](reserves.length);
    for (uint256 i; i < reserves.length; ++i) {
      sourcesBefore[i] = oracle.getSourceOfAsset(reserves[i]);
    }

    _executePayload();

    address[] memory sourcesAfter = new address[](reserves.length);
    address[] memory replacedFeeds = new address[](reserves.length);
    uint256 replacedCount;
    for (uint256 i; i < reserves.length; ++i) {
      sourcesAfter[i] = oracle.getSourceOfAsset(reserves[i]);
      if (sourcesBefore[i] != sourcesAfter[i]) {
        replacedFeeds[replacedCount++] = sourcesBefore[i];
      }
    }

    assertEq(replacedCount, 2, 'expected exactly 2 reserves with oracle source change');

    for (uint256 i; i < reserves.length; ++i) {
      if (
        reserves[i] == AaveV3EthereumHorizonAssets.RLUSD_UNDERLYING ||
        reserves[i] == AaveV3EthereumHorizonAssets.USDC_UNDERLYING
      ) {
        continue;
      }
      assertEq(
        sourcesAfter[i],
        sourcesBefore[i],
        string.concat('non-target reserve oracle changed: ', vm.toString(reserves[i]))
      );
    }

    for (uint256 i; i < reserves.length; ++i) {
      for (uint256 k; k < replacedCount; ++k) {
        assertNotEq(
          sourcesAfter[i],
          replacedFeeds[k],
          string.concat(
            'reserve ',
            vm.toString(reserves[i]),
            ' still uses replaced feed ',
            vm.toString(replacedFeeds[k])
          )
        );
      }
    }
  }

  /// @dev Reserves list is unchanged
  function test_reservesList_unchanged_delta() public virtual {
    IPool pool = _pool();
    address[] memory before = pool.getReservesList();

    _executePayload();

    address[] memory afterList = pool.getReservesList();
    assertEq(afterList.length, before.length, 'reservesList length changed');
    for (uint256 i; i < before.length; ++i) {
      assertEq(
        afterList[i],
        before[i],
        string.concat('reservesList[', vm.toString(i), '] changed')
      );
    }
  }

  function test_feedDescriptions() public view virtual {
    assertEq(
      AggregatorInterface(newRlusdOracle).description(),
      'Capped RLUSD / USD',
      'RLUSD adapter description mismatch'
    );
    assertEq(
      AggregatorInterface(rlusdAdapter.ASSET_TO_USD_AGGREGATOR()).description(),
      'RLUSD / USD',
      'RLUSD underlying description mismatch'
    );
    assertEq(
      AggregatorInterface(newUsdcOracle).description(),
      'Capped USDC / USD',
      'USDC adapter description mismatch'
    );
    assertEq(
      AggregatorInterface(usdcAdapter.ASSET_TO_USD_AGGREGATOR()).description(),
      'USDC / USD',
      'USDC underlying description mismatch'
    );
  }

  /// @dev When the Chainlink feed reports a price above the adapter's cap, the
  /// pool oracle's `getAssetPrice` must bound to the cap
  function test_priceCapBounded_viaPool_after() public virtual {
    _executePayload();

    IAaveOracle oracle = IAaveOracle(AaveV3EthereumHorizon.ORACLE);

    _assertCapBounded(oracle, AaveV3EthereumHorizonAssets.RLUSD_UNDERLYING, rlusdAdapter, 'RLUSD');
    _assertCapBounded(oracle, AaveV3EthereumHorizonAssets.USDC_UNDERLYING, usdcAdapter, 'USDC');
  }

  /// @dev when the underlying feed reports a price below the cap, the pool oracle must pass it through uncapped
  function test_priceFlowsThrough_belowCap_viaPool_after() public virtual {
    _executePayload();

    IAaveOracle oracle = IAaveOracle(AaveV3EthereumHorizon.ORACLE);

    _assertPriceFlowsThrough(
      oracle,
      AaveV3EthereumHorizonAssets.RLUSD_UNDERLYING,
      rlusdAdapter,
      'RLUSD'
    );
    _assertPriceFlowsThrough(
      oracle,
      AaveV3EthereumHorizonAssets.USDC_UNDERLYING,
      usdcAdapter,
      'USDC'
    );
  }

  /// @dev For every reserve, the ReserveConfigurationMap should be unchanged
  function test_reserveConfig_unchanged_nonTarget_delta() public virtual {
    IPool pool = _pool();
    address[] memory reserves = pool.getReservesList();
    uint256[] memory beforeData = new uint256[](reserves.length);

    for (uint256 i; i < reserves.length; ++i) {
      beforeData[i] = pool.getConfiguration(reserves[i]).data;
    }

    _executePayload();

    for (uint256 i; i < reserves.length; ++i) {
      assertEq(
        pool.getConfiguration(reserves[i]).data,
        beforeData[i],
        string.concat('non-target reserve config changed: ', vm.toString(reserves[i]))
      );
    }
  }

  /// @dev `setPriceCap` only callable by `CallerIsNotRiskOrPoolAdmin`
  function test_setPriceCap_unauthorized_reverts() public virtual {
    address randomUser = makeAddr('randomUser');

    vm.prank(randomUser);
    vm.expectRevert();
    rlusdAdapter.setPriceCap(int256(1));

    vm.prank(randomUser);
    vm.expectRevert();
    usdcAdapter.setPriceCap(int256(1));
  }

  /// @dev Counter-test: a legitimate RiskAdmin (HORIZON_OPS) CAN update the cap
  function test_setPriceCap_authorized_succeeds() public virtual {
    int256 newCap = int256(1.03e8);
    address riskAdmin = AaveV3EthereumHorizonCustom.HORIZON_OPS;

    vm.prank(riskAdmin);
    rlusdAdapter.setPriceCap(newCap);
    assertEq(rlusdAdapter.getPriceCap(), newCap, 'RLUSD cap not updated');

    vm.prank(riskAdmin);
    usdcAdapter.setPriceCap(newCap);
    assertEq(usdcAdapter.getPriceCap(), newCap, 'USDC cap not updated');
  }

  /// @dev Fuzz: for any positive underlying answer, the pool oracle returns
  /// `min(underlying, cap)`
  function test_priceCap_fuzz_minOfUnderlyingAndCap_after(int256 underlyingAnswer) public virtual {
    underlyingAnswer = int256(bound(underlyingAnswer, 1, int256(type(int128).max)));

    _executePayload();
    IAaveOracle oracle = IAaveOracle(AaveV3EthereumHorizon.ORACLE);

    _assertFuzzedBounded(
      oracle,
      AaveV3EthereumHorizonAssets.RLUSD_UNDERLYING,
      rlusdAdapter,
      underlyingAnswer,
      'RLUSD'
    );
    _assertFuzzedBounded(
      oracle,
      AaveV3EthereumHorizonAssets.USDC_UNDERLYING,
      usdcAdapter,
      underlyingAnswer,
      'USDC'
    );
  }

  /// @dev Defensive: before the payload runs, neither new adapter is already wired
  /// to any reserve. Catches a deploy-time collision
  function test_newAdapters_notAlreadySet_before() public virtual {
    IAaveOracle oracle = IAaveOracle(AaveV3EthereumHorizon.ORACLE);
    address[] memory reserves = _pool().getReservesList();

    for (uint256 i; i < reserves.length; ++i) {
      address source = oracle.getSourceOfAsset(reserves[i]);
      assertNotEq(
        source,
        newRlusdOracle,
        string.concat(
          'reserve ',
          vm.toString(reserves[i]),
          ' already uses new RLUSD adapter pre-exec'
        )
      );
      assertNotEq(
        source,
        newUsdcOracle,
        string.concat(
          'reserve ',
          vm.toString(reserves[i]),
          ' already uses new USDC adapter pre-exec'
        )
      );
    }
  }

  /// @dev Post-exec: `oracle.getAssetPrice` equals `adapter.latestAnswer()` exactly.
  /// Catches scaling / decoding bugs at the IAaveOracle layer
  function test_adapterAnswer_matches_poolPrice_after() public virtual {
    _executePayload();

    IAaveOracle oracle = IAaveOracle(AaveV3EthereumHorizon.ORACLE);

    int256 rlusdAnswer = AggregatorInterface(newRlusdOracle).latestAnswer();
    assertGt(rlusdAnswer, 0, 'RLUSD adapter latestAnswer must be > 0');
    assertEq(
      oracle.getAssetPrice(AaveV3EthereumHorizonAssets.RLUSD_UNDERLYING),
      uint256(rlusdAnswer),
      'RLUSD: pool oracle price != adapter latestAnswer'
    );

    int256 usdcAnswer = AggregatorInterface(newUsdcOracle).latestAnswer();
    assertGt(usdcAnswer, 0, 'USDC adapter latestAnswer must be > 0');
    assertEq(
      oracle.getAssetPrice(AaveV3EthereumHorizonAssets.USDC_UNDERLYING),
      uint256(usdcAnswer),
      'USDC: pool oracle price != adapter latestAnswer'
    );
  }

  function _executePayload() internal virtual {
    _executeHorizonPayload(address(proposal));
  }

  function _assertCapBounded(
    IAaveOracle oracle,
    address underlying,
    IPriceCapAdapterStable adapter,
    string memory label
  ) internal {
    int256 priceCap = adapter.getPriceCap();
    int256 spike = priceCap + int256(1e7); // $0.10 above cap

    address underlyingFeed = adapter.ASSET_TO_USD_AGGREGATOR();
    vm.mockCall(
      underlyingFeed,
      abi.encodeWithSelector(AggregatorInterface.latestAnswer.selector),
      abi.encode(spike)
    );
    vm.mockCall(
      underlyingFeed,
      abi.encodeWithSelector(AggregatorInterface.latestRoundData.selector),
      abi.encode(uint80(1), spike, block.timestamp, block.timestamp, uint80(1))
    );

    uint256 priceFromPool = oracle.getAssetPrice(underlying);
    assertEq(
      priceFromPool,
      uint256(priceCap),
      string.concat(label, ': pool oracle price not clamped to cap on upstream spike')
    );

    vm.clearMockedCalls();
  }

  function _assertPriceFlowsThrough(
    IAaveOracle oracle,
    address underlying,
    IPriceCapAdapterStable adapter,
    string memory label
  ) internal {
    int256 priceCap = adapter.getPriceCap();
    int256 belowCap = priceCap - int256(1e6); // $0.01 below cap in 8-decimal precision
    require(belowCap > 0, 'belowCap should be positive');

    address underlyingFeed = adapter.ASSET_TO_USD_AGGREGATOR();
    vm.mockCall(
      underlyingFeed,
      abi.encodeWithSelector(AggregatorInterface.latestAnswer.selector),
      abi.encode(belowCap)
    );
    vm.mockCall(
      underlyingFeed,
      abi.encodeWithSelector(AggregatorInterface.latestRoundData.selector),
      abi.encode(uint80(1), belowCap, block.timestamp, block.timestamp, uint80(1))
    );

    uint256 priceFromPool = oracle.getAssetPrice(underlying);
    assertEq(
      priceFromPool,
      uint256(belowCap),
      string.concat(label, ': pool oracle should pass through underlying when below cap')
    );

    vm.clearMockedCalls();
  }

  function _assertFuzzedBounded(
    IAaveOracle oracle,
    address underlying,
    IPriceCapAdapterStable adapter,
    int256 underlyingAnswer,
    string memory label
  ) internal {
    int256 cap = adapter.getPriceCap();
    int256 expected = underlyingAnswer < cap ? underlyingAnswer : cap;

    vm.mockCall(
      adapter.ASSET_TO_USD_AGGREGATOR(),
      abi.encodeWithSelector(AggregatorInterface.latestAnswer.selector),
      abi.encode(underlyingAnswer)
    );

    uint256 actual = oracle.getAssetPrice(underlying);
    assertEq(
      actual,
      uint256(expected),
      string.concat(label, ': pool price != min(underlying, cap)')
    );

    vm.clearMockedCalls();
  }

  /// @dev Override expected price feeds so the snapshot validator in defaultTest accepts the new oracles.
  /// Returns the proposal's `NEW_*_ORACLE` constants as literals to keep this `pure` (matching the base helper).
  function _expectedPriceFeed(address underlying) internal pure override returns (address) {
    if (underlying == AaveV3EthereumHorizonAssets.RLUSD_UNDERLYING) {
      return 0x9E7c31e9b3C76Ea759D9f7464210353862F0c957; // NEW_RLUSD_ORACLE
    }
    if (underlying == AaveV3EthereumHorizonAssets.USDC_UNDERLYING) {
      return 0x46f94aff8cF7DdC8557eF69f7276087b01C8f363; // NEW_USDC_ORACLE
    }
    return super._expectedPriceFeed(underlying);
  }
}
