// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IHub, IHubConfigurator, IAccessManagerEnumerable} from 'aave-address-book/AaveV4.sol';
import {IExecutor} from 'aave-address-book/governance-v3/IExecutor.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumAssets, AaveV4EthereumGetters} from 'aave-address-book/AaveV4Ethereum.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';

import {AaveV4Ethereum_IncreaseCaps_20260504} from './AaveV4Ethereum_IncreaseCaps_20260504.sol';

import 'aave-helpers/src/ProtocolV4TestBase.sol';

/**
 * @dev Test for AaveV4Ethereum_IncreaseCaps_20260504
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260504_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260504.t.sol -vv
 */
contract AaveV4Ethereum_IncreaseCaps_20260504_Test is ProtocolV4TestBase {
  AaveV4Ethereum_IncreaseCaps_20260504 internal payload;

  IAccessManagerEnumerable internal constant ACCESS_MANAGER = AaveV4Ethereum.ACCESS_MANAGER;

  address internal constant SECURITY_COUNCIL = 0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9;
  address internal constant EXECUTOR = 0x14339e2178A954d5FB839D5Ff31644fE0F25F517;

  IHub internal constant CORE_HUB = AaveV4EthereumHubs.CORE_HUB;
  IHub internal constant PRIME_HUB = AaveV4EthereumHubs.PRIME_HUB;

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25020521);

    payload = new AaveV4Ethereum_IncreaseCaps_20260504();
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
    string memory reportName = 'AaveV4Ethereum_IncreaseCaps_20260504';

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
  // | Spoke   | Asset | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |---------|-------|-------------|--------------|--------------|---------------|
  // | Etherfi | WETH  |           0 |            - |        2,500 |         6,500 |
  // | Etherfi | weETH |       2,500 |        6,500 |            0 |             - |
  // | Lido    | WETH  |           0 |            - |        2,000 |         4,000 |
  // | Lido    | wstETH|       2,000 |        4,000 |            0 |             - |
  // | Main    | LINK  |      75,000 |      185,000 |            0 |             - |
  // | Main    | USDG  |   2,000,000 |    3,500,000 |    1,350,000 |     2,360,000 |
  // | Main    | USDT  |   4,000,000 |    7,000,000 |    4,000,000 |     7,000,000 |
  // | Main    | WBTC  |          40 |          110 |            5 |             9 |
  // | Main    | WETH  |       5,500 |       14,500 |          475 |         1,250 |
  // | Main    | cbBTC |          20 |           50 |            3 |             - |
  // | Main    | frxUSD|   2,500,000 |    4,500,000 |    1,700,000 |     3,060,000 |
  // | Main    | weETH |         200 |          800 |            0 |             - |
  // | Main    | wstETH|         650 |        2,150 |            0 |             - |
  // ================================================================

  // prettier-ignore
  function test_caps_coreHub_before() public virtual {
    //                                                                                                                  addCap     drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHERFI_ESPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,          0,         2_500);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHERFI_ESPOKE), AaveV4EthereumAssets.weETH_UNDERLYING,         2_500,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.LIDO_ESPOKE),    AaveV4EthereumAssets.WETH_UNDERLYING,          0,         2_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.LIDO_ESPOKE),    AaveV4EthereumAssets.wstETH_UNDERLYING,        2_000,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.LINK_UNDERLYING,          75_000,    0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDG_UNDERLYING,          2_000_000, 1_350_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDT_UNDERLYING,          4_000_000, 4_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.WBTC_UNDERLYING,          40,        5);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.WETH_UNDERLYING,          5_500,     475);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.cbBTC_UNDERLYING,         20,        3);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.frxUSD_UNDERLYING,        2_500_000, 1_700_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.weETH_UNDERLYING,         200,       0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.wstETH_UNDERLYING,        650,       0);
  }

  // prettier-ignore
  function test_caps_coreHub() public virtual {
    _executePayload();

    //                                                                                                                  addCap     drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHERFI_ESPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,          0,         6_500);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHERFI_ESPOKE), AaveV4EthereumAssets.weETH_UNDERLYING,         6_500,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.LIDO_ESPOKE),    AaveV4EthereumAssets.WETH_UNDERLYING,          0,         4_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.LIDO_ESPOKE),    AaveV4EthereumAssets.wstETH_UNDERLYING,        4_000,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.LINK_UNDERLYING,          185_000,   0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDG_UNDERLYING,          3_500_000, 2_360_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDT_UNDERLYING,          7_000_000, 7_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.WBTC_UNDERLYING,          110,       9);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.WETH_UNDERLYING,          14_500,    1_250);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.cbBTC_UNDERLYING,         50,        3);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.frxUSD_UNDERLYING,        4_500_000, 3_060_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.weETH_UNDERLYING,         800,       0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.wstETH_UNDERLYING,        2_150,     0);
  }

  // ================================================================
  // Cap updates — Prime Hub
  //
  // | Spoke    | Asset | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |----------|-------|-------------|--------------|--------------|---------------|
  // | Bluechip | USDC  |   1,500,000 |    2,500,000 |    1,750,000 |     2,910,000 |
  // | Bluechip | USDT  |   1,500,000 |    2,500,000 |    1,880,000 |     3,130,000 |
  // | Bluechip | WBTC  |          30 |           90 |            0 |             - |
  // | Bluechip | WETH  |         500 |        1,700 |            0 |             - |
  // | Bluechip | cbBTC |          25 |           45 |            0 |             - |
  // | Bluechip | wstETH|         600 |        1,800 |            0 |             - |
  // ================================================================

  // prettier-ignore
  function test_caps_primeHub_before() public virtual {
    //                                                                                                                   addCap     drawCap
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,           1_500_000, 1_750_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,           1_500_000, 1_880_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WBTC_UNDERLYING,           30,        0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,           500,       0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.cbBTC_UNDERLYING,          25,        0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.wstETH_UNDERLYING,         600,       0);
  }

  // prettier-ignore
  function test_caps_primeHub() public virtual {
    _executePayload();

    //                                                                                                                   addCap     drawCap
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,           2_500_000, 2_910_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,           2_500_000, 3_130_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WBTC_UNDERLYING,           90,        0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,           1_700,     0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.cbBTC_UNDERLYING,          45,        0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.wstETH_UNDERLYING,         1_800,     0);
  }

  // ================================================================
  // Credit Lines
  //
  // | Origin   | Target Spoke | Asset | Current Credit Line | Proposed Credit Line |
  // |----------|--------------|-------|---------------------|----------------------|
  // | Core Hub | Bluechip     | USDT  |             375,000 |              625,000 |
  // | Core Hub | Bluechip     | frxUSD|             200,000 |              300,000 |
  // | Core Hub | Gold         | USDT  |             125,000 |              200,000 |
  // | Core Hub | Gold         | frxUSD|              62,500 |              100,000 |
  // ================================================================

  // prettier-ignore
  function test_creditLines_before() public virtual {
    //                                                                                                                          addCap  drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,                   0,      375_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.frxUSD_UNDERLYING,                 0,      200_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),     AaveV4EthereumAssets.USDT_UNDERLYING,                   0,      125_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),     AaveV4EthereumAssets.frxUSD_UNDERLYING,                 0,      62_500);
  }

  // prettier-ignore
  function test_creditLines() public virtual {
    _executePayload();

    //                                                                                                                          addCap  drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,                   0,      625_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.frxUSD_UNDERLYING,                 0,      300_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),     AaveV4EthereumAssets.USDT_UNDERLYING,                   0,      200_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),     AaveV4EthereumAssets.frxUSD_UNDERLYING,                 0,      100_000);
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
