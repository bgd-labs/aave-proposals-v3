// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IHub, IHubConfigurator, IAccessManagerEnumerable} from 'aave-address-book/AaveV4.sol';
import {IExecutor} from 'aave-address-book/governance-v3/IExecutor.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumAssets, AaveV4EthereumGetters} from 'aave-address-book/AaveV4Ethereum.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';

import {AaveV4Ethereum_IncreaseCaps_20260603} from './AaveV4Ethereum_IncreaseCaps_20260603.sol';

import 'aave-helpers/src/ProtocolV4TestBase.sol';

/**
 * @dev Test for AaveV4Ethereum_IncreaseCaps_20260603
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260603_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260603.t.sol -vv
 */
contract AaveV4Ethereum_IncreaseCaps_20260603_Test is ProtocolV4TestBase {
  AaveV4Ethereum_IncreaseCaps_20260603 internal payload;

  IAccessManagerEnumerable internal constant ACCESS_MANAGER = AaveV4Ethereum.ACCESS_MANAGER;

  address internal constant SECURITY_COUNCIL = 0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9;
  address internal constant EXECUTOR = 0x14339e2178A954d5FB839D5Ff31644fE0F25F517;

  IHub internal constant CORE_HUB = AaveV4EthereumHubs.CORE_HUB;
  IHub internal constant PRIME_HUB = AaveV4EthereumHubs.PRIME_HUB;
  IHub internal constant PLUS_HUB = AaveV4EthereumHubs.PLUS_HUB;

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25235935);

    payload = new AaveV4Ethereum_IncreaseCaps_20260603();
  }

  // ================================================================
  // Execution & role revocation
  // ================================================================

  function test_executorHasRoleBeforeExecution() public view virtual {
    (bool hasRole, ) = ACCESS_MANAGER.hasRole(Roles.HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE, EXECUTOR);
    assertTrue(hasRole, 'Executor should have HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE before execution');
  }

  function test_roleActiveAfterExecution() public virtual {
    _executePayload();

    (bool hasRole, ) = ACCESS_MANAGER.hasRole(Roles.HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE, EXECUTOR);
    assertTrue(hasRole, 'Executor should have HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE after execution');
  }

  function test_executeWithRecording() public virtual {
    string memory reportName = 'AaveV4Ethereum_IncreaseCaps_20260603';

    IHub[] memory hubs = AaveV4EthereumGetters.getAllHubs();
    ISpoke[] memory spokes = AaveV4EthereumGetters.getAllSpokes();

    string memory beforeName = string.concat(reportName, '_before');
    string memory afterName = string.concat(reportName, '_after');

    Types.V4Snapshot memory snapshotBefore = createV4Snapshot(
      spokes,
      hubs,
      _positionManagerCandidates(),
      _accessManagers()
    );
    writeV4SnapshotJson(beforeName, snapshotBefore);

    (string memory rawDiff, string memory logsJson) = _executePayloadWithRecording();

    Types.V4Snapshot memory snapshotAfter = createV4Snapshot(
      spokes,
      hubs,
      _positionManagerCandidates(),
      _accessManagers()
    );
    writeV4SnapshotJson(afterName, snapshotAfter);

    string memory afterPath = string.concat('./reports/', afterName, '.json');
    vm.writeJson(rawDiff, afterPath, '$.raw');
    vm.writeJson(logsJson, afterPath, '$.logs');

    // WORKAROUND: @aave-dao/aave-helpers-js@^1.0.1 does not have
    // `diff-v4-snapshots` published yet
    {
      string memory diffOutPath = string.concat(
        './diffs/',
        reportName,
        '_before_',
        reportName,
        '_after.md'
      );
      string[] memory inputs = new string[](7);
      inputs[0] = 'node';
      inputs[1] = 'lib/aave-helpers/packages/aave-helpers-js/dist/cli.mjs';
      inputs[2] = 'diff-v4-snapshots';
      inputs[3] = string.concat('./reports/', beforeName, '.json');
      inputs[4] = string.concat('./reports/', afterName, '.json');
      inputs[5] = '-o';
      inputs[6] = diffOutPath;
      vm.ffi(inputs);
    }
  }

  // ================================================================
  // E2E tests (supply, borrow, repay, liquidation, tokenization, gateways)
  // ================================================================

  function test_e2e() public virtual {
    _executePayload();

    vm.pauseGasMetering();
    e2eTestAllSpokes({spokes: _getE2eSpokes(), testPositionManagers: true});
    e2eTestAllTokenizationSpokes(AaveV4EthereumGetters.getAllTokenizationSpokes());
    vm.resumeGasMetering();
  }

  /// @dev Kelp Spoke is excluded from e2e: its reserves currently have
  ///      `collateralFactor = 0`, leaving no usable collateral for the
  ///      supply/borrow/liquidation flows. This payload does not touch it.
  function _getE2eSpokes() internal pure returns (ISpoke[] memory) {
    ISpoke[] memory all = AaveV4EthereumGetters.getAllSpokes();
    ISpoke[] memory filtered = new ISpoke[](all.length - 1);
    uint256 j;
    for (uint256 i; i < all.length; i++) {
      if (address(all[i]) == address(AaveV4EthereumSpokes.KELP_ESPOKE)) continue;
      filtered[j++] = all[i];
    }
    return filtered;
  }

  // ================================================================
  // Cap updates — Core Hub
  //
  // | Spoke   | Asset  | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |---------|--------|-------------|--------------|--------------|---------------|
  // | Etherfi | weETH  |       8,500 |       11,000 |            0 |             - |
  // | Forex   | EURC   |   1,125,000 |    4,300,000 |    1,170,000 |     4,500,000 |
  // | Forex   | USDC   |   1,500,000 |   10,000,000 |      500,000 |     3,330,000 |
  // | Forex   | USDT   |   1,500,000 |   10,000,000 |      500,000 |     3,330,000 |
  // | Gold    | EURC   |           0 |            - |       50,000 |       100,000 |
  // | Gold    | GHO    |           0 |            - |       62,500 |       125,000 |
  // | Gold    | RLUSD  |           0 |            - |       62,500 |       125,000 |
  // | Gold    | USDC   |           0 |            - |      250,000 |       500,000 |
  // | Gold    | USDG   |           0 |            - |      250,000 |       500,000 |
  // | Gold    | USDT   |           0 |            - |      400,000 |       800,000 |
  // | Gold    | XAUt   |         500 |        1,000 |            0 |             - |
  // | Gold    | frxUSD |           0 |            - |      250,000 |       500,000 |
  // | Lido    | wstETH |       4,800 |        5,900 |            0 |             - |
  // | Lombard | LBTC   |           9 |           45 |            0 |             - |
  // | Main    | AAVE   |      12,000 |       67,000 |            0 |             - |
  // | Main    | EURC   |     225,000 |    4,300,000 |      150,000 |     2,900,000 |
  // | Main    | GHO    |   1,500,000 |   10,000,000 |    1,500,000 |    10,000,000 |
  // | Main    | LINK   |     430,000 |      610,000 |            0 |             - |
  // | Main    | RLUSD  |     500,000 |    5,000,000 |      340,000 |     3,400,000 |
  // | Main    | USDC   |   6,000,000 |   10,000,000 |    6,000,000 |    10,000,000 |
  // | Main    | USDG   |  20,000,000 |   30,000,000 |   13,600,000 |    20,400,000 |
  // | Main    | USDT   |   8,500,000 |   12,500,000 |    8,500,000 |    12,500,000 |
  // | Main    | WBTC   |         170 |          240 |           15 |            21 |
  // | Main    | WETH   |      18,500 |       24,000 |        1,600 |         2,050 |
  // | Main    | cbBTC  |          85 |          115 |            5 |             7 |
  // | Main    | frxUSD |  20,000,000 |   30,000,000 |   13,600,000 |    20,400,000 |
  // | Main    | weETH  |       1,000 |        1,500 |            0 |             - |
  // | Main    | wstETH |       2,800 |        4,400 |            0 |             - |
  // ================================================================

  // prettier-ignore
  function test_caps_coreHub_before() public virtual {
    //                                                                                                              addCap      drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHERFI_ESPOKE),   AaveV4EthereumAssets.weETH_UNDERLYING,  8_500,      0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE),       AaveV4EthereumAssets.EURC_UNDERLYING,   1_125_000,  1_170_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE),       AaveV4EthereumAssets.USDC_UNDERLYING,   1_500_000,  500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE),       AaveV4EthereumAssets.USDT_UNDERLYING,   1_500_000,  500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),        AaveV4EthereumAssets.EURC_UNDERLYING,   0,          50_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),        AaveV4EthereumAssets.GHO_UNDERLYING,    0,          62_500);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),        AaveV4EthereumAssets.RLUSD_UNDERLYING,  0,          62_500);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),        AaveV4EthereumAssets.USDC_UNDERLYING,   0,          250_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),        AaveV4EthereumAssets.USDG_UNDERLYING,   0,          250_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),        AaveV4EthereumAssets.USDT_UNDERLYING,   0,          400_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),        AaveV4EthereumAssets.XAUt_UNDERLYING,   500,        0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),        AaveV4EthereumAssets.frxUSD_UNDERLYING, 0,          250_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.LIDO_ESPOKE),      AaveV4EthereumAssets.wstETH_UNDERLYING, 4_800,      0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.LOMBARD_BTC_SPOKE), AaveV4EthereumAssets.LBTC_UNDERLYING,   9,          0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.AAVE_UNDERLYING,   12_000,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.EURC_UNDERLYING,   225_000,    150_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.GHO_UNDERLYING,    1_500_000,  1_500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.LINK_UNDERLYING,   430_000,    0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.RLUSD_UNDERLYING,  500_000,    340_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.USDC_UNDERLYING,   6_000_000,  6_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.USDG_UNDERLYING,   20_000_000, 13_600_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.USDT_UNDERLYING,   8_500_000,  8_500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.WBTC_UNDERLYING,   170,        15);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.WETH_UNDERLYING,   18_500,     1_600);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.cbBTC_UNDERLYING,  85,         5);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.frxUSD_UNDERLYING, 20_000_000, 13_600_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.weETH_UNDERLYING,  1_000,      0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.wstETH_UNDERLYING, 2_800,      0);
  }

  // prettier-ignore
  function test_caps_coreHub() public virtual {
    _executePayload();

    //                                                                                                              addCap      drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHERFI_ESPOKE),   AaveV4EthereumAssets.weETH_UNDERLYING,  11_000,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE),       AaveV4EthereumAssets.EURC_UNDERLYING,   4_300_000,  4_500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE),       AaveV4EthereumAssets.USDC_UNDERLYING,   10_000_000, 3_330_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE),       AaveV4EthereumAssets.USDT_UNDERLYING,   10_000_000, 3_330_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),        AaveV4EthereumAssets.EURC_UNDERLYING,   0,          100_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),        AaveV4EthereumAssets.GHO_UNDERLYING,    0,          125_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),        AaveV4EthereumAssets.RLUSD_UNDERLYING,  0,          125_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),        AaveV4EthereumAssets.USDC_UNDERLYING,   0,          500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),        AaveV4EthereumAssets.USDG_UNDERLYING,   0,          500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),        AaveV4EthereumAssets.USDT_UNDERLYING,   0,          800_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),        AaveV4EthereumAssets.XAUt_UNDERLYING,   1_000,      0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),        AaveV4EthereumAssets.frxUSD_UNDERLYING, 0,          500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.LIDO_ESPOKE),      AaveV4EthereumAssets.wstETH_UNDERLYING, 5_900,      0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.LOMBARD_BTC_SPOKE), AaveV4EthereumAssets.LBTC_UNDERLYING,   45,         0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.AAVE_UNDERLYING,   67_000,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.EURC_UNDERLYING,   4_300_000,  2_900_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.GHO_UNDERLYING,    10_000_000, 10_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.LINK_UNDERLYING,   610_000,    0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.RLUSD_UNDERLYING,  5_000_000,  3_400_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.USDC_UNDERLYING,   10_000_000, 10_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.USDG_UNDERLYING,   30_000_000, 20_400_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.USDT_UNDERLYING,   12_500_000, 12_500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.WBTC_UNDERLYING,   240,        21);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.WETH_UNDERLYING,   24_000,     2_050);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.cbBTC_UNDERLYING,  115,        7);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.frxUSD_UNDERLYING, 30_000_000, 20_400_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.weETH_UNDERLYING,  1_500,      0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),        AaveV4EthereumAssets.wstETH_UNDERLYING, 4_400,      0);
  }

  // ================================================================
  // Cap updates — Prime Hub
  //
  // | Spoke    | Asset  | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |----------|--------|-------------|--------------|--------------|---------------|
  // | Bluechip | GHO    |   3,000,000 |    7,500,000 |    3,375,000 |     8,440,000 |
  // | Bluechip | USDC   |   3,000,000 |   12,500,000 |    3,500,000 |    14,590,000 |
  // | Bluechip | USDT   |   3,000,000 |   12,500,000 |    3,750,000 |    15,625,000 |
  // | Bluechip | WBTC   |         120 |          185 |            0 |             - |
  // | Bluechip | WETH   |       2,200 |        3,200 |            0 |             - |
  // | Bluechip | cbBTC  |          60 |           90 |            0 |             - |
  // | Bluechip | wstETH |       2,400 |        4,100 |            0 |             - |
  // ================================================================

  // prettier-ignore
  function test_caps_primeHub_before() public virtual {
    //                                                                                                               addCap     drawCap
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.GHO_UNDERLYING,        3_000_000, 3_375_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,       3_000_000, 3_500_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,       3_000_000, 3_750_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WBTC_UNDERLYING,       120,       0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,       2_200,     0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.cbBTC_UNDERLYING,      60,        0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.wstETH_UNDERLYING,     2_400,     0);
  }

  // prettier-ignore
  function test_caps_primeHub() public virtual {
    _executePayload();

    //                                                                                                               addCap      drawCap
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.GHO_UNDERLYING,        7_500_000,  8_440_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,       12_500_000, 14_590_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,       12_500_000, 15_625_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WBTC_UNDERLYING,       185,        0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,       3_200,      0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.cbBTC_UNDERLYING,      90,         0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.wstETH_UNDERLYING,     4_100,      0);
  }

  // ================================================================
  // Cap updates — Plus Hub
  //
  // | Spoke             | Asset             | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |-------------------|-------------------|-------------|--------------|--------------|---------------|
  // | Ethena Correlated | PT-USDe-7MAY2026  |      50,000 |            0 |            0 |             - |
  // | Ethena Correlated | PT-sUSDE-7MAY2026 |     400,000 |            0 |            0 |             - |
  // | Ethena Correlated | USDe              |     312,500 |    5,000,000 |      325,000 |     5,200,000 |
  // | Ethena Correlated | sUSDe             |     250,000 |    4,060,000 |            0 |             - |
  // | Ethena Ecosystem  | GHO               |   1,000,000 |    3,000,000 |    1,150,000 |     3,450,000 |
  // | Ethena Ecosystem  | PT-USDe-7MAY2026  |     250,000 |            0 |            0 |             - |
  // | Ethena Ecosystem  | PT-sUSDE-7MAY2026 |   2,000,000 |            0 |            0 |             - |
  // | Ethena Ecosystem  | USDC              |     500,000 |    3,000,000 |      625,000 |     3,750,000 |
  // | Ethena Ecosystem  | USDT              |     500,000 |    3,000,000 |      625,000 |     3,750,000 |
  // | Ethena Ecosystem  | USDe              |   1,000,000 |    5,000,000 |      960,000 |     4,800,000 |
  // | Ethena Ecosystem  | sUSDe             |   1,000,000 |    4,060,000 |            0 |             - |
  // ================================================================

  // prettier-ignore
  function test_caps_plusHub_before() public virtual {
    //                                                                                                                          addCap     drawCap
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE), AaveV4EthereumAssets.PT_USDe_7MAY2026_UNDERLYING,  50_000,    0);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE), AaveV4EthereumAssets.PT_sUSDE_7MAY2026_UNDERLYING, 400_000,   0);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE), AaveV4EthereumAssets.USDe_UNDERLYING,              312_500,   325_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE), AaveV4EthereumAssets.sUSDe_UNDERLYING,             250_000,   0);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.GHO_UNDERLYING,               1_000_000, 1_150_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.PT_USDe_7MAY2026_UNDERLYING,  250_000,   0);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.PT_sUSDE_7MAY2026_UNDERLYING, 2_000_000, 0);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.USDC_UNDERLYING,              500_000,   625_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.USDT_UNDERLYING,              500_000,   625_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.USDe_UNDERLYING,              1_000_000, 960_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.sUSDe_UNDERLYING,             1_000_000, 0);
  }

  // prettier-ignore
  function test_caps_plusHub() public virtual {
    _executePayload();

    //                                                                                                                          addCap     drawCap
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE), AaveV4EthereumAssets.PT_USDe_7MAY2026_UNDERLYING,  0,         0);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE), AaveV4EthereumAssets.PT_sUSDE_7MAY2026_UNDERLYING, 0,         0);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE), AaveV4EthereumAssets.USDe_UNDERLYING,              5_000_000, 5_200_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE), AaveV4EthereumAssets.sUSDe_UNDERLYING,             4_060_000, 0);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.GHO_UNDERLYING,               3_000_000, 3_450_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.PT_USDe_7MAY2026_UNDERLYING,  0,         0);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.PT_sUSDE_7MAY2026_UNDERLYING, 0,         0);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.USDC_UNDERLYING,              3_000_000, 3_750_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.USDT_UNDERLYING,              3_000_000, 3_750_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.USDe_UNDERLYING,              5_000_000, 4_800_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.sUSDe_UNDERLYING,             4_060_000, 0);
  }

  // ================================================================
  // Credit Lines
  //
  // | Origin   | Target Spoke | Asset  | Current Credit Line | Proposed Credit Line |
  // |----------|--------------|--------|---------------------|----------------------|
  // | Core Hub | Bluechip     | frxUSD |           1,000,000 |            3,000,000 |
  // | Core Hub | Bluechip     | USDC   |             375,000 |            2,000,000 |
  // | Core Hub | Bluechip     | USDT   |           1,250,000 |            2,500,000 |
  // | Core Hub | Bluechip     | EURC   |             150,000 |              300,000 |
  // ================================================================

  // prettier-ignore
  function test_creditLines_before() public virtual {
    //                                                                                                              addCap  drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.frxUSD_UNDERLYING,     0,      1_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,       0,      375_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,       0,      1_250_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.EURC_UNDERLYING,       0,      150_000);
  }

  // prettier-ignore
  function test_creditLines() public virtual {
    _executePayload();

    //                                                                                                              addCap  drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.frxUSD_UNDERLYING,     0,      3_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,       0,      2_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,       0,      2_500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.EURC_UNDERLYING,       0,      300_000);
  }

  // ================================================================
  // Helpers
  // ================================================================

  /// @dev Executes the payload via the executor using delegatecall.
  function _executePayload() internal virtual {
    vm.prank(SECURITY_COUNCIL);
    IExecutor(EXECUTOR).executeTransaction(
      address(payload),
      0,
      'execute()',
      bytes(''),
      true // withDelegatecall
    );
  }

  function _assertCaps(
    IHub hub,
    address spoke,
    address underlying,
    uint256 expectedAddCap,
    uint256 expectedDrawCap
  ) internal view {
    uint256 assetId = hub.getAssetId(underlying);
    IHub.SpokeConfig memory config = hub.getSpokeConfig(assetId, spoke);
    assertEq(config.addCap, expectedAddCap, 'addCap mismatch');
    assertEq(config.drawCap, expectedDrawCap, 'drawCap mismatch');
  }

  function _executePayloadWithRecording()
    internal
    returns (string memory rawDiff, string memory logsJson)
  {
    uint256 startGas = gasleft();
    vm.startStateDiffRecording();
    vm.recordLogs();

    _executePayload();

    uint256 gasUsed = startGas - gasleft();
    assertLt(gasUsed, (block.gaslimit * 95) / 100, 'BLOCK_GAS_LIMIT_EXCEEDED');

    rawDiff = vm.getStateDiffJson();
    logsJson = vm.getRecordedLogsJson();
  }
}
