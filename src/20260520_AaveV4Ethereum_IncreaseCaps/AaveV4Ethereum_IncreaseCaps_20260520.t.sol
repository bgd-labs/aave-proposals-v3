// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IHub, IHubConfigurator, IAccessManagerEnumerable} from 'aave-address-book/AaveV4.sol';
import {IExecutor} from 'aave-address-book/governance-v3/IExecutor.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumAssets} from 'aave-address-book/AaveV4Ethereum.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {AaveV4EthereumSpokeHelpers, AaveV4EthereumTokenizationSpokeHelpers} from 'aave-helpers/src/dependencies/v4/AaveV4EthereumHelpers.sol';

import {AaveV4Ethereum_IncreaseCaps_20260520} from './AaveV4Ethereum_IncreaseCaps_20260520.sol';

import 'aave-helpers/src/ProtocolV4TestBase.sol';

/**
 * @dev Test for AaveV4Ethereum_IncreaseCaps_20260520
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260520_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260520.t.sol -vv
 */
contract AaveV4Ethereum_IncreaseCaps_20260520_Test is ProtocolV4TestBase {
  AaveV4Ethereum_IncreaseCaps_20260520 internal payload;

  IAccessManagerEnumerable internal constant ACCESS_MANAGER = AaveV4Ethereum.ACCESS_MANAGER;

  address internal constant SECURITY_COUNCIL = 0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9;
  address internal constant EXECUTOR = 0x14339e2178A954d5FB839D5Ff31644fE0F25F517;

  IHub internal constant CORE_HUB = AaveV4EthereumHubs.CORE_HUB;
  IHub internal constant PRIME_HUB = AaveV4EthereumHubs.PRIME_HUB;

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25134791);

    payload = new AaveV4Ethereum_IncreaseCaps_20260520();
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
    string memory reportName = 'AaveV4Ethereum_IncreaseCaps_20260520';

    IHub[] memory hubs = AaveV4EthereumHubHelpers.getHubs();
    ISpoke[] memory spokes = AaveV4EthereumSpokeHelpers.getUserSpokes();

    string memory beforeName = string.concat(reportName, '_before');
    string memory afterName = string.concat(reportName, '_after');

    Types.V4Snapshot memory snapshotBefore = createV4Snapshot(spokes, hubs);
    writeV4SnapshotJson(beforeName, snapshotBefore);

    (string memory rawDiff, string memory logsJson) = _executePayloadWithRecording();

    Types.V4Snapshot memory snapshotAfter = createV4Snapshot(spokes, hubs);
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
    e2eTestAllTokenizationSpokes(AaveV4EthereumTokenizationSpokeHelpers.getTokenizationSpokes());
    vm.resumeGasMetering();
  }

  /// @dev Kelp Spoke is excluded from e2e: its reserves currently have
  ///      `collateralFactor = 0`, leaving no usable collateral for the
  ///      supply/borrow/liquidation flows. This payload does not touch it.
  function _getE2eSpokes() internal pure returns (ISpoke[] memory) {
    ISpoke[] memory all = AaveV4EthereumSpokeHelpers.getUserSpokes();
    ISpoke[] memory filtered = new ISpoke[](all.length - 1);
    uint256 j;
    for (uint256 i; i < all.length; i++) {
      if (address(all[i]) == address(AaveV4EthereumSpokes.KELP_E_SPOKE)) continue;
      filtered[j++] = all[i];
    }
    return filtered;
  }

  // ================================================================
  // Cap updates — Core Hub
  //
  // | Spoke   | Asset | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |---------|-------|-------------|--------------|--------------|---------------|
  // | Etherfi | WETH  |           0 |            - |        6,500 |         8,500 |
  // | Etherfi | weETH |       6,500 |        8,500 |            0 |             - |
  // | Lido    | WETH  |           0 |            - |        4,000 |         4,800 |
  // | Lido    | wstETH|       4,000 |        4,800 |            0 |             - |
  // | Main    | LINK  |     185,000 |      220,000 |            0 |             - |
  // | Main    | USDG  |   3,500,000 |   10,000,000 |    2,360,000 |     6,800,000 |
  // | Main    | USDT  |   7,000,000 |    8,500,000 |    7,000,000 |     8,500,000 |
  // | Main    | WBTC  |         110 |          170 |            9 |            15 |
  // | Main    | WETH  |      14,500 |       18,500 |        1,250 |         1,600 |
  // | Main    | frxUSD|   4,500,000 |   10,000,000 |    3,060,000 |     6,800,000 |
  // | Main    | weETH |         800 |        1,000 |            0 |             - |
  // | Main    | wstETH|       2,150 |        2,800 |            0 |             - |
  // ================================================================

  // prettier-ignore
  function test_caps_coreHub_before() public virtual {
    //                                                                                                                  addCap     drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHERFI_E_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,          0,         6_500);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHERFI_E_SPOKE), AaveV4EthereumAssets.weETH_UNDERLYING,         6_500,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.LIDO_E_SPOKE),    AaveV4EthereumAssets.WETH_UNDERLYING,          0,         4_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.LIDO_E_SPOKE),    AaveV4EthereumAssets.wstETH_UNDERLYING,        4_000,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.LINK_UNDERLYING,          185_000,   0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDG_UNDERLYING,          3_500_000, 2_360_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDT_UNDERLYING,          7_000_000, 7_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.WBTC_UNDERLYING,          110,       9);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.WETH_UNDERLYING,          14_500,    1_250);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.frxUSD_UNDERLYING,        4_500_000, 3_060_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.weETH_UNDERLYING,         800,       0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.wstETH_UNDERLYING,        2_150,     0);
  }

  // prettier-ignore
  function test_caps_coreHub() public virtual {
    _executePayload();

    //                                                                                                                  addCap      drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHERFI_E_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,          0,          8_500);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHERFI_E_SPOKE), AaveV4EthereumAssets.weETH_UNDERLYING,         8_500,      0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.LIDO_E_SPOKE),    AaveV4EthereumAssets.WETH_UNDERLYING,          0,          4_800);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.LIDO_E_SPOKE),    AaveV4EthereumAssets.wstETH_UNDERLYING,        4_800,      0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.LINK_UNDERLYING,          220_000,    0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDG_UNDERLYING,          10_000_000, 6_800_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDT_UNDERLYING,          8_500_000,  8_500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.WBTC_UNDERLYING,          170,        15);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.WETH_UNDERLYING,          18_500,     1_600);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.frxUSD_UNDERLYING,        10_000_000, 6_800_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.weETH_UNDERLYING,         1_000,      0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.wstETH_UNDERLYING,        2_800,      0);
  }

  // ================================================================
  // Cap updates — Prime Hub
  //
  // | Spoke    | Asset | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |----------|-------|-------------|--------------|--------------|---------------|
  // | Bluechip | USDC  |   2,500,000 |    3,000,000 |    2,910,000 |     3,500,000 |
  // | Bluechip | USDT  |   2,500,000 |    3,000,000 |    3,130,000 |     3,750,000 |
  // | Bluechip | WBTC  |          90 |          120 |            0 |             - |
  // | Bluechip | WETH  |       1,700 |        2,200 |            0 |             - |
  // | Bluechip | cbBTC |          45 |           60 |            0 |             - |
  // | Bluechip | wstETH|       1,800 |        2,400 |            0 |             - |
  // ================================================================

  // prettier-ignore
  function test_caps_primeHub_before() public virtual {
    //                                                                                                                   addCap     drawCap
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,           2_500_000, 2_910_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,           2_500_000, 3_130_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WBTC_UNDERLYING,           90,        0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,           1_700,     0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.cbBTC_UNDERLYING,          45,        0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.wstETH_UNDERLYING,         1_800,     0);
  }

  // prettier-ignore
  function test_caps_primeHub() public virtual {
    _executePayload();

    //                                                                                                                   addCap     drawCap
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,           3_000_000, 3_500_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,           3_000_000, 3_750_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WBTC_UNDERLYING,           120,       0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,           2_200,     0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.cbBTC_UNDERLYING,          60,        0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.wstETH_UNDERLYING,         2_400,     0);
  }

  // ================================================================
  // Credit Lines
  //
  // | Origin   | Target Spoke | Asset | Current Credit Line | Proposed Credit Line |
  // |----------|--------------|-------|---------------------|----------------------|
  // | Core Hub | Bluechip     | USDT  |             625,000 |            1,250,000 |
  // | Core Hub | Bluechip     | frxUSD|             300,000 |            1,000,000 |
  // ================================================================

  // prettier-ignore
  function test_creditLines_before() public virtual {
    //                                                                                                                          addCap  drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,                   0,      625_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.frxUSD_UNDERLYING,                 0,      300_000);
  }

  // prettier-ignore
  function test_creditLines() public virtual {
    _executePayload();

    //                                                                                                                          addCap  drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,                   0,      1_250_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.frxUSD_UNDERLYING,                 0,      1_000_000);
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
