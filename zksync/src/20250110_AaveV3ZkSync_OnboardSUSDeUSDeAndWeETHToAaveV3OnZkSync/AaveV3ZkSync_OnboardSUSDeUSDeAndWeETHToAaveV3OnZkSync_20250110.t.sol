// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_OnboardSUSDeUSDeAndWeETHToAaveV3OnZkSync_20250110} from './AaveV3ZkSync_OnboardSUSDeUSDeAndWeETHToAaveV3OnZkSync_20250110.sol';

/**
 * @dev Test for AaveV3ZkSync_OnboardSUSDeUSDeAndWeETHToAaveV3OnZkSync_20250110
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20250110_AaveV3ZkSync_OnboardSUSDeUSDeAndWeETHToAaveV3OnZkSync/AaveV3ZkSync_OnboardSUSDeUSDeAndWeETHToAaveV3OnZkSync_20250110.t.sol -vv
 */
contract AaveV3ZkSync_OnboardSUSDeUSDeAndWeETHToAaveV3OnZkSync_20250110_Test is ProtocolV3TestBase {
  AaveV3ZkSync_OnboardSUSDeUSDeAndWeETHToAaveV3OnZkSync_20250110 internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 53365321);
    proposal = new AaveV3ZkSync_OnboardSUSDeUSDeAndWeETHToAaveV3OnZkSync_20250110();

    super.setUp();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_OnboardSUSDeUSDeAndWeETHToAaveV3OnZkSync_20250110',
      AaveV3ZkSync.POOL,
      address(proposal)
    );
  }

  function test_collectorHasweETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3ZkSync
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.weETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)), 25 * 10 ** 15);
  }

  function test_weETHAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aweETH, , ) = AaveV3ZkSync.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.weETH()
    );
    assertEq(
      IEmissionManager(AaveV3ZkSync.EMISSION_MANAGER).getEmissionAdmin(proposal.weETH()),
      proposal.weETH_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3ZkSync.EMISSION_MANAGER).getEmissionAdmin(aweETH),
      proposal.weETH_LM_ADMIN()
    );
  }

  function test_collectorHassUSDeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3ZkSync
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.sUSDe());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3ZkSync.COLLECTOR)), 100 * 10 ** 18);
  }

  function test_sUSDeAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address asUSDe, , ) = AaveV3ZkSync.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.sUSDe()
    );
    assertEq(
      IEmissionManager(AaveV3ZkSync.EMISSION_MANAGER).getEmissionAdmin(proposal.sUSDe()),
      proposal.sUSDe_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3ZkSync.EMISSION_MANAGER).getEmissionAdmin(asUSDe),
      proposal.sUSDe_LM_ADMIN()
    );
  }
}
