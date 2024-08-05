// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_AaveV3ZkSyncActivation_20240805} from './AaveV3ZkSync_AaveV3ZkSyncActivation_20240805.sol';

/**
 * @dev Test for AaveV3ZkSync_AaveV3ZkSyncActivation_20240805
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20240805_AaveV3ZkSync_AaveV3ZkSyncActivation/AaveV3ZkSync_AaveV3ZkSyncActivation_20240805.t.sol -vv
 */
contract AaveV3ZkSync_AaveV3ZkSyncActivation_20240805_Test is ProtocolV3TestBase {
  AaveV3ZkSync_AaveV3ZkSyncActivation_20240805 internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 40901979);
    proposal = new AaveV3ZkSync_AaveV3ZkSyncActivation_20240805();

    super.setUp();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_AaveV3ZkSyncActivation_20240805',
      AaveV3ZkSync.POOL,
      address(proposal)
    );
  }

  function test_collectorHasUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3ZkSync
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.USDC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)), 10 ** 6);
  }

  function test_collectorHasUSDTFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3ZkSync
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.USDT());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)), 10 ** 6);
  }

  function test_collectorHasWETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3ZkSync
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.WETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)), 10 ** 18);
  }

  function test_collectorHaswstETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3ZkSync
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.wstETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)), 10 ** 18);
  }

  function test_collectorHasZKFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3ZkSync
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.ZK());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)), 10 ** 18);
  }
}
