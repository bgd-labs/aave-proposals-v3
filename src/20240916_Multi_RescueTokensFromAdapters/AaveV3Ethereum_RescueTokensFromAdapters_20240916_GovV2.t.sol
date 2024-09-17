// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovHelpers} from 'aave-helpers/src/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_RescueTokensFromAdapters_20240916_GovV2} from './AaveV3Ethereum_RescueTokensFromAdapters_20240916_GovV2.sol';

/**
 * @dev Test for AaveV3Ethereum_RescueTokensFromAdapters_20240916
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240916_Multi_RescueTokensFromAdapters/AaveV3Ethereum_RescueTokensFromAdapters_20240916.t.sol -vv
 */
contract AaveV3Ethereum_RescueTokensFromAdapters_20240916_GovV2_Test is ProtocolV3TestBase {
  AaveV3Ethereum_RescueTokensFromAdapters_20240916_GovV2 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20765423);
    proposal = new AaveV3Ethereum_RescueTokensFromAdapters_20240916_GovV2();
  }

  function testProposalExecution() public {
    createConfigurationSnapshot(
      'preAaveV3Ethereum_RescueTokensFromAdapters_20240916_GovV2',
      AaveV3Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    createConfigurationSnapshot(
      'postAaveV3Ethereum_RescueTokensFromAdapters_20240916_GovV2',
      AaveV3Ethereum.POOL
    );

    diffReports(
      'preAaveV3Ethereum_RescueTokensFromAdapters_20240916_GovV2',
      'postAaveV3Ethereum_RescueTokensFromAdapters_20240916_GovV2'
    );
  }

  function test_isTokensRescuedV3Previous() external {
    uint256 LUSDACLAdminInitialBalance = IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).balanceOf(
      AaveV3Ethereum.ACL_ADMIN
    );

    uint256 LUSDTransferred = IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).balanceOf(
      proposal.REPAY_WITH_COLLATERAL_ADAPTER_0()
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    // AaveV3Ethereum previous
    assertEq(
      IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).balanceOf(
        proposal.REPAY_WITH_COLLATERAL_ADAPTER_0()
      ),
      0,
      'Unexpected LUSD_UNDERLYING remaining'
    );
    assertEq(
      LUSDACLAdminInitialBalance + LUSDTransferred,
      IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).balanceOf(AaveV3Ethereum.ACL_ADMIN),
      'Unexpected LUSD_UNDERLYING final treasury balance'
    );
  }
}
