// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {LiquidateRsETHPositionsSetup} from '../setup/LiquidateRsETHPositionsSetup.sol';
import {LiquidateRsETHArbitrumSetupTest, LiquidateRsETHConstants} from './LiquidateRsETHArbitrumSetupTest.t.sol';
import {AaveV3Arbitrum_LiquidateRsETHPositionUser5_20260423} from './AaveV3Arbitrum_LiquidateRsETHPositionUser5_20260423.sol';

/**
 * @dev Test for AaveV3Arbitrum_LiquidateRsETHPositionUser5_20260423
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260423_Multi_LiquidateRsETHPositions/arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser5_20260423.t.sol -vv
 */
contract AaveV3Arbitrum_LiquidateRsETHPositionUser5_20260423_Test is
  LiquidateRsETHArbitrumSetupTest
{
  function _newProposal() internal override returns (LiquidateRsETHPositionsSetup) {
    return new AaveV3Arbitrum_LiquidateRsETHPositionUser5_20260423();
  }

  function test_defaultProposalExecution() public {
    defaultTest({
      reportName: 'AaveV3Arbitrum_LiquidateRsETHPositionUser5_20260423',
      pool: _pool(),
      payload: address(proposal),
      runE2E: true,
      runSeatbelt: true
    });
  }

  function test_user_matchesHardcodedAddress() public view {
    AaveV3Arbitrum_LiquidateRsETHPositionUser5_20260423 p = AaveV3Arbitrum_LiquidateRsETHPositionUser5_20260423(
        address(proposal)
      );
    assertEq(p.getUser(), 0xCBb24A6B4DAfaAA1a759A2F413eA0eB6AE1455CC);
    assertEq(p.getUser(), LiquidateRsETHConstants.ARB_USER_5);
  }

  function test_userHasWstEthDebt() public view {
    assertGt(IERC20(_vDebtTokenOf(_wsteth())).balanceOf(user), 0, 'user has no wstETH debt');
  }

  function test_userDebtAssets() public view override {
    address[] memory debts = _allDebtAssets();
    assertEq(debts.length, 2, 'user has unexpected number of debt assets');
    for (uint256 i; i < debts.length; ++i) {
      assertTrue(debts[i] == _weth() || debts[i] == _wsteth(), 'user has unexpected debt asset');
    }
  }
}
