// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LiquidateRsETHPositionsSetup} from '../setup/LiquidateRsETHPositionsSetup.sol';
import {LiquidateRsETHEthereumSetupTest, LiquidateRsETHConstants} from './LiquidateRsETHEthereumSetupTest.t.sol';
import {AaveV3Ethereum_LiquidateRsETHPositionUser2_20260423} from './AaveV3Ethereum_LiquidateRsETHPositionUser2_20260423.sol';

/**
 * @dev Test for AaveV3Ethereum_LiquidateRsETHPositionUser2_20260423.
 * USER_2 inherits the WETH-offset-increase and slashing-headroom assertions from
 * `LiquidateRsETHEthereumSetupTest`, which run for every Eth payload.
 *
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260423_Multi_LiquidateRsETHPositions/mainnet/AaveV3Ethereum_LiquidateRsETHPositionUser2_20260423.t.sol -vv
 */
contract AaveV3Ethereum_LiquidateRsETHPositionUser2_20260423_Test is
  LiquidateRsETHEthereumSetupTest
{
  function _newProposal() internal override returns (LiquidateRsETHPositionsSetup) {
    return new AaveV3Ethereum_LiquidateRsETHPositionUser2_20260423();
  }

  function test_defaultProposalExecution() public {
    defaultTest({
      reportName: 'AaveV3Ethereum_LiquidateRsETHPositionUser2_20260423',
      pool: _pool(),
      payload: address(proposal),
      runE2E: true,
      runSeatbelt: true
    });
  }

  function test_user_matchesHardcodedAddress() public view {
    AaveV3Ethereum_LiquidateRsETHPositionUser2_20260423 p = AaveV3Ethereum_LiquidateRsETHPositionUser2_20260423(
        address(proposal)
      );
    assertEq(p.getUser(), 0x8d11AeAC74267DD5C56D371bf4AE1AFA174C2d49);
    assertEq(p.getUser(), LiquidateRsETHConstants.ETH_USER_2);
  }
}
