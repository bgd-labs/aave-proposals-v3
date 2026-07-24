// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IHub, ISpoke, IAccessManagerEnumerable} from 'aave-address-book/AaveV4.sol';
import {IExecutor} from 'aave-address-book/governance-v3/IExecutor.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';

import {AaveV4AvalancheRound11, AaveV4Avalanche_IncreaseCaps_20260723} from './AaveV4Avalanche_IncreaseCaps_20260723.sol';

import 'aave-helpers/src/ProtocolV4TestBase.sol';

/**
 * @dev Test for AaveV4Avalanche_IncreaseCaps_20260723
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260723_Multi_AaveV4CapsIncreaseRound11/AaveV4Avalanche_IncreaseCaps_20260723.t.sol -vv
 */
contract AaveV4Avalanche_IncreaseCaps_20260723_Test is ProtocolV4TestBase {
  // https://snowscan.xyz/address/0xe069096bDAfF9bAD15b2f1079EaF0f1685a24522
  IAccessManagerEnumerable internal constant ACCESS_MANAGER =
    IAccessManagerEnumerable(0xe069096bDAfF9bAD15b2f1079EaF0f1685a24522);

  // https://snowscan.xyz/address/0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9
  address internal constant SECURITY_COUNCIL = 0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9;
  // https://snowscan.xyz/address/0xb619fA61e795D47f517702e63ce50292370561F1
  address internal constant EXECUTOR = 0xb619fA61e795D47f517702e63ce50292370561F1;

  // https://snowscan.xyz/address/0x435272CefF93a1E657E8ABfdf0A13e95900A3a56
  ISpoke internal constant MAIN_SPOKE = ISpoke(0x435272CefF93a1E657E8ABfdf0A13e95900A3a56);
  // https://snowscan.xyz/address/0x3b517594277c67307CF2d7CBE6FE1D4399B68c41
  ISpoke internal constant AVAX_CORRELATED_SPOKE =
    ISpoke(0x3b517594277c67307CF2d7CBE6FE1D4399B68c41);

  AaveV4Avalanche_IncreaseCaps_20260723 internal payload;

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 91036002);
    payload = new AaveV4Avalanche_IncreaseCaps_20260723();
  }

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
    string memory reportName = 'AaveV4Avalanche_IncreaseCaps_20260723';

    IHub[] memory hubs = new IHub[](1);
    hubs[0] = AaveV4AvalancheRound11.CORE_HUB;

    ISpoke[] memory spokes = new ISpoke[](3);
    spokes[0] = MAIN_SPOKE;
    spokes[1] = AaveV4AvalancheRound11.FOREX_SPOKE;
    spokes[2] = AVAX_CORRELATED_SPOKE;

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

    diffV4Snapshots(reportName);
  }

  // prettier-ignore
  function test_caps_before() public view virtual {
    //                                                                                         addCap   drawCap
    _assertCaps(AaveV4AvalancheRound11.USDC,                                                   200_000, 150_000);
    _assertCaps(AaveV4AvalancheRound11.USDt,                                                   200_000, 150_000);
  }

  // prettier-ignore
  function test_caps() public virtual {
    _executePayload();

    //                                                                                         addCap   drawCap
    _assertCaps(AaveV4AvalancheRound11.USDC,                                                   400_000, 350_000);
    _assertCaps(AaveV4AvalancheRound11.USDt,                                                   400_000, 350_000);
  }

  function _executePayload() internal virtual {
    vm.prank(SECURITY_COUNCIL);
    IExecutor(EXECUTOR).executeTransaction(address(payload), 0, 'execute()', bytes(''), true);
  }

  function _assertCaps(
    address underlying,
    uint256 expectedAddCap,
    uint256 expectedDrawCap
  ) internal view {
    IHub hub = AaveV4AvalancheRound11.CORE_HUB;
    IHub.SpokeConfig memory config = hub.getSpokeConfig(
      hub.getAssetId(underlying),
      address(AaveV4AvalancheRound11.FOREX_SPOKE)
    );
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
