// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LiquidateRsETHPositionsSetup} from '../setup/LiquidateRsETHPositionsSetup.sol';
import {LiquidateRsETHEthereumSetupTest, LiquidateRsETHConstants} from './LiquidateRsETHEthereumSetupTest.t.sol';
import {AaveV3Ethereum_LiquidateRsETHPositionUser1_20260423} from './AaveV3Ethereum_LiquidateRsETHPositionUser1_20260423.sol';

/**
 * @dev Test for AaveV3Ethereum_LiquidateRsETHPositionUser1_20260423
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260423_Multi_LiquidateRsETHPositions/mainnet/AaveV3Ethereum_LiquidateRsETHPositionUser1_20260423.t.sol -vv
 */
contract AaveV3Ethereum_LiquidateRsETHPositionUser1_20260423_Test is
  LiquidateRsETHEthereumSetupTest
{
  function _newProposal() internal override returns (LiquidateRsETHPositionsSetup) {
    return new AaveV3Ethereum_LiquidateRsETHPositionUser1_20260423();
  }

  function test_defaultProposalExecution() public {
    defaultTest({
      reportName: 'AaveV3Ethereum_LiquidateRsETHPositionUser1_20260423',
      pool: _pool(),
      payload: address(proposal),
      runE2E: true,
      runSeatbelt: true
    });
  }

  function test_user_matchesHardcodedAddress() public view {
    AaveV3Ethereum_LiquidateRsETHPositionUser1_20260423 p = AaveV3Ethereum_LiquidateRsETHPositionUser1_20260423(
        address(proposal)
      );
    assertEq(p.getUser(), 0x1F4C1c2e610f089D6914c4448E6F21Cb0db3adeF);
    assertEq(p.getUser(), LiquidateRsETHConstants.ETH_USER_1);
  }
}
