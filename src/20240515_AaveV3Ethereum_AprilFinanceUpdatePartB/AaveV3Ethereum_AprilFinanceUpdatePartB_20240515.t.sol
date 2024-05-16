// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_AprilFinanceUpdatePartB_20240515} from './AaveV3Ethereum_AprilFinanceUpdatePartB_20240515.sol';

/**
 * @dev Test for AaveV3Ethereum_AprilFinanceUpdatePartB_20240515
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240515_AaveV3Ethereum_AprilFinanceUpdatePartB/AaveV3Ethereum_AprilFinanceUpdatePartB_20240515.t.sol -vv
 */
contract AaveV3Ethereum_AprilFinanceUpdatePartB_20240515_Test is ProtocolV3TestBase {
  event SwapRequested(
    address milkman,
    address indexed fromToken,
    address indexed toToken,
    address fromOracle,
    address toOracle,
    uint256 amount,
    address indexed recipient,
    uint256 slippage
  );

  AaveV3Ethereum_AprilFinanceUpdatePartB_20240515 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19879169);
    proposal = new AaveV3Ethereum_AprilFinanceUpdatePartB_20240515();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AprilFinanceUpdatePartB_20240515',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_swap() public {
    assertGt(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    executePayload(vm, address(proposal));

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      proposal.GHO_USD_FEED(),
      2559123908595926911497284, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      150
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );
  }
}
