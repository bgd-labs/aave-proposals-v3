// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {IHub} from 'aave-address-book/AaveV4.sol';
import {IOwnable2Step} from 'src/interfaces/IOwnable2Step.sol';
import {AaveV4EthereumSentoraCurated, AaveV4EthereumSentoraCuratedHubs, AaveV4EthereumSentoraCuratedPositionManagers} from 'aave-address-book/AaveV4EthereumSentoraCurated.sol';
import {ProtocolV4TestBaseEthereumSentoraCurated} from 'aave-helpers/src/v4-protocol-test/ProtocolV4TestBaseEthereumSentoraCurated.sol';
import {AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009} from './AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009.sol';

/**
 * @dev Test for AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009. Skipped until the Sentora
 *      market is deployed and the address-book placeholders are replaced.
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20261009_AaveV4EthereumSentoraCurated_SentoraMarketActivation/AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009.t.sol -vv
 */
contract AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009_Test is
  ProtocolV4TestBaseEthereumSentoraCurated
{
  IHub internal constant SENTORA_HUB = AaveV4EthereumSentoraCuratedHubs.SENTORA_HUB;
  address internal constant SENTORA_EXECUTOR =
    AaveV4EthereumSentoraCurated.PERMISSIONED_PAYLOADS_CONTROLLER_EXECUTOR;
  address internal constant SENTORA_PAYLOADS_CONTROLLER =
    AaveV4EthereumSentoraCurated.PERMISSIONED_PAYLOADS_CONTROLLER;

  uint256 internal constant ASSET_COUNT = 8;
  /// @dev 14 reserves plus the TreasurySpoke of each of the 8 assets.
  uint256 internal constant SPOKE_PAIR_COUNT = 22;

  AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 26155605);
    vm.skip(address(SENTORA_HUB).code.length == 0 || SENTORA_PAYLOADS_CONTROLLER.code.length == 0);
    proposal = new AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009();
  }

  modifier activated() {
    _executePayload();
    _;
  }

  /// @dev executes the generic test suite including e2e and config snapshots
  /// forge-config: default.isolate = true
  function test_defaultProposalExecution() public {
    defaultTest({
      reportName: 'AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009',
      payload: address(proposal),
      runE2E: true,
      testPositionManagers: true
    });
  }

  function test_preconditions() public view {
    address[] memory owned = _ownedByExecutor();
    for (uint256 i; i < owned.length; ++i) {
      assertEq(IOwnable2Step(owned[i]).pendingOwner(), SENTORA_EXECUTOR, 'pending owner');
    }
    _assertAllHalted(true);
  }

  function test_ownershipsAccepted() public activated {
    address[] memory owned = _ownedByExecutor();
    for (uint256 i; i < owned.length; ++i) {
      assertEq(IOwnable2Step(owned[i]).owner(), SENTORA_EXECUTOR, 'owner');
      assertEq(IOwnable2Step(owned[i]).pendingOwner(), address(0), 'pending owner');
    }
  }

  function test_marketUnhalted() public activated {
    _assertAllHalted(false);
  }

  /// @dev Executes through the Sentora PermissionedPayloadsController instead of the Aave one. The
  /// base storage check only walks the Aave controller's executors, so the Sentora one is checked
  /// here.
  function _executePayloadWithRecording(
    address payload
  ) internal override returns (string memory rawDiff, string memory logsJson) {
    uint256 snapshotId = vm.snapshotState();
    GovV3Helpers.executePayload(vm, payload, SENTORA_PAYLOADS_CONTROLLER);
    _assertPayloadGasWithinLimit(vm.lastCallGas().gasTotalUsed);
    vm.revertToState(snapshotId);

    vm.startStateDiffRecording();
    vm.recordLogs();
    GovV3Helpers.executePayload(vm, payload, SENTORA_PAYLOADS_CONTROLLER);
    rawDiff = vm.getStateDiffJson();
    logsJson = vm.getRecordedLogsJson();
    _validateNoExecutorStorageChange(rawDiff, SENTORA_EXECUTOR);
  }

  function _executePayload() internal {
    GovV3Helpers.executePayload(vm, address(proposal), SENTORA_PAYLOADS_CONTROLLER);
  }

  function _assertAllHalted(bool halted) internal view {
    uint256 assetCount = SENTORA_HUB.getAssetCount();
    assertEq(assetCount, ASSET_COUNT, 'asset count');
    uint256 pairCount;
    for (uint256 assetId; assetId < assetCount; ++assetId) {
      uint256 spokeCount = SENTORA_HUB.getSpokeCount(assetId);
      for (uint256 i; i < spokeCount; ++i) {
        address spoke = SENTORA_HUB.getSpokeAddress(assetId, i);
        assertEq(SENTORA_HUB.getSpokeConfig(assetId, spoke).halted, halted, 'halted');
        ++pairCount;
      }
    }
    assertEq(pairCount, SPOKE_PAIR_COUNT, 'spoke pair count');
  }

  function _ownedByExecutor() internal pure returns (address[] memory owned) {
    owned = new address[](5);
    owned[0] = address(AaveV4EthereumSentoraCuratedPositionManagers.GIVER_POSITION_MANAGER);
    owned[1] = address(AaveV4EthereumSentoraCuratedPositionManagers.TAKER_POSITION_MANAGER);
    owned[2] = address(AaveV4EthereumSentoraCuratedPositionManagers.CONFIG_POSITION_MANAGER);
    owned[3] = address(AaveV4EthereumSentoraCuratedPositionManagers.NATIVE_TOKEN_GATEWAY);
    owned[4] = address(AaveV4EthereumSentoraCuratedPositionManagers.SIGNATURE_GATEWAY);
  }
}
