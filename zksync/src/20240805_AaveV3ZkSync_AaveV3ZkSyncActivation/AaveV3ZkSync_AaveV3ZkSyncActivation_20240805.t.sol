// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ProtocolV3TestBase} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_AaveV3ZkSyncActivation_20240805} from './AaveV3ZkSync_AaveV3ZkSyncActivation_20240805.sol';
import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';
import {MiscZkSync} from 'aave-address-book/MiscZkSync.sol';
import {GovernanceV3ZkSync} from 'aave-address-book/GovernanceV3ZkSync.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IOwnable} from 'aave-address-book/common/IOwnable.sol';

/**
 * @dev Test for AaveV3ZkSync_AaveV3ZkSyncActivation_20240805
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20240805_AaveV3ZkSync_AaveV3ZkSyncActivation/AaveV3ZkSync_AaveV3ZkSyncActivation_20240805.t.sol -vv
 */
contract AaveV3ZkSync_AaveV3ZkSyncActivation_20240805_Test is ProtocolV3TestBase {
  AaveV3ZkSync_AaveV3ZkSyncActivation_20240805 internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 40933332);
    proposal = new AaveV3ZkSync_AaveV3ZkSyncActivation_20240805();

    // TODO: remove seeding after funding
    _seedAmountToExecutor();
    super.setUp();
  }

  /**
   * @dev executes the generic test suite including e2e
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_AaveV3ZkSyncActivation_20240805',
      AaveV3ZkSync.POOL,
      address(proposal)
    );
  }

  function test_permissions() public {
    assertFalse(AaveV3ZkSync.ACL_MANAGER.isPoolAdmin(MiscZkSync.PROTOCOL_GUARDIAN));
    executePayload(vm, address(proposal));

    assertTrue(AaveV3ZkSync.ACL_MANAGER.isPoolAdmin(MiscZkSync.PROTOCOL_GUARDIAN));
  }

  function test_collectorHasUSDCFunds() public {
    executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3ZkSync
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.USDC());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)),
      proposal.USDC_SEED_AMOUNT()
    );
  }

  function test_collectorHasUSDTFunds() public {
    executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3ZkSync
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.USDT());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)),
      proposal.USDT_SEED_AMOUNT()
    );
  }

  function test_collectorHasWETHFunds() public {
    executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3ZkSync
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.WETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)),
      proposal.WETH_SEED_AMOUNT()
    );
  }

  function test_collectorHaswstETHFunds() public {
    executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3ZkSync
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.wstETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)),
      proposal.wstETH_SEED_AMOUNT()
    );
  }

  function test_collectorHasZKFunds() public {
    executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3ZkSync
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.ZK());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)),
      proposal.ZK_SEED_AMOUNT()
    );
  }

  function _seedAmountToExecutor() internal {
    deal(proposal.USDC(), GovernanceV3ZkSync.EXECUTOR_LVL_1, proposal.USDC_SEED_AMOUNT());
    deal(proposal.USDT(), GovernanceV3ZkSync.EXECUTOR_LVL_1, proposal.USDT_SEED_AMOUNT());
    deal(proposal.WETH(), GovernanceV3ZkSync.EXECUTOR_LVL_1, proposal.WETH_SEED_AMOUNT());
    deal(proposal.wstETH(), GovernanceV3ZkSync.EXECUTOR_LVL_1, proposal.wstETH_SEED_AMOUNT());
    deal(proposal.ZK(), GovernanceV3ZkSync.EXECUTOR_LVL_1, proposal.ZK_SEED_AMOUNT());

    // transfer executor ownership to payloads controller
    vm.startPrank(0x6ec33534BE07d45cc4E02Fbd127F8ed2aE919a6b);
    IOwnable(0x04cE39789e11a49595cD0ECEf6f4Bd54ABF4d020).transferOwnership(
      0x2E79349c3F5e4751E87b966812C9E65E805996F1
    );
    vm.stopPrank();
  }
}
