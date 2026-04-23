// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_AprilFundingUpdate_20260423} from './AaveV3Arbitrum_AprilFundingUpdate_20260423.sol';

/**
 * @dev Test for AaveV3Arbitrum_AprilFundingUpdate_20260423
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260423_Multi_AprilFundingUpdate/AaveV3Arbitrum_AprilFundingUpdate_20260423.t.sol -vv
 */
contract AaveV3Arbitrum_AprilFundingUpdate_20260423_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_AprilFundingUpdate_20260423 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 455608521);
    proposal = new AaveV3Arbitrum_AprilFundingUpdate_20260423();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_AprilFundingUpdate_20260423',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_approvals_weth() public {
    uint256 allowanceBefore = IERC20(AaveV3ArbitrumAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Arbitrum.COLLECTOR),
      MiscArbitrum.AFC_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3ArbitrumAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Arbitrum.COLLECTOR),
      MiscArbitrum.AFC_SAFE
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.WETH_ALLOWANCE());
  }

  function test_approvals_weeth() public {
    uint256 allowanceBefore = IERC20(AaveV3ArbitrumAssets.weETH_A_TOKEN).allowance(
      address(AaveV3Arbitrum.COLLECTOR),
      MiscArbitrum.AFC_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3ArbitrumAssets.weETH_A_TOKEN).allowance(
      address(AaveV3Arbitrum.COLLECTOR),
      MiscArbitrum.AFC_SAFE
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.weETH_ALLOWANCE());
  }
}
