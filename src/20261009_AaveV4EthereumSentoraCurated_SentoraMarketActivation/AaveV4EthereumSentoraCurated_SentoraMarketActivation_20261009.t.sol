// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {IOwnable2Step} from 'src/interfaces/IOwnable2Step.sol';
import {SentoraTestBase} from './SentoraTestBase.sol';

/**
 * @dev Test for AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009. `SentoraTestBase` replays
 *      the deployer's relinquish before each test.
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20261009_AaveV4EthereumSentoraCurated_SentoraMarketActivation/AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009.t.sol -vv
 */
contract AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009_Test is SentoraTestBase {
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
      assertEq(IOwnable2Step(owned[i]).pendingOwner(), EXECUTOR, 'pending owner');
    }
    _assertAllHalted(true);
  }

  function test_ownershipsAccepted() public activated {
    address[] memory owned = _ownedByExecutor();
    for (uint256 i; i < owned.length; ++i) {
      assertEq(IOwnable2Step(owned[i]).owner(), EXECUTOR, 'owner');
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
    GovV3Helpers.executePayload(vm, payload, PPC);
    _assertPayloadGasWithinLimit(vm.lastCallGas().gasTotalUsed);
    vm.revertToState(snapshotId);

    vm.startStateDiffRecording();
    vm.recordLogs();
    GovV3Helpers.executePayload(vm, payload, PPC);
    rawDiff = vm.getStateDiffJson();
    logsJson = vm.getRecordedLogsJson();
    _validateNoExecutorStorageChange(rawDiff, EXECUTOR);
  }

  function _assertAllHalted(bool halted) internal view {
    uint256 assetCount = HUB.getAssetCount();
    assertEq(assetCount, ASSET_COUNT, 'asset count');
    uint256 pairCount;
    for (uint256 assetId; assetId < assetCount; ++assetId) {
      uint256 spokeCount = HUB.getSpokeCount(assetId);
      for (uint256 i; i < spokeCount; ++i) {
        address spoke = HUB.getSpokeAddress(assetId, i);
        assertEq(HUB.getSpokeConfig(assetId, spoke).halted, halted, 'halted');
        ++pairCount;
      }
    }
    assertEq(pairCount, SPOKE_PAIR_COUNT, 'spoke pair count');
  }
}
