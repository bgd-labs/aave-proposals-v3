// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130, IExecutor, AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_Part2_20240130} from './AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130.sol';
import {PayloadsToDeploy} from './MigrationOfRemainingGovV2Permissions_20240130.s.sol';
import {MainnetPayload, IAaveArcTimelock} from './MainnetPayload.sol';
import {PolygonPayload} from './PolygonPayload.sol';

/**
 * @dev Test for AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130
 * command: make test-contract filter=AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130
 */
contract AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130_Test is ProtocolV2TestBase {
  AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130 internal proposal;
  AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_Part2_20240130 internal proposalPart2;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19119958);
    proposal = AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130(
      PayloadsToDeploy.part1(address(new MainnetPayload()), address(0))
    );
    proposalPart2 = AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_Part2_20240130(
      PayloadsToDeploy.part2(address(proposal))
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    uint256 wETHBalance = IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    assert(proposal.EXECUTION_TIME() == block.timestamp + 7 days);
    vm.warp(proposal.EXECUTION_TIME() - 2 days);
    executePayload(vm, address(proposal));
    vm.warp(proposal.EXECUTION_TIME());
    executePayload(vm, address(proposalPart2));
    uint256 wETHBalanceAfter = IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    assertGt(wETHBalanceAfter, wETHBalance);

    _testArc();
  }

  function _testArc() internal {
    // execute payload on arc timelock
    uint256 currentActionId = IAaveArcTimelock(AaveGovernanceV2.ARC_TIMELOCK).getActionsSetCount();

    skip(3 days + 10);
    IAaveArcTimelock(AaveGovernanceV2.ARC_TIMELOCK).execute(currentActionId - 1);

    assertEq(
      IAaveArcTimelock(AaveGovernanceV2.ARC_TIMELOCK).getEthereumGovernanceExecutor(),
      GovernanceV3Ethereum.EXECUTOR_LVL_1
    );

    rewind(3 days + 10);
  }
}

/**
 * @dev Test for AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130
 * command: make test-contract filter=AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130_Polygon
 */
contract AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130_Polygon_Test is
  ProtocolV2TestBase
{
  PolygonPayload proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 52961125);
    proposal = new PolygonPayload();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    uint256 wMATICBalance = IERC20(AaveV3PolygonAssets.WMATIC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
    uint256 wMATICBalanceAfter = IERC20(AaveV3PolygonAssets.WMATIC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    assertGt(wMATICBalanceAfter, wMATICBalance);
  }
}
