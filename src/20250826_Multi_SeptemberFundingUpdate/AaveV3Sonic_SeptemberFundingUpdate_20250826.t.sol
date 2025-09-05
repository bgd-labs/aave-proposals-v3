// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Sonic, AaveV3SonicAssets} from 'aave-address-book/AaveV3Sonic.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Sonic_SeptemberFundingUpdate_20250826} from './AaveV3Sonic_SeptemberFundingUpdate_20250826.sol';

/**
 * @dev Test for AaveV3Sonic_SeptemberFundingUpdate_20250826
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250826_Multi_SeptemberFundingUpdate/AaveV3Sonic_SeptemberFundingUpdate_20250826.t.sol -vv
 */
contract AaveV3Sonic_SeptemberFundingUpdate_20250826_Test is ProtocolV3TestBase {
  AaveV3Sonic_SeptemberFundingUpdate_20250826 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('sonic'), 44661617);
    proposal = new AaveV3Sonic_SeptemberFundingUpdate_20250826();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Sonic_SeptemberFundingUpdate_20250826', AaveV3Sonic.POOL, address(proposal));
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

    assertEq(
      IERC20(AaveV3SonicAssets.wS_A_TOKEN).allowance(
        address(AaveV3Sonic.COLLECTOR),
        proposal.MASIV_NESTED_SAFE()
      ),
      proposal.WS_AMOUNT()
    );

    vm.startPrank(proposal.MASIV_NESTED_SAFE());
    IERC20(AaveV3SonicAssets.wS_A_TOKEN).transferFrom(
      address(AaveV3Sonic.COLLECTOR),
      proposal.MASIV_NESTED_SAFE(),
      proposal.WS_AMOUNT() / 3 // Not everything is available in the collector at this time
    );
  }
}
