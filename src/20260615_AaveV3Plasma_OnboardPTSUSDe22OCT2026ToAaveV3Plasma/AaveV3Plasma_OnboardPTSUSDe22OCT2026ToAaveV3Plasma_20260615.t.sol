// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';
import {GovernanceV3Plasma} from 'aave-address-book/GovernanceV3Plasma.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615} from './AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615.sol';

/**
 * @dev Test for AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260615_AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma/AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615.t.sol -vv
 */
contract AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615_Test is ProtocolV3TestBase {
  AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 24571085);
    proposal = new AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615();

    // since the pt is not tradeable yet, we cannot seed collector as of the writing of this aip.
    // seeding with 1e18 will be done once the pt becomes tradeable, this test mocks the seed fo now
    deal(proposal.PT_sUSDE_22OCT2026(), GovernanceV3Plasma.EXECUTOR_LVL_1, 1e18);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615',
      AaveV3Plasma.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasPT_sUSDE_22OCT2026Funds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Plasma.POOL.getReserveAToken(proposal.PT_sUSDE_22OCT2026());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Plasma.DUST_BIN)), 10 ** 18);
  }
}
