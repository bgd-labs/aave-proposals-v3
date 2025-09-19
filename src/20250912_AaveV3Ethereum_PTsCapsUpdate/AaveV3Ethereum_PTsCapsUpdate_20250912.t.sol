// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_PTsCapsUpdate_20250912} from './AaveV3Ethereum_PTsCapsUpdate_20250912.sol';

/**
 * @dev Test for AaveV3Ethereum_PTsCapsUpdate_20250912
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250912_AaveV3Ethereum_PTsCapsUpdate/AaveV3Ethereum_PTsCapsUpdate_20250912.t.sol -vv
 */
contract AaveV3Ethereum_PTsCapsUpdate_20250912_Test is ProtocolV3TestBase {
  AaveV3Ethereum_PTsCapsUpdate_20250912 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23348439);
    proposal = new AaveV3Ethereum_PTsCapsUpdate_20250912();
  }

  function test_PT_USDe_27NOV2025_priceFeedAdapter() public {
    address feedBefore = AaveV3Ethereum.ORACLE.getSourceOfAsset(
      AaveV3EthereumAssets.PT_USDe_27NOV2025_UNDERLYING
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    address feedAfter = AaveV3Ethereum.ORACLE.getSourceOfAsset(
      AaveV3EthereumAssets.PT_USDe_27NOV2025_UNDERLYING
    );

    assertEq(feedBefore, feedAfter);
  }

  function test_PT_sUSDE_27NOV2025_priceFeedAdapter() public {
    address feedBefore = AaveV3Ethereum.ORACLE.getSourceOfAsset(
      AaveV3EthereumAssets.PT_sUSDE_27NOV2025_UNDERLYING
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    address feedAfter = AaveV3Ethereum.ORACLE.getSourceOfAsset(
      AaveV3EthereumAssets.PT_sUSDE_27NOV2025_UNDERLYING
    );

    assertEq(feedBefore, feedAfter);
  }

  function test_PT_USDe_27NOV2025_caps() public {
    (uint256 ptBorrowCapBefore, uint256 ptSupplyCapBefore) = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveCaps(AaveV3EthereumAssets.PT_USDe_27NOV2025_UNDERLYING);

    GovV3Helpers.executePayload(vm, address(proposal));

    (uint256 ptBorrowCapAfter, uint256 ptSupplyCapAfter) = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveCaps(AaveV3EthereumAssets.PT_USDe_27NOV2025_UNDERLYING);

    assertEq(ptBorrowCapBefore, ptBorrowCapAfter);
    assertEq(ptSupplyCapAfter, 1_000_000_000);
    assertGt(ptSupplyCapAfter, ptSupplyCapBefore);
  }

  function test_PT_sUSDe_27NOV2025_caps() public {
    (uint256 ptBorrowCapBefore, uint256 ptSupplyCapBefore) = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveCaps(AaveV3EthereumAssets.PT_sUSDE_27NOV2025_UNDERLYING);

    GovV3Helpers.executePayload(vm, address(proposal));

    (uint256 ptBorrowCapAfter, uint256 ptSupplyCapAfter) = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveCaps(AaveV3EthereumAssets.PT_sUSDE_27NOV2025_UNDERLYING);

    assertEq(ptBorrowCapBefore, ptBorrowCapAfter);
    assertEq(ptSupplyCapAfter, 1_200_000_000);
    assertGt(ptSupplyCapAfter, ptSupplyCapBefore);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_PTsCapsUpdate_20250912', AaveV3Ethereum.POOL, address(proposal));
  }
}
