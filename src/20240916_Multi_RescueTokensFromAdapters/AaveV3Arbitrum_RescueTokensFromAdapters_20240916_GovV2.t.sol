// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GovHelpers} from 'aave-helpers/src/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_RescueTokensFromAdapters_20240916_GovV2} from './AaveV3Arbitrum_RescueTokensFromAdapters_20240916_GovV2.sol';

/**
 * @dev Test for AaveV3Arbitrum_RescueTokensFromAdapters_20240916_GovV2
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240916_Multi_RescueTokensFromAdapters/AaveV3Arbitrum_RescueTokensFromAdapters_20240916_GovV2.t.sol -vv
 */
contract AaveV3Arbitrum_RescueTokensFromAdapters_20240916_GovV2_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_RescueTokensFromAdapters_20240916_GovV2 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 119814137);
    proposal = new AaveV3Arbitrum_RescueTokensFromAdapters_20240916_GovV2();
  }

  function testProposalExecution() public {
    createConfigurationSnapshot(
      'preAaveV3Arbitrum_RescueTokensFromAdapters_20240916_GovV2',
      AaveV3Arbitrum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    createConfigurationSnapshot(
      'postAaveV3Arbitrum_RescueTokensFromAdapters_20240916_GovV2',
      AaveV3Arbitrum.POOL
    );

    diffReports(
      'preAaveV3Arbitrum_RescueTokensFromAdapters_20240916_GovV2',
      'postAaveV3Arbitrum_RescueTokensFromAdapters_20240916_GovV2'
    );
  }
  function test_isTokensRescuedV3Previous() external {
    uint256 MAIAdminInitialBalance = IERC20(AaveV3ArbitrumAssets.MAI_UNDERLYING).balanceOf(
      AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR
    );

    uint256 MAITransferred = IERC20(AaveV3ArbitrumAssets.MAI_UNDERLYING).balanceOf(
      proposal.REPAY_WITH_COLLATERAL_ADAPTER_0()
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    assertEq(
      IERC20(AaveV3ArbitrumAssets.MAI_UNDERLYING).balanceOf(
        proposal.REPAY_WITH_COLLATERAL_ADAPTER_0()
      ),
      0,
      'Unexpected MAI_UNDERLYING remaining'
    );
    assertEq(
      MAIAdminInitialBalance + MAITransferred,
      IERC20(AaveV3ArbitrumAssets.MAI_UNDERLYING).balanceOf(
        AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR
      ),
      'Unexpected MAI_UNDERLYING final treasury balance'
    );
  }
}
