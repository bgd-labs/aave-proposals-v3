// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Optimism_FebruaryFundingUpdate_20250120} from './AaveV3Optimism_FebruaryFundingUpdate_20250120.sol';

/**
 * @dev Test for AaveV3Optimism_FebruaryFundingUpdate_20250120
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20250120_Multi_FebruaryFundingUpdate/AaveV3Optimism_FebruaryFundingUpdate_20250120.t.sol -vv
 */
contract AaveV3Optimism_FebruaryFundingUpdate_20250120_Test is ProtocolV3TestBase {
  AaveV3Optimism_FebruaryFundingUpdate_20250120 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 131030310);
    proposal = new AaveV3Optimism_FebruaryFundingUpdate_20250120();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_FebruaryFundingUpdate_20250120',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }

  function test_deposits() public {
    uint256 balanceAUSDCBefore = IERC20(AaveV3OptimismAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );
    uint256 balanceAUSDTBefore = IERC20(AaveV3OptimismAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );
    uint256 balanceAWETHBefore = IERC20(AaveV3OptimismAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    assertGt(balanceAUSDCBefore, 0);
    assertGt(balanceAUSDTBefore, 0);
    assertGt(balanceAWETHBefore, 0);

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3OptimismAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Optimism.COLLECTOR)),
      0
    );
    assertEq(
      IERC20(AaveV3OptimismAssets.USDT_UNDERLYING).balanceOf(address(AaveV3Optimism.COLLECTOR)),
      0
    );
    assertEq(
      IERC20(AaveV3OptimismAssets.WETH_UNDERLYING).balanceOf(address(AaveV3Optimism.COLLECTOR)),
      0
    );

    assertGt(
      IERC20(AaveV3OptimismAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Optimism.COLLECTOR)),
      balanceAUSDCBefore
    );
    assertGt(
      IERC20(AaveV3OptimismAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Optimism.COLLECTOR)),
      balanceAUSDTBefore
    );
    assertGt(
      IERC20(AaveV3OptimismAssets.WETH_A_TOKEN).balanceOf(address(AaveV3Optimism.COLLECTOR)),
      balanceAWETHBefore
    );
  }
}
