// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {MiscPlasma} from 'aave-address-book/MiscPlasma.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Plasma_AprilFundingUpdate_20260423} from './AaveV3Plasma_AprilFundingUpdate_20260423.sol';

/**
 * @dev Test for AaveV3Plasma_AprilFundingUpdate_20260423
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260423_Multi_AprilFundingUpdate/AaveV3Plasma_AprilFundingUpdate_20260423.t.sol -vv
 */
contract AaveV3Plasma_AprilFundingUpdate_20260423_Test is ProtocolV3TestBase {
  AaveV3Plasma_AprilFundingUpdate_20260423 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 20041232);
    proposal = new AaveV3Plasma_AprilFundingUpdate_20260423();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Plasma_AprilFundingUpdate_20260423', AaveV3Plasma.POOL, address(proposal));
  }

  function test_approvals_weth() public {
    uint256 allowanceBefore = IERC20(AaveV3PlasmaAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Plasma.COLLECTOR),
      proposal.AFC_SAFE()
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3PlasmaAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Plasma.COLLECTOR),
      proposal.AFC_SAFE()
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.WETH_ALLOWANCE());
  }
}
