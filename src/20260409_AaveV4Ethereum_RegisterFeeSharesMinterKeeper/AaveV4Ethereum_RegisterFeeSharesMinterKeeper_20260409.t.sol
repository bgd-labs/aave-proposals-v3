// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from 'forge-std/Vm.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV4TestBase} from 'src/helpers/v4/tests/utils/ProtocolV4TestBase.sol';
import {ISpoke} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/ISpoke.sol';
import {
  AaveV4EthereumSpokes,
  AaveV4EthereumTokenizationSpokes
} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/AaveV4EthereumAddresses.sol';

import {IAaveCLRobotOperator} from 'src/interfaces/IAaveCLRobotOperator.sol';
import {IFeeSharesMinterBase} from 'src/interfaces/IFeeSharesMinterBase.sol';
import {IHub} from './dependencies/IHub.sol';
import {IAccessManager} from './dependencies/IAccessManager.sol';
import {
  AaveV4Ethereum_RegisterFeeSharesMinterKeeper_20260409
} from './AaveV4Ethereum_RegisterFeeSharesMinterKeeper_20260409.sol';

/**
 * @dev Test for AaveV4Ethereum_RegisterFeeSharesMinterKeeper_20260409
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260409_AaveV4Ethereum_RegisterFeeSharesMinterKeeper/AaveV4Ethereum_RegisterFeeSharesMinterKeeper_20260409.t.sol -vv
 */
contract AaveV4Ethereum_RegisterFeeSharesMinterKeeper_20260409_Test is ProtocolV4TestBase {
  AaveV4Ethereum_RegisterFeeSharesMinterKeeper_20260409 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24845913);
    proposal = new AaveV4Ethereum_RegisterFeeSharesMinterKeeper_20260409();
  }

  /**
   * @dev executes the generic test suite with config snapshots (e2e disabled to stay within gas limits)
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV4Ethereum_RegisterFeeSharesMinterKeeper_20260409',
      AaveV4EthereumSpokes.getUserSpokes(),
      AaveV4EthereumTokenizationSpokes.getTokenizationSpokes(),
      address(proposal),
      false
    );
  }

  function test_hubAssetCounts() public view {
    assertEq(proposal.CORE_HUB().getAssetCount(), 17, 'Core Hub asset count');
    assertEq(proposal.PLUS_HUB().getAssetCount(), 7, 'Plus Hub asset count');
    assertEq(proposal.PRIME_HUB().getAssetCount(), 7, 'Prime Hub asset count');

    uint256 totalAssets = proposal.CORE_HUB().getAssetCount() +
      proposal.PLUS_HUB().getAssetCount() +
      proposal.PRIME_HUB().getAssetCount();
    assertEq(totalAssets, proposal.TOTAL_KEEPERS(), 'Total assets across all hubs');
  }

  function test_feeMinterRoleGranted() public {
    IAccessManager accessManager = proposal.ACCESS_MANAGER();
    uint64 roleId = proposal.HUB_FEE_MINTER_ROLE();

    vm.recordLogs();
    executePayload(vm, address(proposal));
    Vm.Log[] memory logs = vm.getRecordedLogs();

    address minterAddress = _getMinterAddressFromLogs(logs);

    (bool hasRole, ) = accessManager.hasRole(roleId, minterAddress);
    assertTrue(hasRole, 'FeeSharesMinter should have HUB_FEE_MINTER_ROLE');
  }

  function test_keepersRegisteredForAllHubAssets() public {
    bytes32 keeperRegisteredSelector = IAaveCLRobotOperator.KeeperRegistered.selector;

    vm.recordLogs();
    executePayload(vm, address(proposal));
    Vm.Log[] memory logs = vm.getRecordedLogs();

    uint256 keeperCount;
    uint256 totalLinkFunded;
    address upkeepAddress;

    for (uint256 i; i < logs.length; ++i) {
      if (
        logs[i].emitter == MiscEthereum.AAVE_CL_ROBOT_OPERATOR &&
        logs[i].topics[0] == keeperRegisteredSelector
      ) {
        keeperCount++;
        address upkeep = address(uint160(uint256(logs[i].topics[2])));
        uint96 amount = uint96(uint256(logs[i].topics[3]));

        if (upkeepAddress == address(0)) {
          upkeepAddress = upkeep;
        }
        assertEq(upkeep, upkeepAddress, 'All keepers should use the same upkeep contract');
        assertGt(amount, 0, 'Each keeper should be funded with LINK');
        totalLinkFunded += amount;
      }
    }

    assertEq(keeperCount, proposal.TOTAL_KEEPERS(), 'Wrong number of keepers registered');
    assertEq(
      totalLinkFunded,
      proposal.LINK_AMOUNT(),
      'Total LINK funded should match withdrawn amount'
    );
  }

  function test_configSetOnAllAssets() public {
    vm.recordLogs();
    executePayload(vm, address(proposal));
    Vm.Log[] memory logs = vm.getRecordedLogs();

    address minterAddress = _getMinterAddressFromLogs(logs);
    IFeeSharesMinterBase minter = IFeeSharesMinterBase(minterAddress);

    IHub[3] memory hubs = [proposal.CORE_HUB(), proposal.PLUS_HUB(), proposal.PRIME_HUB()];
    for (uint256 i; i < hubs.length; ++i) {
      uint256 assetCount = hubs[i].getAssetCount();
      for (uint256 assetId; assetId < assetCount; ++assetId) {
        assertEq(
          minter.getConfig(address(hubs[i]), assetId),
          proposal.MIN_ACCRUED_FEES_PERCENT(),
          'Config should be set to 5%'
        );
      }
    }
  }

  function test_performUpkeepMintsFeeShares() public {
    vm.recordLogs();
    executePayload(vm, address(proposal));
    Vm.Log[] memory logs = vm.getRecordedLogs();

    address minterAddress = _getMinterAddressFromLogs(logs);
    IFeeSharesMinterBase minter = IFeeSharesMinterBase(minterAddress);
    IHub hub = proposal.CORE_HUB();
    uint256 assetId = 0;

    skip(20000 days);

    uint256 accruedFeesBefore = hub.getAssetAccruedFees(assetId);
    uint256 addedSharesBefore = hub.getAddedShares(assetId);

    assertGt(accruedFeesBefore, 0, 'Accrued fees should be non-zero before upkeep');

    (bool upkeepNeeded, bytes memory performData) = minter.checkUpkeep(
      abi.encode(address(hub), assetId)
    );

    assertTrue(upkeepNeeded, 'Upkeep should be needed after sufficient time');
    minter.performUpkeep(performData);
    uint256 gasUsed = vm.snapshotGasLastCall('performUpkeep');
    assertLt(gasUsed, 100_000, 'performUpkeep should use less than 100k gas');

    uint256 accruedFeesAfter = hub.getAssetAccruedFees(assetId);
    uint256 addedSharesAfter = hub.getAddedShares(assetId);

    assertEq(accruedFeesAfter, 0, 'Accrued fees should be zero after minting fee shares');
    assertGt(addedSharesAfter, addedSharesBefore, 'Total added shares should increase');
  }

  function test_noLinkRemainsOnProposal() public {
    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).balanceOf(address(proposal)),
      0,
      'No LINK should remain on proposal contract'
    );
  }

  function _getMinterAddressFromLogs(Vm.Log[] memory logs) internal pure returns (address) {
    bytes32 keeperRegisteredSelector = IAaveCLRobotOperator.KeeperRegistered.selector;
    for (uint256 i; i < logs.length; ++i) {
      if (
        logs[i].emitter == MiscEthereum.AAVE_CL_ROBOT_OPERATOR &&
        logs[i].topics[0] == keeperRegisteredSelector
      ) {
        return address(uint160(uint256(logs[i].topics[2])));
      }
    }
    revert('No KeeperRegistered event found');
  }
}
