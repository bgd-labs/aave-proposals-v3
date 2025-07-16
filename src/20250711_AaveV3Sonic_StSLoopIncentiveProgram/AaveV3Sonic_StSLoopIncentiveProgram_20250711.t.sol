// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Sonic, AaveV3SonicAssets} from 'aave-address-book/AaveV3Sonic.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Sonic_StSLoopIncentiveProgram_20250711} from './AaveV3Sonic_StSLoopIncentiveProgram_20250711.sol';

/**
 * @dev Test for AaveV3Sonic_StSLoopIncentiveProgram_20250711
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250711_AaveV3Sonic_StSLoopIncentiveProgram/AaveV3Sonic_StSLoopIncentiveProgram_20250711.t.sol -vv
 */
contract AaveV3Sonic_StSLoopIncentiveProgram_20250711_Test is ProtocolV3TestBase {
  AaveV3Sonic_StSLoopIncentiveProgram_20250711 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('sonic'), 38053079);
    proposal = new AaveV3Sonic_StSLoopIncentiveProgram_20250711();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Sonic_StSLoopIncentiveProgram_20250711',
      AaveV3Sonic.POOL,
      address(proposal)
    );
  }

  function test_approvals() public {
    assertEq(
      IERC20(AaveV3SonicAssets.wS_A_TOKEN).allowance(
        address(AaveV3Sonic.COLLECTOR),
        proposal.MASIV_NESTED_SAFE()
      ),
      0
    );

    executePayload(vm, address(proposal));

    uint256 allowanceWsATokenAfter = IERC20(AaveV3SonicAssets.wS_A_TOKEN).allowance(
      address(AaveV3Sonic.COLLECTOR),
      proposal.MASIV_NESTED_SAFE()
    );

    assertEq(allowanceWsATokenAfter, proposal.INCENTIVES_AMOUNT());

    vm.startPrank(proposal.MASIV_NESTED_SAFE());
    IERC20(AaveV3SonicAssets.wS_A_TOKEN).transferFrom(
      address(AaveV3Sonic.COLLECTOR),
      proposal.MASIV_NESTED_SAFE(),
      proposal.INCENTIVES_AMOUNT()
    );
    vm.stopPrank();
  }
}
