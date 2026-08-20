// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_July2026FundingUpdate_20260715} from './AaveV3Base_July2026FundingUpdate_20260715.sol';

/**
 * @dev Test for AaveV3Base_July2026FundingUpdate_20260715
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260715_Multi_July2026FundingUpdate/AaveV3Base_July2026FundingUpdate_20260715.t.sol -vv
 */
contract AaveV3Base_July2026FundingUpdate_20260715_Test is ProtocolV3TestBase {
  AaveV3Base_July2026FundingUpdate_20260715 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 48665378);
    proposal = new AaveV3Base_July2026FundingUpdate_20260715();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_July2026FundingUpdate_20260715', AaveV3Base.POOL, address(proposal));
  }

  /**
   * @dev checks whether reserve configurations changed or stayed unchanged as expected
   */
  function test_reserveConfigChanges() public {
    address[] memory updatedAssets = new address[](0);

    reserveConfigChangesTest(AaveV3Base.POOL, address(proposal), updatedAssets);
  }

  function test_depositETH() public {
    uint256 collectorEthBalanceBefore = address(AaveV3Base.COLLECTOR).balance;
    assertGt(collectorEthBalanceBefore, 0, 'collector should hold ETH to deposit');

    uint256 aWethBalanceBefore = IERC20(AaveV3BaseAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Base.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    // All of the collector's ETH has been wrapped and deposited.
    assertEq(address(AaveV3Base.COLLECTOR).balance, 0);
    uint256 aWethBalanceAfter = IERC20(AaveV3BaseAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Base.COLLECTOR)
    );

    // aTokens are minted ~1:1 with the deposited underlying.
    assertApproxEqAbs(
      aWethBalanceAfter,
      aWethBalanceBefore + collectorEthBalanceBefore,
      1,
      'aWETH not minted for the deposited ETH'
    );
  }
}
