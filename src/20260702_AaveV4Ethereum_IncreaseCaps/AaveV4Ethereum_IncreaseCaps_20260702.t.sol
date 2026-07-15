// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IHub, IHubConfigurator, IAccessManagerEnumerable} from 'aave-address-book/AaveV4.sol';
import {IExecutor} from 'aave-address-book/governance-v3/IExecutor.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumAssets, AaveV4EthereumGetters} from 'aave-address-book/AaveV4Ethereum.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';

import {AaveV4Ethereum_IncreaseCaps_20260702} from './AaveV4Ethereum_IncreaseCaps_20260702.sol';

import 'aave-helpers/src/ProtocolV4TestBase.sol';

/**
 * @dev Test for AaveV4Ethereum_IncreaseCaps_20260702
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260702_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260702.t.sol -vv
 */
contract AaveV4Ethereum_IncreaseCaps_20260702_Test is ProtocolV4TestBase {
  AaveV4Ethereum_IncreaseCaps_20260702 internal payload;

  IAccessManagerEnumerable internal constant ACCESS_MANAGER = AaveV4Ethereum.ACCESS_MANAGER;

  address internal constant SECURITY_COUNCIL = 0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9;
  address internal constant EXECUTOR = 0x14339e2178A954d5FB839D5Ff31644fE0F25F517;

  IHub internal constant CORE_HUB = AaveV4EthereumHubs.CORE_HUB;
  IHub internal constant PLUS_HUB = AaveV4EthereumHubs.PLUS_HUB;
  IHub internal constant PRIME_HUB = AaveV4EthereumHubs.PRIME_HUB;
  IHub internal constant PAXOS_HUB = AaveV4EthereumHubs.PAXOS_HUB;

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25445684);

    payload = new AaveV4Ethereum_IncreaseCaps_20260702();
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
    string memory reportName = 'AaveV4Ethereum_IncreaseCaps_20260702';

    IHub[] memory hubs = AaveV4EthereumGetters.getAllHubs();
    ISpoke[] memory spokes = AaveV4EthereumGetters.getAllSpokes();
    address[] memory positionManagerCandidates = _positionManagerCandidates();
    address[] memory accessManagers = _accessManagers();

    string memory beforeName = string.concat(reportName, '_before');
    string memory afterName = string.concat(reportName, '_after');

    Types.V4Snapshot memory snapshotBefore = createV4Snapshot(
      spokes,
      hubs,
      positionManagerCandidates,
      accessManagers
    );
    writeV4SnapshotJson(beforeName, snapshotBefore);

    (string memory rawDiff, string memory logsJson) = _executePayloadWithRecording();

    Types.V4Snapshot memory snapshotAfter = createV4Snapshot(
      spokes,
      hubs,
      positionManagerCandidates,
      accessManagers
    );
    writeV4SnapshotJson(afterName, snapshotAfter);

    string memory afterPath = string.concat('./reports/', afterName, '.json');
    vm.writeJson(rawDiff, afterPath, '$.raw');
    vm.writeJson(logsJson, afterPath, '$.logs');

    diffV4Snapshots(reportName);
  }

  // ================================================================
  // E2E tests (supply, borrow, repay, liquidation, tokenization, gateways)
  // ================================================================

  function test_e2e() public virtual {
    _executePayload();

    vm.pauseGasMetering();
    e2eTestAllSpokes({spokes: AaveV4EthereumGetters.getAllSpokes(), testPositionManagers: true});
    e2eTestAllTokenizationSpokes(AaveV4EthereumGetters.getAllTokenizationSpokes());
    vm.resumeGasMetering();
  }

  // ================================================================
  // Cap updates — Core Hub
  //
  // | Spoke   | Asset  | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |---------|--------|-------------|--------------|--------------|---------------|
  // | Etherfi | weETH  |      14,000 |       18,000 |            0 |             - |
  // | Forex   | frxUSD |           0 |            - |      500,000 |     1,000,000 |
  // | Gold    | XAUt   |       1,800 |        2,500 |            0 |             - |
  // | Main    | LINK   |     610,000 |      750,000 |            0 |             - |
  // | Main    | USDG   |  40,000,000 |   50,000,000 |   27,200,000 |             - |
  // | Main    | WBTC   |         850 |        1,150 |           74 |           100 |
  // | Main    | cbBTC  |         160 |          220 |           10 |            14 |
  // | Main    | frxUSD |  40,000,000 |   50,000,000 |   27,200,000 |    34,000,000 |
  // | Main    | weETH  |       2,200 |        4,000 |            0 |             - |
  // | Main    | wstETH |       8,000 |       10,000 |            0 |             - |
  //
  // Plus Hub
  //
  // | Spoke             | Asset  | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |-------------------|--------|-------------|--------------|--------------|---------------|
  // | Ethena Ecosystem  | USDC   |   3,000,000 |    6,000,000 |    3,750,000 |     6,375,000 |
  // | Ethena Ecosystem  | USDT   |   3,000,000 |    6,000,000 |    3,750,000 |     6,375,000 |
  // | Ethena Ecosystem  | sUSDe  |   4,060,000 |    6,000,000 |            0 |             - |
  // | Ethena Correlated | USDe   |   5,000,000 |    5,200,000 |    5,200,000 |             - |
  // | Ethena Ecosystem  | GHO    |   3,000,000 |    3,450,000 |    3,450,000 |             - |
  //
  // Prime Hub
  //
  // | Spoke    | Asset  | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |----------|--------|-------------|--------------|--------------|---------------|
  // | Bluechip | wstETH |       5,500 |        7,000 |            0 |             - |
  // | Bluechip | USDC   |  12,500,000 |   12,590,000 |   14,590,000 |             - |
  // | Bluechip | USDT   |  12,500,000 |   13,125,000 |   15,625,000 |             - |
  // | Bluechip | GHO    |   7,500,000 |    8,440,000 |    8,440,000 |             - |
  //
  // Global Dollar Hub
  //
  // | Spoke       | Asset             | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |-------------|-------------------|-------------|--------------|--------------|---------------|
  // | USDG Pendle | PT-USDG-24SEP2026 |  15,000,000 |   30,000,000 |            0 |             - |
  //
  // Credit Lines (cross-hub draws from Core)
  //
  // | Spoke            | Asset  | Current Draw | Proposed Draw |
  // |------------------|--------|--------------|---------------|
  // | Bluechip         | frxUSD |    4,000,000 |     5,000,000 |
  // | Ethena Ecosystem | frxUSD |      300,000 |       500,000 |
  // | USDG Pendle      | USDG   |   30,000,000 |    15,000,000 |
  // ================================================================

  // prettier-ignore
  function test_caps_coreHub_before() public virtual {
    //                                                                                                          addCap      drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHERFI_ESPOKE), AaveV4EthereumAssets.weETH_UNDERLYING,  14_000,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE),    AaveV4EthereumAssets.frxUSD_UNDERLYING, 0,          500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),     AaveV4EthereumAssets.XAUt_UNDERLYING,   1_800,      0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.LINK_UNDERLYING,   610_000,    0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.USDG_UNDERLYING,   40_000_000, 27_200_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.WBTC_UNDERLYING,   850,        74);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.cbBTC_UNDERLYING,  160,        10);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.frxUSD_UNDERLYING, 40_000_000, 27_200_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.weETH_UNDERLYING,  2_200,      0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.wstETH_UNDERLYING, 8_000,      0);
  }

  // prettier-ignore
  function test_caps_coreHub() public virtual {
    _executePayload();

    //                                                                                                          addCap      drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHERFI_ESPOKE), AaveV4EthereumAssets.weETH_UNDERLYING,  18_000,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE),    AaveV4EthereumAssets.frxUSD_UNDERLYING, 0,          1_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),     AaveV4EthereumAssets.XAUt_UNDERLYING,   2_500,      0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.LINK_UNDERLYING,   750_000,    0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.USDG_UNDERLYING,   50_000_000, 27_200_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.WBTC_UNDERLYING,   1_150,      100);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.cbBTC_UNDERLYING,  220,        14);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.frxUSD_UNDERLYING, 50_000_000, 34_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.weETH_UNDERLYING,  4_000,      0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.wstETH_UNDERLYING, 10_000,     0);
  }

  // prettier-ignore
  function test_caps_plusHub_before() public virtual {
    //                                                                                                                    addCap     drawCap
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.USDC_UNDERLYING,  3_000_000, 3_750_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.USDT_UNDERLYING,  3_000_000, 3_750_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.sUSDe_UNDERLYING, 4_060_000, 0);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE), AaveV4EthereumAssets.USDe_UNDERLYING,  5_000_000, 5_200_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.GHO_UNDERLYING,   3_000_000, 3_450_000);
  }

  // prettier-ignore
  function test_caps_plusHub() public virtual {
    _executePayload();

    //                                                                                                                    addCap     drawCap
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.USDC_UNDERLYING,  6_000_000, 6_375_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.USDT_UNDERLYING,  6_000_000, 6_375_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.sUSDe_UNDERLYING, 6_000_000, 0);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE), AaveV4EthereumAssets.USDe_UNDERLYING,  5_200_000, 5_200_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE),  AaveV4EthereumAssets.GHO_UNDERLYING,   3_450_000, 3_450_000);
  }

  // prettier-ignore
  function test_caps_primeHub_before() public virtual {
    //                                                                                                          addCap      drawCap
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.wstETH_UNDERLYING, 5_500,      0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,   12_500_000, 14_590_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,   12_500_000, 15_625_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.GHO_UNDERLYING,    7_500_000,  8_440_000);
  }

  // prettier-ignore
  function test_caps_primeHub() public virtual {
    _executePayload();

    //                                                                                                          addCap      drawCap
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.wstETH_UNDERLYING, 7_000,      0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,   12_590_000, 14_590_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,   13_125_000, 15_625_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.GHO_UNDERLYING,    8_440_000,  8_440_000);
  }

  // prettier-ignore
  function test_caps_globalDollarHub_before() public virtual {
    //                                                                                                                addCap      drawCap
    _assertCaps(PAXOS_HUB, address(AaveV4EthereumSpokes.USDG_PENDLE_SPOKE), AaveV4EthereumAssets.PT_USDG_24SEP2026_UNDERLYING, 15_000_000, 0);
  }

  // prettier-ignore
  function test_caps_globalDollarHub() public virtual {
    _executePayload();

    //                                                                                                                addCap      drawCap
    _assertCaps(PAXOS_HUB, address(AaveV4EthereumSpokes.USDG_PENDLE_SPOKE), AaveV4EthereumAssets.PT_USDG_24SEP2026_UNDERLYING, 30_000_000, 0);
  }

  // prettier-ignore
  function test_caps_creditLines_before() public virtual {
    //                                                                                                                  addCap drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),         AaveV4EthereumAssets.frxUSD_UNDERLYING, 0,     4_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.frxUSD_UNDERLYING, 0,     300_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.USDG_PENDLE_SPOKE),      AaveV4EthereumAssets.USDG_UNDERLYING,   0,     30_000_000);
  }

  // prettier-ignore
  function test_caps_creditLines() public virtual {
    _executePayload();

    //                                                                                                                  addCap drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),         AaveV4EthereumAssets.frxUSD_UNDERLYING, 0,     5_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.frxUSD_UNDERLYING, 0,     500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.USDG_PENDLE_SPOKE),      AaveV4EthereumAssets.USDG_UNDERLYING,   0,     15_000_000);
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
