// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IHub, IHubConfigurator, IAccessManagerEnumerable} from 'aave-address-book/AaveV4.sol';
import {IExecutor} from 'aave-address-book/governance-v3/IExecutor.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumAssets} from 'aave-address-book/AaveV4Ethereum.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {AaveV4EthereumSpokeHelpers, AaveV4EthereumTokenizationSpokeHelpers} from 'aave-helpers/src/dependencies/v4/AaveV4EthereumHelpers.sol';

import {AaveV4Ethereum_IncreaseCaps_20260617} from './AaveV4Ethereum_IncreaseCaps_20260617.sol';

import 'aave-helpers/src/ProtocolV4TestBase.sol';

/**
 * @dev Test for AaveV4Ethereum_IncreaseCaps_20260617
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260617_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260617.t.sol -vv
 */
contract AaveV4Ethereum_IncreaseCaps_20260617_Test is ProtocolV4TestBase {
  AaveV4Ethereum_IncreaseCaps_20260617 internal payload;

  IAccessManagerEnumerable internal constant ACCESS_MANAGER = AaveV4Ethereum.ACCESS_MANAGER;

  address internal constant SECURITY_COUNCIL = 0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9;
  address internal constant EXECUTOR = 0x14339e2178A954d5FB839D5Ff31644fE0F25F517;

  IHub internal constant CORE_HUB = AaveV4EthereumHubs.CORE_HUB;
  IHub internal constant PRIME_HUB = AaveV4EthereumHubs.PRIME_HUB;

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25338814);

    payload = new AaveV4Ethereum_IncreaseCaps_20260617();
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
    string memory reportName = 'AaveV4Ethereum_IncreaseCaps_20260617';

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
  // | Spoke | Asset  | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |-------|--------|-------------|--------------|--------------|---------------|
  // | Forex | GHO    |           0 |            - |       12,500 |        50,000 |
  // | Forex | USDG   |           0 |            - |      250,000 |       500,000 |
  // | Forex | frxUSD |           0 |            - |      250,000 |       500,000 |
  // | Main  | AAVE   |      67,000 |      100,000 |            0 |             - |
  // | Main  | USDC   |  10,000,000 |   12,500,000 |   10,000,000 |    12,500,000 |
  // | Main  | USDG   |  30,000,000 |   40,000,000 |   20,400,000 |    27,200,000 |
  // | Main  | USDT   |  15,000,000 |   20,000,000 |   15,000,000 |    20,000,000 |
  // | Main  | WBTC   |         450 |          850 |           39 |            74 |
  // | Main  | cbBTC  |         115 |          160 |            7 |            10 |
  // | Main  | frxUSD |  30,000,000 |   40,000,000 |   20,400,000 |    27,200,000 |
  // | Main  | wstETH |       6,000 |        8,000 |            0 |             - |
  //
  // Prime Hub
  //
  // | Spoke    | Asset | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |----------|-------|-------------|--------------|--------------|---------------|
  // | Bluechip | WBTC  |         280 |          400 |            0 |             - |
  // | Bluechip | cbBTC |          90 |          130 |            0 |             - |
  //
  // Credit Lines (cross-hub frxUSD draws from Core)
  //
  // | Spoke            | Asset  | Current Draw | Proposed Draw |
  // |------------------|--------|--------------|---------------|
  // | Bluechip         | frxUSD |    3,000,000 |     4,000,000 |
  // | Ethena Ecosystem | frxUSD |      200,000 |       300,000 |
  // ================================================================

  // prettier-ignore
  function test_caps_coreHub_before() public virtual {
    //                                                                                                          addCap      drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE), AaveV4EthereumAssets.GHO_UNDERLYING,    0,          12_500);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE), AaveV4EthereumAssets.USDG_UNDERLYING,   0,          250_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE), AaveV4EthereumAssets.frxUSD_UNDERLYING, 0,          250_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),  AaveV4EthereumAssets.AAVE_UNDERLYING,   67_000,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),  AaveV4EthereumAssets.USDC_UNDERLYING,   10_000_000, 10_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),  AaveV4EthereumAssets.USDG_UNDERLYING,   30_000_000, 20_400_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),  AaveV4EthereumAssets.USDT_UNDERLYING,   15_000_000, 15_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),  AaveV4EthereumAssets.WBTC_UNDERLYING,   450,        39);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),  AaveV4EthereumAssets.cbBTC_UNDERLYING,  115,        7);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),  AaveV4EthereumAssets.frxUSD_UNDERLYING, 30_000_000, 20_400_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),  AaveV4EthereumAssets.wstETH_UNDERLYING, 6_000,      0);
  }

  // prettier-ignore
  function test_caps_coreHub() public virtual {
    _executePayload();

    //                                                                                                          addCap      drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE), AaveV4EthereumAssets.GHO_UNDERLYING,    0,          50_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE), AaveV4EthereumAssets.USDG_UNDERLYING,   0,          500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE), AaveV4EthereumAssets.frxUSD_UNDERLYING, 0,          500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),  AaveV4EthereumAssets.AAVE_UNDERLYING,   100_000,    0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),  AaveV4EthereumAssets.USDC_UNDERLYING,   12_500_000, 12_500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),  AaveV4EthereumAssets.USDG_UNDERLYING,   40_000_000, 27_200_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),  AaveV4EthereumAssets.USDT_UNDERLYING,   20_000_000, 20_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),  AaveV4EthereumAssets.WBTC_UNDERLYING,   850,        74);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),  AaveV4EthereumAssets.cbBTC_UNDERLYING,  160,        10);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),  AaveV4EthereumAssets.frxUSD_UNDERLYING, 40_000_000, 27_200_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),  AaveV4EthereumAssets.wstETH_UNDERLYING, 8_000,      0);
  }

  // prettier-ignore
  function test_caps_primeHub_before() public virtual {
    //                                                                                                          addCap drawCap
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WBTC_UNDERLYING,   280,   0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.cbBTC_UNDERLYING,  90,    0);
  }

  // prettier-ignore
  function test_caps_primeHub() public virtual {
    _executePayload();

    //                                                                                                          addCap drawCap
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WBTC_UNDERLYING,   400,   0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.cbBTC_UNDERLYING,  130,   0);
  }

  // prettier-ignore
  function test_caps_creditLines_before() public virtual {
    //                                                                                                              addCap drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),         AaveV4EthereumAssets.frxUSD_UNDERLYING, 0,  3_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.frxUSD_UNDERLYING, 0,  200_000);
  }

  // prettier-ignore
  function test_caps_creditLines() public virtual {
    _executePayload();

    //                                                                                                              addCap drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),         AaveV4EthereumAssets.frxUSD_UNDERLYING, 0,  4_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.frxUSD_UNDERLYING, 0,  300_000);
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
