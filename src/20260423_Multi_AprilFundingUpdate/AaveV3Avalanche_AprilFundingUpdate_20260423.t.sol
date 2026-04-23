// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_AprilFundingUpdate_20260423} from './AaveV3Avalanche_AprilFundingUpdate_20260423.sol';

/**
 * @dev Test for AaveV3Avalanche_AprilFundingUpdate_20260423
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260423_Multi_AprilFundingUpdate/AaveV3Avalanche_AprilFundingUpdate_20260423.t.sol -vv
 */
contract AaveV3Avalanche_AprilFundingUpdate_20260423_Test is ProtocolV3TestBase {
  AaveV3Avalanche_AprilFundingUpdate_20260423 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 83705636);
    proposal = new AaveV3Avalanche_AprilFundingUpdate_20260423();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_AprilFundingUpdate_20260423',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_approvals_usdtV3() public {
    uint256 allowanceBefore = IERC20(AaveV3AvalancheAssets.USDt_A_TOKEN).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3AvalancheAssets.USDt_A_TOKEN).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.USDT_V3_ALLOWANCE());
  }

  function test_approvals_usdtV2() public {
    uint256 allowanceBefore = IERC20(AaveV2AvalancheAssets.USDTe_A_TOKEN).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV2AvalancheAssets.USDTe_A_TOKEN).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.USDT_V2_ALLOWANCE());
  }

  function test_approvals_usdcV3() public {
    uint256 allowanceBefore = IERC20(AaveV3AvalancheAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3AvalancheAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.USDC_V3_ALLOWANCE());
  }

  function test_approvals_usdcV2() public {
    uint256 allowanceBefore = IERC20(AaveV2AvalancheAssets.USDCe_A_TOKEN).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV2AvalancheAssets.USDCe_A_TOKEN).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.USDC_V2_ALLOWANCE());
  }

  function test_approvals_dai() public {
    uint256 allowanceBefore = IERC20(AaveV3AvalancheAssets.DAIe_A_TOKEN).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3AvalancheAssets.DAIe_A_TOKEN).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.DAI_ALLOWANCE());
  }

  function test_approvals_weth() public {
    uint256 allowanceBefore = IERC20(AaveV3AvalancheAssets.WETHe_UNDERLYING).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3AvalancheAssets.WETHe_UNDERLYING).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.WETH_ALLOWANCE());
  }

  function test_approvals_aEthWeth() public {
    uint256 allowanceBefore = IERC20(AaveV3AvalancheAssets.WETHe_A_TOKEN).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3AvalancheAssets.WETHe_A_TOKEN).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.aEthWETH_ALLOWANCE());
  }

  function test_approvals_wavax() public {
    uint256 allowanceBefore = IERC20(AaveV3AvalancheAssets.WAVAX_A_TOKEN).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3AvalancheAssets.WAVAX_A_TOKEN).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.WAVAX_ALLOWANCE());
  }

  function test_approvals_btc() public {
    uint256 allowanceBefore = IERC20(AaveV3AvalancheAssets.BTCb_A_TOKEN).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3AvalancheAssets.BTCb_A_TOKEN).allowance(
      address(AaveV3Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.BTC_ALLOWANCE());
  }
}
