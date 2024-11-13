// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {GovernanceV3Optimism} from 'aave-address-book/GovernanceV3Optimism.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Optimism_SeptemberFundingUpdatePartA_20241113} from './AaveV3Optimism_SeptemberFundingUpdatePartA_20241113.sol';

/**
 * @dev Test for AaveV3Optimism_SeptemberFundingUpdatePartA_20241113
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20241113_Multi_SeptemberFundingUpdatePartA/AaveV3Optimism_SeptemberFundingUpdatePartA_20241113.t.sol -vv
 */
contract AaveV3Optimism_SeptemberFundingUpdatePartA_20241113_Test is ProtocolV3TestBase {
  event Bridge(address indexed token, uint256 amount);

  AaveV3Optimism_SeptemberFundingUpdatePartA_20241113 internal proposal;

  address internal COLLECTOR = address(AaveV3Optimism.COLLECTOR);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 127952448);
    proposal = new AaveV3Optimism_SeptemberFundingUpdatePartA_20241113();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_SeptemberFundingUpdatePartA_20241113',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }

  function test_bridgeUSDC() public {
    uint256 collectorUsdcBalanceBefore = IERC20(AaveV3OptimismAssets.USDC_UNDERLYING).balanceOf(
      COLLECTOR
    );
    uint256 collectorAusdcBalanceBefore = IERC20(AaveV3OptimismAssets.USDC_A_TOKEN).balanceOf(
      COLLECTOR
    );

    vm.expectEmit(address(proposal.BRIDGE()));
    emit Bridge(
      AaveV3OptimismAssets.USDC_UNDERLYING,
      collectorUsdcBalanceBefore + collectorAusdcBalanceBefore - 1
    );
    executePayload(vm, address(proposal));

    uint256 collectorUsdcBalanceAfter = IERC20(AaveV3OptimismAssets.USDC_UNDERLYING).balanceOf(
      COLLECTOR
    );
    uint256 collectorAusdcBalanceAfter = IERC20(AaveV3OptimismAssets.USDC_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertEq(collectorUsdcBalanceAfter, 0);
    assertEq(collectorAusdcBalanceAfter, 1);
  }

  function test_bridgeLUSD() public {
    uint256 collectorLusdBalanceBefore = IERC20(AaveV3OptimismAssets.LUSD_UNDERLYING).balanceOf(
      COLLECTOR
    );
    uint256 collectorAlusdBalanceBefore = IERC20(AaveV3OptimismAssets.LUSD_A_TOKEN).balanceOf(
      COLLECTOR
    );

    vm.expectEmit(address(proposal.BRIDGE()));
    emit Bridge(
      AaveV3OptimismAssets.LUSD_UNDERLYING,
      collectorLusdBalanceBefore + collectorAlusdBalanceBefore - 1
    );
    executePayload(vm, address(proposal));

    uint256 collectorLusdBalanceAfter = IERC20(AaveV3OptimismAssets.LUSD_UNDERLYING).balanceOf(
      COLLECTOR
    );
    uint256 collectorAlusdBalanceAfter = IERC20(AaveV3OptimismAssets.LUSD_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertEq(collectorLusdBalanceAfter, 0);
    assertEq(collectorAlusdBalanceAfter, 1);
  }
}
