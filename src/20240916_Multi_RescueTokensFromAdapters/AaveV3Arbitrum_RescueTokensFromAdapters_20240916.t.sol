// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_RescueTokensFromAdapters_20240916} from './AaveV3Arbitrum_RescueTokensFromAdapters_20240916.sol';

/**
 * @dev Test for AaveV3Arbitrum_RescueTokensFromAdapters_20240916
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240916_Multi_RescueTokensFromAdapters/AaveV3Arbitrum_RescueTokensFromAdapters_20240916.t.sol -vv
 */
contract AaveV3Arbitrum_RescueTokensFromAdapters_20240916_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_RescueTokensFromAdapters_20240916 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 252760729);
    proposal = new AaveV3Arbitrum_RescueTokensFromAdapters_20240916();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_RescueTokensFromAdapters_20240916',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }
  function test_isTokensRescuedV3Previous() external {
    uint256 weETHACLAdminInitialBalance = IERC20(AaveV3ArbitrumAssets.weETH_UNDERLYING).balanceOf(
      AaveV3Arbitrum.ACL_ADMIN
    );

    uint256 weETHTransferred = IERC20(AaveV3ArbitrumAssets.weETH_UNDERLYING).balanceOf(
      proposal.ADAPTER_0()
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3ArbitrumAssets.weETH_UNDERLYING).balanceOf(proposal.ADAPTER_0()),
      0,
      'Unexpected weETH_UNDERLYING remaining'
    );
    assertEq(
      weETHACLAdminInitialBalance + weETHTransferred,
      IERC20(AaveV3ArbitrumAssets.weETH_UNDERLYING).balanceOf(AaveV3Arbitrum.ACL_ADMIN),
      'Unexpected weETH_UNDERLYING final treasury balance'
    );
  }
}
