// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {ArbSysMock} from 'aave-helpers/tests/bridges/arbitrum/ArbSysMock.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_FebruaryFundingUpdatePartB_20250207} from './AaveV3Arbitrum_FebruaryFundingUpdatePartB_20250207.sol';

/**
 * @dev Test for AaveV3Arbitrum_FebruaryFundingUpdatePartB_20250207
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Arbitrum_FebruaryFundingUpdatePartB_20250207.t.sol -vv
 */
contract AaveV3Arbitrum_FebruaryFundingUpdatePartB_20250207_Test is ProtocolV3TestBase {
  event Bridge(address indexed token, uint256 amount);

  AaveV3Arbitrum_FebruaryFundingUpdatePartB_20250207 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 303584931);
    proposal = new AaveV3Arbitrum_FebruaryFundingUpdatePartB_20250207();

    ArbSysMock arbsys = new ArbSysMock();
    vm.etch(address(0x0000000000000000000000000000000000000064), address(arbsys).code);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_FebruaryFundingUpdatePartB_20250207',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_bridge() public {
    uint256 lusdCollectorBalanceBefore = IERC20(AaveV3ArbitrumAssets.LUSD_A_TOKEN).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    uint256 usdcCollectorBalanceBefore = IERC20(AaveV3ArbitrumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );

    vm.expectEmit(true, false, false, true, MiscArbitrum.AAVE_ARB_ETH_BRIDGE);
    emit Bridge(AaveV3ArbitrumAssets.LUSD_UNDERLYING, 2035313183835239532887); // dynamically get bridge
    vm.expectEmit(true, false, false, true, MiscArbitrum.AAVE_ARB_ETH_BRIDGE);
    emit Bridge(AaveV3ArbitrumAssets.USDC_UNDERLYING, 49304678615); // dynamically get bridge balance
    executePayload(vm, address(proposal));

    uint256 lusdCollectorBalanceAfter = IERC20(AaveV3ArbitrumAssets.LUSD_A_TOKEN).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    uint256 usdcCollectorBalanceAfter = IERC20(AaveV3ArbitrumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );

    assertGt(lusdCollectorBalanceBefore, 1 ether);
    assertApproxEqAbs(lusdCollectorBalanceAfter, 1 ether, 100);
    assertGt(usdcCollectorBalanceBefore, 1e6);
    assertApproxEqAbs(usdcCollectorBalanceAfter, 1e6, 100);
  }
}
