// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {GovV3Helpers, ChainIds} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IHub} from './interfaces/IHub.sol';
import {ISpoke} from './interfaces/ISpoke.sol';
import {AaveV4EthereumAddresses, AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumAssets, AaveV4EthereumTokenizationSpokes} from './AaveV4EthereumAddresses.sol';
import {AaveV4Ethereum_ActivateV4Ethereum_20260319} from './AaveV4Ethereum_ActivateV4Ethereum_20260319.sol';

/**
 * @dev Verifies Aave V4 Ethereum hub-spoke configuration matches the deployment spec.
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260319_AaveV4Ethereum_ActivateV4Ethereum/AaveV4Ethereum_HubSpokeConfiguration_20260319.t.sol -vv
 */
contract AaveV4Ethereum_HubSpokeConfiguration_20260319_Test is Test {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24729090);

    // Execute the activation proposal
    GovV3Helpers.executePayload(
      vm,
      address(new AaveV4Ethereum_ActivateV4Ethereum_20260319()),
      address(GovV3Helpers.getPayloadsController(ChainIds.MAINNET))
    );
  }

  // ---------------------------------------------------------------------------
  // Core Hub Spokes
  // ---------------------------------------------------------------------------

  function test_mainSpokeConfiguration() public view {
    ISpoke spoke = AaveV4EthereumSpokes.MAIN_SPOKE;
    IHub hub = AaveV4EthereumHubs.CORE_HUB;

    // Main Spoke: 14 reserves, all on Core Hub
    // Collateral (9): wETH, wstETH, weETH, wBTC, cbBTC, USDT, USDC, LINK, AAVE
    // Borrowable (10): wBTC, cbBTC, wETH, USDT, USDC, USDG, RLUSD, frxUSD, GHO, EURC
    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(
      spoke,
      hub
    );
    assertEq(total, 14, 'Main Spoke: wrong total reserve count');
    assertEq(onHub, 14, 'Main Spoke: all reserves should be on Core Hub');
    assertEq(collateral, 9, 'Main Spoke: wrong collateral count');
    assertEq(borrowable, 10, 'Main Spoke: wrong borrowable count');

    // Collateral + borrowable
    _assertCollateralAndBorrowable(spoke, hub, AaveV3EthereumAssets.WETH_UNDERLYING, 'WETH');
    _assertCollateralAndBorrowable(spoke, hub, AaveV3EthereumAssets.WBTC_UNDERLYING, 'WBTC');
    _assertCollateralAndBorrowable(spoke, hub, AaveV3EthereumAssets.cbBTC_UNDERLYING, 'cbBTC');
    _assertCollateralAndBorrowable(spoke, hub, AaveV3EthereumAssets.USDT_UNDERLYING, 'USDT');
    _assertCollateralAndBorrowable(spoke, hub, AaveV3EthereumAssets.USDC_UNDERLYING, 'USDC');

    // Collateral only
    _assertOnlyCollateral(spoke, hub, AaveV3EthereumAssets.wstETH_UNDERLYING, 'wstETH');
    _assertOnlyCollateral(spoke, hub, AaveV3EthereumAssets.weETH_UNDERLYING, 'weETH');
    _assertOnlyCollateral(spoke, hub, AaveV3EthereumAssets.LINK_UNDERLYING, 'LINK');
    _assertOnlyCollateral(spoke, hub, AaveV3EthereumAssets.AAVE_UNDERLYING, 'AAVE');

    // Borrowable only
    _assertOnlyBorrowable(spoke, hub, AaveV4EthereumAssets.USDG, 'USDG');
    _assertOnlyBorrowable(spoke, hub, AaveV4EthereumAssets.RLUSD, 'RLUSD');
    _assertOnlyBorrowable(spoke, hub, AaveV4EthereumAssets.frxUSD, 'frxUSD');
    _assertOnlyBorrowable(spoke, hub, AaveV3EthereumAssets.GHO_UNDERLYING, 'GHO');
    _assertOnlyBorrowable(spoke, hub, AaveV3EthereumAssets.EURC_UNDERLYING, 'EURC');
  }

  function test_lidoSpokeConfiguration() public view {
    ISpoke spoke = AaveV4EthereumSpokes.LIDO_ESPOKE;
    IHub hub = AaveV4EthereumHubs.CORE_HUB;

    // Lido eSpoke: 2 reserves on Core Hub
    // Collateral (1): wstETH
    // Borrowable (1): wETH
    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(
      spoke,
      hub
    );
    assertEq(total, 2, 'Lido eSpoke: wrong total reserve count');
    assertEq(onHub, 2, 'Lido eSpoke: all reserves should be on Core Hub');
    assertEq(collateral, 1, 'Lido eSpoke: wrong collateral count');
    assertEq(borrowable, 1, 'Lido eSpoke: wrong borrowable count');

    _assertOnlyCollateral(spoke, hub, AaveV3EthereumAssets.wstETH_UNDERLYING, 'wstETH');

    _assertOnlyBorrowable(spoke, hub, AaveV3EthereumAssets.WETH_UNDERLYING, 'WETH');
  }

  function test_etherfiSpokeConfiguration() public view {
    ISpoke spoke = AaveV4EthereumSpokes.ETHERFI_ESPOKE;
    IHub hub = AaveV4EthereumHubs.CORE_HUB;

    // EtherFi eSpoke: 2 reserves on Core Hub
    // Collateral (1): weETH
    // Borrowable (1): wETH
    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(
      spoke,
      hub
    );
    assertEq(total, 2, 'EtherFi eSpoke: wrong total reserve count');
    assertEq(onHub, 2, 'EtherFi eSpoke: all reserves should be on Core Hub');
    assertEq(collateral, 1, 'EtherFi eSpoke: wrong collateral count');
    assertEq(borrowable, 1, 'EtherFi eSpoke: wrong borrowable count');

    _assertOnlyCollateral(spoke, hub, AaveV3EthereumAssets.weETH_UNDERLYING, 'weETH');

    _assertOnlyBorrowable(spoke, hub, AaveV3EthereumAssets.WETH_UNDERLYING, 'WETH');
  }

  function test_kelpSpokeConfiguration() public view {
    ISpoke spoke = AaveV4EthereumSpokes.KELP_ESPOKE;
    IHub hub = AaveV4EthereumHubs.CORE_HUB;

    // Kelp eSpoke: 2 reserves on Core Hub
    // Collateral (1): rsETH
    // Borrowable (1): wETH
    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(
      spoke,
      hub
    );
    assertEq(total, 2, 'Kelp eSpoke: wrong total reserve count');
    assertEq(onHub, 2, 'Kelp eSpoke: all reserves should be on Core Hub');
    assertEq(collateral, 1, 'Kelp eSpoke: wrong collateral count');
    assertEq(borrowable, 1, 'Kelp eSpoke: wrong borrowable count');

    _assertOnlyCollateral(spoke, hub, AaveV3EthereumAssets.rsETH_UNDERLYING, 'rsETH');

    _assertOnlyBorrowable(spoke, hub, AaveV3EthereumAssets.WETH_UNDERLYING, 'WETH');
  }

  function test_lombardSpokeConfiguration() public view {
    ISpoke spoke = AaveV4EthereumSpokes.LOMBARD_BTC_SPOKE;
    IHub hub = AaveV4EthereumHubs.CORE_HUB;

    // Lombard BTC Spoke: 3 reserves on Core Hub
    // Collateral (1): LBTC
    // Borrowable (2): wBTC, cbBTC
    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(
      spoke,
      hub
    );
    assertEq(total, 3, 'Lombard Spoke: wrong total reserve count');
    assertEq(onHub, 3, 'Lombard Spoke: all reserves should be on Core Hub');
    assertEq(collateral, 1, 'Lombard Spoke: wrong collateral count');
    assertEq(borrowable, 2, 'Lombard Spoke: wrong borrowable count');

    _assertOnlyCollateral(spoke, hub, AaveV3EthereumAssets.LBTC_UNDERLYING, 'LBTC');

    _assertOnlyBorrowable(spoke, hub, AaveV3EthereumAssets.WBTC_UNDERLYING, 'WBTC');
    _assertOnlyBorrowable(spoke, hub, AaveV3EthereumAssets.cbBTC_UNDERLYING, 'cbBTC');
  }

  function test_goldSpokeConfiguration() public view {
    ISpoke spoke = AaveV4EthereumSpokes.GOLD_SPOKE;
    IHub hub = AaveV4EthereumHubs.CORE_HUB;

    // Gold Spoke: 8 reserves on Core Hub
    // Collateral (1): XAUt
    // Borrowable (7): USDT, USDC, USDG, RLUSD, frxUSD, GHO, EURC
    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(
      spoke,
      hub
    );
    assertEq(total, 8, 'Gold Spoke: wrong total reserve count');
    assertEq(onHub, 8, 'Gold Spoke: all reserves should be on Core Hub');
    assertEq(collateral, 1, 'Gold Spoke: wrong collateral count');
    assertEq(borrowable, 7, 'Gold Spoke: wrong borrowable count');

    _assertOnlyCollateral(spoke, hub, AaveV4EthereumAssets.XAUt, 'XAUt');

    _assertOnlyBorrowable(spoke, hub, AaveV3EthereumAssets.USDT_UNDERLYING, 'USDT');
    _assertOnlyBorrowable(spoke, hub, AaveV3EthereumAssets.USDC_UNDERLYING, 'USDC');
    _assertOnlyBorrowable(spoke, hub, AaveV4EthereumAssets.USDG, 'USDG');
    _assertOnlyBorrowable(spoke, hub, AaveV4EthereumAssets.RLUSD, 'RLUSD');
    _assertOnlyBorrowable(spoke, hub, AaveV4EthereumAssets.frxUSD, 'frxUSD');
    _assertOnlyBorrowable(spoke, hub, AaveV3EthereumAssets.GHO_UNDERLYING, 'GHO');
    _assertOnlyBorrowable(spoke, hub, AaveV3EthereumAssets.EURC_UNDERLYING, 'EURC');
  }

  function test_forexSpokeConfiguration() public view {
    ISpoke spoke = AaveV4EthereumSpokes.FOREX_SPOKE;
    IHub hub = AaveV4EthereumHubs.CORE_HUB;

    // Forex Spoke: 7 reserves on Core Hub
    // Collateral (3): USDT, USDC, EURC
    // Borrowable (7): USDT, USDC, USDG, RLUSD, frxUSD, GHO, EURC
    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(
      spoke,
      hub
    );
    assertEq(total, 7, 'Forex Spoke: wrong total reserve count');
    assertEq(onHub, 7, 'Forex Spoke: all reserves should be on Core Hub');
    assertEq(collateral, 3, 'Forex Spoke: wrong collateral count');
    assertEq(borrowable, 7, 'Forex Spoke: wrong borrowable count');

    // Collateral + borrowable
    _assertCollateralAndBorrowable(spoke, hub, AaveV3EthereumAssets.USDT_UNDERLYING, 'USDT');
    _assertCollateralAndBorrowable(spoke, hub, AaveV3EthereumAssets.USDC_UNDERLYING, 'USDC');
    _assertCollateralAndBorrowable(spoke, hub, AaveV3EthereumAssets.EURC_UNDERLYING, 'EURC');

    // Borrowable only
    _assertOnlyBorrowable(spoke, hub, AaveV4EthereumAssets.USDG, 'USDG');
    _assertOnlyBorrowable(spoke, hub, AaveV4EthereumAssets.RLUSD, 'RLUSD');
    _assertOnlyBorrowable(spoke, hub, AaveV4EthereumAssets.frxUSD, 'frxUSD');
    _assertOnlyBorrowable(spoke, hub, AaveV3EthereumAssets.GHO_UNDERLYING, 'GHO');
  }

  // ---------------------------------------------------------------------------
  // Prime Hub Spokes
  // ---------------------------------------------------------------------------

  function test_bluechipSpokeConfiguration() public view {
    ISpoke spoke = AaveV4EthereumSpokes.BLUECHIP_SPOKE;
    IHub primeHub = AaveV4EthereumHubs.PRIME_HUB;
    IHub coreHub = AaveV4EthereumHubs.CORE_HUB;

    // Bluechip Spoke: 11 total reserves
    // Prime Hub (7): collateral wETH, wstETH, wBTC, cbBTC; borrowable USDT, USDC, GHO
    // Core Hub (4): borrowable coreUSDT, coreUSDC, corefrxUSD, coreEURC
    uint256 totalCount = spoke.getReserveCount();
    assertEq(totalCount, 11, 'Bluechip Spoke: wrong total reserve count');

    (, uint256 onPrimeHub, uint256 primeCollateral, uint256 primeBorrowable) = _countReserves(
      spoke,
      primeHub
    );
    assertEq(onPrimeHub, 7, 'Bluechip Spoke: wrong Prime Hub reserve count');
    assertEq(primeCollateral, 4, 'Bluechip Spoke: wrong Prime Hub collateral count');
    assertEq(primeBorrowable, 3, 'Bluechip Spoke: wrong Prime Hub borrowable count');

    (, uint256 onCoreHub, uint256 coreCollateral, uint256 coreBorrowable) = _countReserves(
      spoke,
      coreHub
    );
    assertEq(onCoreHub, 4, 'Bluechip Spoke: wrong Core Hub reserve count');
    assertEq(coreCollateral, 0, 'Bluechip Spoke: Core Hub should have no collateral');
    assertEq(coreBorrowable, 4, 'Bluechip Spoke: wrong Core Hub borrowable count');

    // Prime Hub: collateral only
    _assertOnlyCollateral(spoke, primeHub, AaveV3EthereumAssets.WETH_UNDERLYING, 'primeWETH');
    _assertOnlyCollateral(spoke, primeHub, AaveV3EthereumAssets.wstETH_UNDERLYING, 'primewstETH');
    _assertOnlyCollateral(spoke, primeHub, AaveV3EthereumAssets.WBTC_UNDERLYING, 'primeWBTC');
    _assertOnlyCollateral(spoke, primeHub, AaveV3EthereumAssets.cbBTC_UNDERLYING, 'primecbBTC');

    // Prime Hub: borrowable only
    _assertOnlyBorrowable(spoke, primeHub, AaveV3EthereumAssets.USDT_UNDERLYING, 'primeUSDT');
    _assertOnlyBorrowable(spoke, primeHub, AaveV3EthereumAssets.USDC_UNDERLYING, 'primeUSDC');
    _assertOnlyBorrowable(spoke, primeHub, AaveV3EthereumAssets.GHO_UNDERLYING, 'primeGHO');

    // Core Hub: borrowable only (cross-hub)
    _assertOnlyBorrowable(spoke, coreHub, AaveV3EthereumAssets.USDT_UNDERLYING, 'coreUSDT');
    _assertOnlyBorrowable(spoke, coreHub, AaveV3EthereumAssets.USDC_UNDERLYING, 'coreUSDC');
    _assertOnlyBorrowable(spoke, coreHub, AaveV4EthereumAssets.frxUSD, 'corefrxUSD');
    _assertOnlyBorrowable(spoke, coreHub, AaveV3EthereumAssets.EURC_UNDERLYING, 'coreEURC');
  }

  // ---------------------------------------------------------------------------
  // Plus Hub Spokes
  // ---------------------------------------------------------------------------

  function test_ethenaEcosystemSpokeConfiguration() public view {
    ISpoke spoke = AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE;
    IHub plusHub = AaveV4EthereumHubs.PLUS_HUB;
    IHub coreHub = AaveV4EthereumHubs.CORE_HUB;

    // Ethena Ecosystem Spoke: 10 total reserves
    // Plus Hub (7): collateral PT-sUSDe, PT-USDe, sUSDe, USDe; borrowable USDT, USDC, USDe, GHO
    // Core Hub (3): borrowable coreUSDT, coreUSDC, corefrxUSD
    uint256 totalCount = spoke.getReserveCount();
    assertEq(totalCount, 10, 'Ethena Ecosystem: wrong total reserve count');

    (, uint256 onPlusHub, uint256 plusCollateral, uint256 plusBorrowable) = _countReserves(
      spoke,
      plusHub
    );
    assertEq(onPlusHub, 7, 'Ethena Ecosystem: wrong Plus Hub reserve count');
    assertEq(plusCollateral, 4, 'Ethena Ecosystem: wrong Plus Hub collateral count');
    assertEq(plusBorrowable, 4, 'Ethena Ecosystem: wrong Plus Hub borrowable count');

    (, uint256 onCoreHub, uint256 coreCollateral, uint256 coreBorrowable) = _countReserves(
      spoke,
      coreHub
    );
    assertEq(onCoreHub, 3, 'Ethena Ecosystem: wrong Core Hub reserve count');
    assertEq(coreCollateral, 0, 'Ethena Ecosystem: Core Hub should have no collateral');
    assertEq(coreBorrowable, 3, 'Ethena Ecosystem: wrong Core Hub borrowable count');

    // Plus Hub: collateral + borrowable
    _assertCollateralAndBorrowable(
      spoke,
      plusHub,
      AaveV3EthereumAssets.USDe_UNDERLYING,
      'plusUSDe'
    );

    // Plus Hub: collateral only
    _assertOnlyCollateral(spoke, plusHub, AaveV4EthereumAssets.PT_sUSDE_7MAY2026, 'plusPT_sUSDE');
    _assertOnlyCollateral(spoke, plusHub, AaveV4EthereumAssets.PT_USDe_7MAY2026, 'plusPT_USDe');
    _assertOnlyCollateral(spoke, plusHub, AaveV3EthereumAssets.sUSDe_UNDERLYING, 'plussUSDe');

    // Plus Hub: borrowable only
    _assertOnlyBorrowable(spoke, plusHub, AaveV3EthereumAssets.USDT_UNDERLYING, 'plusUSDT');
    _assertOnlyBorrowable(spoke, plusHub, AaveV3EthereumAssets.USDC_UNDERLYING, 'plusUSDC');
    _assertOnlyBorrowable(spoke, plusHub, AaveV3EthereumAssets.GHO_UNDERLYING, 'plusGHO');

    // Core Hub: borrowable only (cross-hub)
    _assertOnlyBorrowable(spoke, coreHub, AaveV3EthereumAssets.USDT_UNDERLYING, 'coreUSDT');
    _assertOnlyBorrowable(spoke, coreHub, AaveV3EthereumAssets.USDC_UNDERLYING, 'coreUSDC');
    _assertOnlyBorrowable(spoke, coreHub, AaveV4EthereumAssets.frxUSD, 'corefrxUSD');
  }

  function test_ethenaCorrelatedSpokeConfiguration() public view {
    ISpoke spoke = AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE;
    IHub plusHub = AaveV4EthereumHubs.PLUS_HUB;

    // Ethena Correlated Spoke: 4 reserves on Plus Hub
    // Collateral (4): PT-sUSDe, PT-USDe, sUSDe, USDe
    // Borrowable (1): USDe
    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(
      spoke,
      plusHub
    );
    assertEq(total, 4, 'Ethena Correlated: wrong total reserve count');
    assertEq(onHub, 4, 'Ethena Correlated: all reserves should be on Plus Hub');
    assertEq(collateral, 4, 'Ethena Correlated: wrong collateral count');
    assertEq(borrowable, 1, 'Ethena Correlated: wrong borrowable count');

    // Collateral + borrowable
    _assertCollateralAndBorrowable(spoke, plusHub, AaveV3EthereumAssets.USDe_UNDERLYING, 'USDe');

    // Collateral only
    _assertOnlyCollateral(spoke, plusHub, AaveV4EthereumAssets.PT_sUSDE_7MAY2026, 'PT_sUSDE');
    _assertOnlyCollateral(spoke, plusHub, AaveV4EthereumAssets.PT_USDe_7MAY2026, 'PT_USDe');
    _assertOnlyCollateral(spoke, plusHub, AaveV3EthereumAssets.sUSDe_UNDERLYING, 'sUSDe');
  }

  // ---------------------------------------------------------------------------
  // Treasury Spoke
  // ---------------------------------------------------------------------------

  function test_treasurySpokeListedOnAllHubsForAllAssets() public view {
    IHub[] memory hubs = AaveV4EthereumHubs.getHubs();
    ISpoke treasurySpoke = AaveV4EthereumSpokes.TREASURY_SPOKE;

    for (uint256 hubIdx; hubIdx < hubs.length; ++hubIdx) {
      uint256 assetCount = hubs[hubIdx].getAssetCount();
      for (uint256 assetId; assetId < assetCount; ++assetId) {
        assertTrue(
          hubs[hubIdx].isSpokeListed(assetId, address(treasurySpoke)),
          'Treasury spoke should be listed on every asset'
        );
        IHub.SpokeConfig memory config = hubs[hubIdx].getSpokeConfig(
          assetId,
          address(treasurySpoke)
        );
        assertTrue(config.active, 'Treasury spoke should be active on every asset');
      }
    }
  }

  function test_treasurySpokeHasCorrectCaps() public view {
    IHub[] memory hubs = AaveV4EthereumHubs.getHubs();
    ISpoke treasurySpoke = AaveV4EthereumSpokes.TREASURY_SPOKE;

    for (uint256 hubIdx; hubIdx < hubs.length; ++hubIdx) {
      uint256 assetCount = hubs[hubIdx].getAssetCount();
      for (uint256 assetId; assetId < assetCount; ++assetId) {
        IHub.SpokeConfig memory config = hubs[hubIdx].getSpokeConfig(
          assetId,
          address(treasurySpoke)
        );
        assertEq(config.addCap, type(uint40).max, 'Treasury spoke addCap should be unlimited');
        assertEq(config.drawCap, 0, 'Treasury spoke drawCap should be zero');
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Tokenization Spokes
  // ---------------------------------------------------------------------------

  function test_coreHubTokenizationSpokesListedAndActive() public view {
    IHub hub = AaveV4EthereumHubs.CORE_HUB;

    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.CORE_WETH,
      'CORE_WETH'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.wstETH_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.CORE_wstETH,
      'CORE_wstETH'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.weETH_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.CORE_weETH,
      'CORE_weETH'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.rsETH_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.CORE_rsETH,
      'CORE_rsETH'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.WBTC_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.CORE_WBTC,
      'CORE_WBTC'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.cbBTC_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.CORE_cbBTC,
      'CORE_cbBTC'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.LBTC_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.CORE_LBTC,
      'CORE_LBTC'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.CORE_USDT,
      'CORE_USDT'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.CORE_USDC,
      'CORE_USDC'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.LINK_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.CORE_LINK,
      'CORE_LINK'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.CORE_AAVE,
      'CORE_AAVE'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.CORE_GHO,
      'CORE_GHO'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.EURC_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.CORE_EURC,
      'CORE_EURC'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV4EthereumAssets.RLUSD,
      AaveV4EthereumTokenizationSpokes.CORE_RLUSD,
      'CORE_RLUSD'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV4EthereumAssets.USDG,
      AaveV4EthereumTokenizationSpokes.CORE_USDG,
      'CORE_USDG'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV4EthereumAssets.frxUSD,
      AaveV4EthereumTokenizationSpokes.CORE_frxUSD,
      'CORE_frxUSD'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV4EthereumAssets.XAUt,
      AaveV4EthereumTokenizationSpokes.CORE_XAUt,
      'CORE_XAUt'
    );
  }

  function test_plusHubTokenizationSpokesListedAndActive() public view {
    IHub hub = AaveV4EthereumHubs.PLUS_HUB;

    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.PLUS_USDT,
      'PLUS_USDT'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.PLUS_USDC,
      'PLUS_USDC'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.PLUS_GHO,
      'PLUS_GHO'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.USDe_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.PLUS_USDe,
      'PLUS_USDe'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.sUSDe_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.PLUS_sUSDe,
      'PLUS_sUSDe'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV4EthereumAssets.PT_sUSDE_7MAY2026,
      AaveV4EthereumTokenizationSpokes.PLUS_PT_sUSDE_7MAY2026,
      'PLUS_PT_sUSDE'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV4EthereumAssets.PT_USDe_7MAY2026,
      AaveV4EthereumTokenizationSpokes.PLUS_PT_USDe_7MAY2026,
      'PLUS_PT_USDe'
    );
  }

  function test_primeHubTokenizationSpokesListedAndActive() public view {
    IHub hub = AaveV4EthereumHubs.PRIME_HUB;

    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.PRIME_WETH,
      'PRIME_WETH'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.wstETH_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.PRIME_wstETH,
      'PRIME_wstETH'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.WBTC_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.PRIME_WBTC,
      'PRIME_WBTC'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.cbBTC_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.PRIME_cbBTC,
      'PRIME_cbBTC'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.PRIME_USDT,
      'PRIME_USDT'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.PRIME_USDC,
      'PRIME_USDC'
    );
    _assertTokenizationSpokeActive(
      hub,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV4EthereumTokenizationSpokes.PRIME_GHO,
      'PRIME_GHO'
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  function _assertTokenizationSpokeActive(
    IHub hub,
    address underlying,
    address tokenizationSpoke,
    string memory name
  ) internal view {
    uint256 assetId = hub.getAssetId(underlying);
    assertTrue(
      hub.isSpokeListed(assetId, tokenizationSpoke),
      string.concat(name, ' should be listed')
    );
    IHub.SpokeConfig memory config = hub.getSpokeConfig(assetId, tokenizationSpoke);
    assertTrue(config.active, string.concat(name, ' should be active'));
  }

  function _assertCollateralAndBorrowable(
    ISpoke spoke,
    IHub hub,
    address underlying,
    string memory name
  ) internal view {
    (bool isCollateral, bool isBorrowable) = _getReserveFlags(spoke, hub, underlying);
    assertTrue(isCollateral, string.concat(name, ' should be collateral'));
    assertTrue(isBorrowable, string.concat(name, ' should be borrowable'));
  }

  function _assertOnlyCollateral(
    ISpoke spoke,
    IHub hub,
    address underlying,
    string memory name
  ) internal view {
    (bool isCollateral, bool isBorrowable) = _getReserveFlags(spoke, hub, underlying);
    assertTrue(isCollateral, string.concat(name, ' should be collateral'));
    assertFalse(isBorrowable, string.concat(name, ' should not be borrowable'));
  }

  function _assertOnlyBorrowable(
    ISpoke spoke,
    IHub hub,
    address underlying,
    string memory name
  ) internal view {
    (bool isCollateral, bool isBorrowable) = _getReserveFlags(spoke, hub, underlying);
    assertFalse(isCollateral, string.concat(name, ' should not be collateral'));
    assertTrue(isBorrowable, string.concat(name, ' should be borrowable'));
  }

  function _countReserves(
    ISpoke spoke,
    IHub hub
  ) internal view returns (uint256, uint256, uint256, uint256) {
    uint256 total = spoke.getReserveCount();
    uint256 onHub;
    uint256 collateralCount;
    uint256 borrowableCount;

    for (uint256 reserveId; reserveId < total; ++reserveId) {
      ISpoke.Reserve memory r = spoke.getReserve(reserveId);
      if (address(r.hub) != address(hub)) continue;
      ++onHub;

      ISpoke.DynamicReserveConfig memory dynCfg = spoke.getDynamicReserveConfig(
        reserveId,
        r.dynamicConfigKey
      );
      if (dynCfg.collateralFactor > 0) ++collateralCount;

      ISpoke.ReserveConfig memory cfg = spoke.getReserveConfig(reserveId);
      if (cfg.borrowable) ++borrowableCount;
    }

    return (total, onHub, collateralCount, borrowableCount);
  }

  function _getReserveFlags(
    ISpoke spoke,
    IHub hub,
    address underlying
  ) internal view returns (bool, bool) {
    uint256 assetId = hub.getAssetId(underlying);
    uint256 reserveId = spoke.getReserveId(address(hub), assetId);
    ISpoke.Reserve memory r = spoke.getReserve(reserveId);

    ISpoke.DynamicReserveConfig memory dynCfg = spoke.getDynamicReserveConfig(
      reserveId,
      r.dynamicConfigKey
    );
    ISpoke.ReserveConfig memory cfg = spoke.getReserveConfig(reserveId);

    return (dynCfg.collateralFactor > 0, cfg.borrowable);
  }
}
