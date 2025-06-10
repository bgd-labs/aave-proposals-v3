// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance_20250408} from './AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance_20250408.sol';

/**
 * @dev Test for AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance_20250408
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20250408_AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance/AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance_20250408.t.sol -vv
 */
contract AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance_20250408_Test is ProtocolV3TestBase {
  AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance_20250408 internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 58835283);
    proposal = new AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance_20250408();

    super.setUp();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance_20250408',
      AaveV3ZkSync.POOL,
      address(proposal)
    );
  }

  function test_dustBinHaswrsETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3ZkSync.POOL.getReserveAToken(proposal.wrsETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3ZkSync.DUST_BIN)), 35 * 10 ** 15);
  }

  function test_wrsETHAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address awrsETH = AaveV3ZkSync.POOL.getReserveAToken(proposal.wrsETH());
    assertEq(
      IEmissionManager(AaveV3ZkSync.EMISSION_MANAGER).getEmissionAdmin(proposal.wrsETH()),
      proposal.wrsETH_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3ZkSync.EMISSION_MANAGER).getEmissionAdmin(awrsETH),
      proposal.wrsETH_LM_ADMIN()
    );
  }
}
