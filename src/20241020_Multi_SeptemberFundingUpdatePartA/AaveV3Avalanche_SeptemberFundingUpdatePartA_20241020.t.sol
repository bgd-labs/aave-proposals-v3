// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Avalanche_SeptemberFundingUpdatePartA_20241020} from './AaveV3Avalanche_SeptemberFundingUpdatePartA_20241020.sol';

/**
 * @dev Test for AaveV3Avalanche_SeptemberFundingUpdatePartA_20241020
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20241020_Multi_SeptemberFundingUpdatePartA/AaveV3Avalanche_SeptemberFundingUpdatePartA_20241020.t.sol -vv
 */
contract AaveV3Avalanche_SeptemberFundingUpdatePartA_20241020_Test is ProtocolV3TestBase {
  AaveV3Avalanche_SeptemberFundingUpdatePartA_20241020 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 52083371);
    proposal = new AaveV3Avalanche_SeptemberFundingUpdatePartA_20241020();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_SeptemberFundingUpdatePartA_20241020',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_migration() public {
    /// DAI
    uint256 aDaiV2Before = IERC20(AaveV2AvalancheAssets.DAIe_A_TOKEN).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    uint256 aDaiV3Before = IERC20(AaveV3AvalancheAssets.DAIe_A_TOKEN).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    uint256 daiBefore = IERC20(AaveV2AvalancheAssets.DAIe_UNDERLYING).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );

    /// wAVAX
    uint256 aWavaxV2Before = IERC20(AaveV2AvalancheAssets.WAVAX_A_TOKEN).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    uint256 aWavaxV3Before = IERC20(AaveV3AvalancheAssets.WAVAX_A_TOKEN).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    uint256 wavaxBefore = IERC20(AaveV2AvalancheAssets.WAVAX_UNDERLYING).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );

    /// wETH
    uint256 aWethV2Before = IERC20(AaveV2AvalancheAssets.WETHe_A_TOKEN).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    uint256 aWethV3Before = IERC20(AaveV3AvalancheAssets.WETHe_A_TOKEN).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    uint256 wethBefore = IERC20(AaveV2AvalancheAssets.WETHe_UNDERLYING).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    /// DAI
    uint256 v3After = IERC20(AaveV3AvalancheAssets.DAIe_A_TOKEN).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    uint256 underlyingAfter = IERC20(AaveV2AvalancheAssets.DAIe_UNDERLYING).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    verifyBalances(
      aDaiV2Before,
      aDaiV3Before,
      daiBefore,
      v3After,
      underlyingAfter,
      proposal.BALANCE_LEFT_DAI(),
      0.05e18
    );

    /// wAVAX
    v3After = IERC20(AaveV3AvalancheAssets.WAVAX_A_TOKEN).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    underlyingAfter = IERC20(AaveV2AvalancheAssets.WAVAX_UNDERLYING).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    verifyBalances(
      aWavaxV2Before,
      aWavaxV3Before,
      wavaxBefore,
      v3After,
      underlyingAfter,
      proposal.BALANCE_LEFT_WAVAX(),
      0.10e18
    );

    /// wETH
    v3After = IERC20(AaveV3AvalancheAssets.WETHe_A_TOKEN).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    underlyingAfter = IERC20(AaveV2AvalancheAssets.WETHe_UNDERLYING).balanceOf(
      address(AaveV3Avalanche.COLLECTOR)
    );
    verifyBalances(
      aWethV2Before,
      aWethV3Before,
      wethBefore,
      v3After,
      underlyingAfter,
      proposal.BALANCE_LEFT_WETH(),
      0.10e18
    );
  }

  function verifyBalances(
    uint256 v2Before,
    uint256 v3Before,
    uint256 underlyingBefore,
    uint256 v3After,
    uint256 underlyingAfter,
    uint256 leaveBehind,
    uint256 errorMargin
  ) internal pure {
    /// verify underlying
    assertApproxEqRel(underlyingAfter, 0, errorMargin);

    /// verify v3 balance
    assertApproxEqRel(v3After, (v2Before - leaveBehind) + v3Before + underlyingBefore, errorMargin);
  }
}
