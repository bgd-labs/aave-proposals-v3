// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {GovHelpers} from 'aave-helpers/src/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Polygon_RescueTokensFromAdapters_20240916_GovV2} from './AaveV3Polygon_RescueTokensFromAdapters_20240916_GovV2.sol';

/**
 * @dev Test for AaveV3Polygon_RescueTokensFromAdapters_20240916
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240916_Multi_RescueTokensFromAdapters/AaveV3Polygon_RescueTokensFromAdapters_20240916.t.sol -vv
 */
contract AaveV3Polygon_RescueTokensFromAdapters_20240916_GovV2_Test is ProtocolV3TestBase {
  AaveV3Polygon_RescueTokensFromAdapters_20240916_GovV2 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 61736283);
    proposal = new AaveV3Polygon_RescueTokensFromAdapters_20240916_GovV2();
  }

  function testProposalExecution() public {
    createConfigurationSnapshot(
      'preAaveV3Polygon_RescueTokensFromAdapters_20240916_GovV2',
      AaveV3Polygon.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    createConfigurationSnapshot(
      'postAaveV3Polygon_RescueTokensFromAdapters_20240916_GovV2',
      AaveV3Polygon.POOL
    );

    diffReports(
      'preAaveV3Polygon_RescueTokensFromAdapters_20240916_GovV2',
      'postAaveV3Polygon_RescueTokensFromAdapters_20240916_GovV2'
    );
  }

  function test_isTokensRescuedV3Previous() external {
    uint256 EURAAdminInitialBalance = IERC20(AaveV3PolygonAssets.EURA_UNDERLYING).balanceOf(
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );
    uint256 EURATransferred = IERC20(AaveV3PolygonAssets.EURA_UNDERLYING).balanceOf(
      proposal.ADAPTER_0()
    );
    uint256 CRVAdminInitialBalance = IERC20(AaveV3PolygonAssets.CRV_UNDERLYING).balanceOf(
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );
    uint256 CRVTransferred = IERC20(AaveV3PolygonAssets.CRV_UNDERLYING).balanceOf(
      proposal.ADAPTER_0()
    );
    uint256 miMATICAdminInitialBalance = IERC20(AaveV3PolygonAssets.miMATIC_UNDERLYING).balanceOf(
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );
    uint256 miMATICTransferred = IERC20(AaveV3PolygonAssets.miMATIC_UNDERLYING).balanceOf(
      proposal.ADAPTER_0()
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    // AaveV3Polygon previous
    assertEq(
      IERC20(AaveV3PolygonAssets.EURA_UNDERLYING).balanceOf(proposal.ADAPTER_0()),
      0,
      'Unexpected EURA_UNDERLYING remaining'
    );
    assertEq(
      EURAAdminInitialBalance + EURATransferred,
      IERC20(AaveV3PolygonAssets.EURA_UNDERLYING).balanceOf(
        AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
      ),
      'Unexpected EURA_UNDERLYING final treasury balance'
    );
    assertEq(
      IERC20(AaveV3PolygonAssets.CRV_UNDERLYING).balanceOf(proposal.ADAPTER_0()),
      0,
      'Unexpected CRV_UNDERLYING remaining'
    );
    assertEq(
      miMATICAdminInitialBalance + miMATICTransferred,
      IERC20(AaveV3PolygonAssets.miMATIC_UNDERLYING).balanceOf(
        AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
      ),
      'Unexpected miMATIC_UNDERLYING final treasury balance'
    );
  }
}
