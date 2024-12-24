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
    uint256 collectorAUsdcBalanceBefore = IERC20(AaveV3OptimismAssets.USDC_A_TOKEN).balanceOf(
      COLLECTOR
    );

    vm.expectEmit(true, false, false, true, address(proposal.BRIDGE()));
    emit Bridge(AaveV3OptimismAssets.USDC_UNDERLYING, collectorAUsdcBalanceBefore - 100e6);
    executePayload(vm, address(proposal));

    uint256 collectorAUsdcBalanceAfter = IERC20(AaveV3OptimismAssets.USDC_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertApproxEqAbs(collectorAUsdcBalanceAfter, 1e6, 4_500e6);
  }

  function test_bridgeLUSD() public {
    uint256 collectorALusdBalanceBefore = IERC20(AaveV3OptimismAssets.LUSD_A_TOKEN).balanceOf(
      COLLECTOR
    );

    vm.expectEmit(true, false, false, true, address(proposal.BRIDGE()));
    emit Bridge(AaveV3OptimismAssets.LUSD_UNDERLYING, collectorALusdBalanceBefore - 1e18 - 1);
    executePayload(vm, address(proposal));

    uint256 collectorALusdBalanceAfter = IERC20(AaveV3OptimismAssets.LUSD_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertApproxEqAbs(collectorALusdBalanceAfter, 1e18, 300e18);
  }
}
