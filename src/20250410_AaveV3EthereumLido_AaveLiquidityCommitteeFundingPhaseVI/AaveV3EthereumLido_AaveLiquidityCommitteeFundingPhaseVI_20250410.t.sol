// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseVI_20250410} from './AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseVI_20250410.sol';

/**
 * @dev Test for AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseVI_20250410
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250410_AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseVI/AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseVI_20250410.t.sol -vv
 */
contract AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseVI_20250410_Test is
  ProtocolV3TestBase
{
  AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseVI_20250410 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22242008);
    proposal = new AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseVI_20250410();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseVI_20250410',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_allowance() public {
    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumLidoAssets.GHO_UNDERLYING).allowance(
        address(AaveV3EthereumLido.COLLECTOR),
        proposal.ALC_SAFE()
      ),
      proposal.GHO_ALLOWANCE()
    );

    vm.startPrank(proposal.ALC_SAFE());

    uint256 ghoBalanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_UNDERLYING).balanceOf(
      proposal.ALC_SAFE()
    );
    IERC20(AaveV3EthereumLidoAssets.GHO_UNDERLYING).transferFrom(
      address(AaveV3EthereumLido.COLLECTOR),
      proposal.ALC_SAFE(),
      proposal.GHO_ALLOWANCE()
    );

    uint256 ghoBalanceAfter = IERC20(AaveV3EthereumLidoAssets.GHO_UNDERLYING).balanceOf(
      proposal.ALC_SAFE()
    );

    assertEq(ghoBalanceAfter, ghoBalanceBefore + proposal.GHO_ALLOWANCE());
  }
}
