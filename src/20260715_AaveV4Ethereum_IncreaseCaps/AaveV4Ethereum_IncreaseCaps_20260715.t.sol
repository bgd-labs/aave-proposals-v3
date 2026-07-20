// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IHub, IHubConfigurator, IAccessManagerEnumerable} from 'aave-address-book/AaveV4.sol';
import {IExecutor} from 'aave-address-book/governance-v3/IExecutor.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumAssets, AaveV4EthereumGetters} from 'aave-address-book/AaveV4Ethereum.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';

import {AaveV4Ethereum_IncreaseCaps_20260715} from './AaveV4Ethereum_IncreaseCaps_20260715.sol';

import 'aave-helpers/src/ProtocolV4TestBase.sol';

/**
 * @dev Test for AaveV4Ethereum_IncreaseCaps_20260715
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260715_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260715.t.sol -vv
 */
contract AaveV4Ethereum_IncreaseCaps_20260715_Test is ProtocolV4TestBase {
  AaveV4Ethereum_IncreaseCaps_20260715 internal payload;

  IAccessManagerEnumerable internal constant ACCESS_MANAGER = AaveV4Ethereum.ACCESS_MANAGER;

  address internal constant SECURITY_COUNCIL = 0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9;
  address internal constant EXECUTOR = 0x14339e2178A954d5FB839D5Ff31644fE0F25F517;

  IHub internal constant CORE_HUB = AaveV4EthereumHubs.CORE_HUB;
  IHub internal constant PLUS_HUB = AaveV4EthereumHubs.PLUS_HUB;
  IHub internal constant PRIME_HUB = AaveV4EthereumHubs.PRIME_HUB;

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25538091);

    payload = new AaveV4Ethereum_IncreaseCaps_20260715();
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
    string memory reportName = 'AaveV4Ethereum_IncreaseCaps_20260715';

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
  // | Spoke | Asset | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |-------|-------|-------------|--------------|--------------|---------------|
  // | Main  | USDC  |  12,500,000 |   15,000,000 |   12,500,000 |    15,000,000 |
  // | Main  | WETH  |      24,000 |       30,000 |        2,050 |         2,600 |
  // | Main  | cbBTC |         220 |          400 |           14 |            26 |
  //
  // Plus Hub
  //
  // | Spoke            | Asset | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |------------------|-------|-------------|--------------|--------------|---------------|
  // | Ethena Ecosystem | sUSDe |   6,000,000 |    8,000,000 |            0 |             - |
  //
  // Prime Hub
  //
  // | Spoke    | Asset | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |----------|-------|-------------|--------------|--------------|---------------|
  // | Bluechip | WETH  |       3,200 |        5,000 |            0 |             - |
  //
  // Credit Lines (cross-hub draws from Core)
  //
  // | Spoke       | Asset | Current Draw | Proposed Draw |
  // |-------------|-------|--------------|---------------|
  // | USDG Pendle | USDG  |   15,000,000 |    20,000,000 |
  // ================================================================

  // prettier-ignore
  function test_caps_coreHub_before() public virtual {
    //                                                                                                        addCap      drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,  12_500_000, 12_500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,  24_000,     2_050);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE), AaveV4EthereumAssets.cbBTC_UNDERLYING, 220,        14);
  }

  // prettier-ignore
  function test_caps_coreHub() public virtual {
    _executePayload();

    //                                                                                                        addCap      drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,  15_000_000, 15_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,  30_000,     2_600);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE), AaveV4EthereumAssets.cbBTC_UNDERLYING, 400,        26);
  }

  // prettier-ignore
  function test_caps_plusHub_before() public virtual {
    //                                                                                                                   addCap     drawCap
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.sUSDe_UNDERLYING, 6_000_000, 0);
  }

  // prettier-ignore
  function test_caps_plusHub() public virtual {
    _executePayload();

    //                                                                                                                   addCap     drawCap
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.sUSDe_UNDERLYING, 8_000_000, 0);
  }

  // prettier-ignore
  function test_caps_primeHub_before() public virtual {
    //                                                                                                       addCap drawCap
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING, 3_200, 0);
  }

  // prettier-ignore
  function test_caps_primeHub() public virtual {
    _executePayload();

    //                                                                                                       addCap drawCap
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING, 5_000, 0);
  }

  // prettier-ignore
  function test_caps_creditLines_before() public virtual {
    //                                                                                                              addCap drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.USDG_PENDLE_SPOKE), AaveV4EthereumAssets.USDG_UNDERLYING, 0,     15_000_000);
  }

  // prettier-ignore
  function test_caps_creditLines() public virtual {
    _executePayload();

    //                                                                                                              addCap drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.USDG_PENDLE_SPOKE), AaveV4EthereumAssets.USDG_UNDERLYING, 0,     20_000_000);
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
