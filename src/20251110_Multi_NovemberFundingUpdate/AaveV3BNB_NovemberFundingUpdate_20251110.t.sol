// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3BNB, AaveV3BNBAssets} from 'aave-address-book/AaveV3BNB.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3BNB_NovemberFundingUpdate_20251110} from './AaveV3BNB_NovemberFundingUpdate_20251110.sol';

/**
 * @dev Test for AaveV3BNB_NovemberFundingUpdate_20251110
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251110_Multi_NovemberFundingUpdate/AaveV3BNB_NovemberFundingUpdate_20251110.t.sol -vv
 */
contract AaveV3BNB_NovemberFundingUpdate_20251110_Test is ProtocolV3TestBase {
  AaveV3BNB_NovemberFundingUpdate_20251110 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 67730544);
    proposal = new AaveV3BNB_NovemberFundingUpdate_20251110();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3BNB_NovemberFundingUpdate_20251110', AaveV3BNB.POOL, address(proposal));
  }

  function test_approvals() public {
    assertEq(
      IERC20(AaveV3BNBAssets.USDC_UNDERLYING).allowance(
        address(AaveV3BNB.COLLECTOR),
        MiscBNB.AFC_SAFE
      ),
      0
    );

    assertEq(
      IERC20(AaveV3BNBAssets.USDT_UNDERLYING).allowance(
        address(AaveV3BNB.COLLECTOR),
        MiscBNB.AFC_SAFE
      ),
      0
    );

    assertEq(
      IERC20(AaveV3BNBAssets.ETH_UNDERLYING).allowance(
        address(AaveV3BNB.COLLECTOR),
        MiscBNB.AFC_SAFE
      ),
      0
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3BNBAssets.USDC_UNDERLYING).allowance(
        address(AaveV3BNB.COLLECTOR),
        MiscBNB.AFC_SAFE
      ),
      proposal.USDC_AMOUNT()
    );

    assertEq(
      IERC20(AaveV3BNBAssets.USDT_UNDERLYING).allowance(
        address(AaveV3BNB.COLLECTOR),
        MiscBNB.AFC_SAFE
      ),
      proposal.USDT_AMOUNT()
    );

    assertEq(
      IERC20(AaveV3BNBAssets.ETH_UNDERLYING).allowance(
        address(AaveV3BNB.COLLECTOR),
        MiscBNB.AFC_SAFE
      ),
      proposal.ETH_AMOUNT()
    );

    vm.startPrank(MiscBNB.AFC_SAFE);
    IERC20(AaveV3BNBAssets.USDC_UNDERLYING).transferFrom(
      address(AaveV3BNB.COLLECTOR),
      MiscBNB.AFC_SAFE,
      proposal.USDC_AMOUNT()
    );

    IERC20(AaveV3BNBAssets.USDT_UNDERLYING).transferFrom(
      address(AaveV3BNB.COLLECTOR),
      MiscBNB.AFC_SAFE,
      proposal.USDT_AMOUNT()
    );

    IERC20(AaveV3BNBAssets.ETH_UNDERLYING).transferFrom(
      address(AaveV3BNB.COLLECTOR),
      MiscBNB.AFC_SAFE,
      proposal.ETH_AMOUNT()
    );
    vm.stopPrank();
  }
}
