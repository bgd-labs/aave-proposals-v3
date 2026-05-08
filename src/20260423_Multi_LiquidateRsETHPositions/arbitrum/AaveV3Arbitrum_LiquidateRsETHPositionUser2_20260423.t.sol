// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LiquidateRsETHPositionsSetup} from '../setup/LiquidateRsETHPositionsSetup.sol';
import {LiquidateRsETHArbitrumSetupTest, LiquidateRsETHConstants} from './LiquidateRsETHArbitrumSetupTest.t.sol';
import {AaveV3Arbitrum_LiquidateRsETHPositionUser2_20260423} from './AaveV3Arbitrum_LiquidateRsETHPositionUser2_20260423.sol';

/**
 * @dev Test for AaveV3Arbitrum_LiquidateRsETHPositionUser2_20260423
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260423_Multi_LiquidateRsETHPositions/arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser2_20260423.t.sol -vv
 */
contract AaveV3Arbitrum_LiquidateRsETHPositionUser2_20260423_Test is
  LiquidateRsETHArbitrumSetupTest
{
  function _newProposal() internal override returns (LiquidateRsETHPositionsSetup) {
    return new AaveV3Arbitrum_LiquidateRsETHPositionUser2_20260423();
  }

  function test_defaultProposalExecution() public {
    defaultTest({
      reportName: 'AaveV3Arbitrum_LiquidateRsETHPositionUser2_20260423',
      pool: _pool(),
      payload: address(proposal),
      runE2E: true,
      runSeatbelt: true
    });
  }

  function test_user_matchesHardcodedAddress() public view {
    AaveV3Arbitrum_LiquidateRsETHPositionUser2_20260423 p = AaveV3Arbitrum_LiquidateRsETHPositionUser2_20260423(
        address(proposal)
      );
    assertEq(p.getUser(), 0xE9E2F48Bb0018276391AEc240AbB46e8C3caD181);
    assertEq(p.getUser(), LiquidateRsETHConstants.ARB_USER_2);
  }
}
