// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_FebruaryFundingUpdate_20250120} from './AaveV3Avalanche_FebruaryFundingUpdate_20250120.sol';

/**
 * @dev Test for AaveV3Avalanche_FebruaryFundingUpdate_20250120
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20250120_Multi_FebruaryFundingUpdate/AaveV3Avalanche_FebruaryFundingUpdate_20250120.t.sol -vv
 */
contract AaveV3Avalanche_FebruaryFundingUpdate_20250120_Test is ProtocolV3TestBase {
  AaveV3Avalanche_FebruaryFundingUpdate_20250120 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 56254356);
    proposal = new AaveV3Avalanche_FebruaryFundingUpdate_20250120();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
  //  */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_FebruaryFundingUpdate_20250120',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_withdraw() public {
    uint256 balanceDaiBefore = IERC20(AaveV2AvalancheAssets.DAIe_A_TOKEN).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );

    assertGt(
      IERC20(AaveV2AvalancheAssets.WETHe_A_TOKEN).balanceOf(address(AaveV3Avalanche.COLLECTOR)),
      1 ether
    );
    assertGt(
      IERC20(AaveV2AvalancheAssets.DAIe_A_TOKEN).balanceOf(address(AaveV3Avalanche.COLLECTOR)),
      proposal.DAI_TO_WITHDRAW()
    );
    assertGt(
      IERC20(AaveV2AvalancheAssets.WAVAX_A_TOKEN).balanceOf(address(AaveV3Avalanche.COLLECTOR)),
      1 ether
    );

    executePayload(vm, address(proposal));

    assertApproxEqAbs(
      IERC20(AaveV2AvalancheAssets.WETHe_A_TOKEN).balanceOf(address(AaveV3Avalanche.COLLECTOR)),
      1 ether,
      0.01 ether
    );
    assertApproxEqAbs(
      IERC20(AaveV2AvalancheAssets.DAIe_A_TOKEN).balanceOf(address(AaveV3Avalanche.COLLECTOR)),
      balanceDaiBefore - proposal.DAI_TO_WITHDRAW(),
      1 ether
    );
    assertApproxEqAbs(
      IERC20(AaveV2AvalancheAssets.WAVAX_A_TOKEN).balanceOf(address(AaveV3Avalanche.COLLECTOR)),
      1 ether,
      0.01 ether
    );
  }

  function test_deposit() public {
    uint256 balanceAAvaxWETHBefore = IERC20(AaveV3AvalancheAssets.WETHe_A_TOKEN).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    uint256 balanceAAvaxDAIBefore = IERC20(AaveV3AvalancheAssets.DAIe_A_TOKEN).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    uint256 balanceAAvaxWAVAXBefore = IERC20(AaveV3AvalancheAssets.WAVAX_A_TOKEN).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    uint256 balanceAAvaxUSDTBefore = IERC20(AaveV3AvalancheAssets.USDt_A_TOKEN).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    uint256 balanceAAvaxUSDCBefore = IERC20(AaveV3AvalancheAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    uint256 balanceAAvaxBTCBefore = IERC20(AaveV3AvalancheAssets.BTCb_A_TOKEN).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    assertGt(
      IERC20(AaveV3AvalancheAssets.WETHe_A_TOKEN).balanceOf(address(AaveV3Avalanche.COLLECTOR)),
      balanceAAvaxWETHBefore
    );
    assertGt(
      IERC20(AaveV3AvalancheAssets.DAIe_A_TOKEN).balanceOf(address(AaveV3Avalanche.COLLECTOR)),
      balanceAAvaxDAIBefore
    );
    assertGt(
      IERC20(AaveV3AvalancheAssets.WAVAX_A_TOKEN).balanceOf(address(AaveV3Avalanche.COLLECTOR)),
      balanceAAvaxWAVAXBefore
    );
    assertGt(
      IERC20(AaveV3AvalancheAssets.USDt_A_TOKEN).balanceOf(address(AaveV3Avalanche.COLLECTOR)),
      balanceAAvaxUSDTBefore
    );
    assertGt(
      IERC20(AaveV3AvalancheAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Avalanche.COLLECTOR)),
      balanceAAvaxUSDCBefore
    );
    assertGt(
      IERC20(AaveV3AvalancheAssets.BTCb_A_TOKEN).balanceOf(address(AaveV3Avalanche.COLLECTOR)),
      balanceAAvaxBTCBefore
    );
  }
}
