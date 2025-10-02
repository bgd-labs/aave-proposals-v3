// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseVII_20250930} from './AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseVII_20250930.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
/**
 * @dev Test for AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseVII_20250930
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250930_AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseVII/AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseVII_20250930.t.sol -vv
 */
contract AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseVII_20250930_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseVII_20250930 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23478059);
    proposal = new AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseVII_20250930();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseVII_20250930',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_approvals() public {
    assertEq(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        GhoEthereum.GHO_LIQUIDITY_COMMITTEE
      ),
      0
    );

    executePayload(vm, address(proposal));

    uint256 allowanceGhoAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      GhoEthereum.GHO_LIQUIDITY_COMMITTEE
    );

    assertEq(allowanceGhoAfter, proposal.ALLOWANCE_AMOUNT());

    vm.startPrank(GhoEthereum.GHO_LIQUIDITY_COMMITTEE);
    IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      GhoEthereum.GHO_LIQUIDITY_COMMITTEE,
      allowanceGhoAfter
    );
    vm.stopPrank();
  }
}
