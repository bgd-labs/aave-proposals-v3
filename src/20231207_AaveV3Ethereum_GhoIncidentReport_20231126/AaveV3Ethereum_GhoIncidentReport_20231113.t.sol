// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3EthereumAssets, AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {IPoolConfigurator} from 'aave-address-book/AaveV3.sol';
import {AaveV3Ethereum_GhoIncidentReport_20231113} from './AaveV3Ethereum_GhoIncidentReport_20231113.sol';

interface IGhoVariableDebtTokenHelper {
  function DEBT_TOKEN_REVISION() external view returns (uint256);
}

/**
 * @dev Test for AaveV3Ethereum_GhoIncidentReport_20231113
 * command: make test-contract filter=AaveV3Ethereum_GhoIncidentReport_20231113
 */
contract AaveV3Ethereum_GhoIncidentReport_20231113_Test is ProtocolV3TestBase {
  address constant NEW_VGHO_IMPL = 0x20Cb2f303EDe313e2Cc44549Ad8653a5E8c0050e;

  AaveV3Ethereum_GhoIncidentReport_20231113 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18722500);
    proposal = new AaveV3Ethereum_GhoIncidentReport_20231113();
  }

  function test_defaultProposalExecution() public {
    // increase GHO borrow cap so test borrows can succeed
    vm.prank(AaveV3Ethereum.CAPS_PLUS_RISK_STEWARD);
    AaveV3Ethereum.POOL_CONFIGURATOR.setBorrowCap(AaveV3Ethereum.GHO_TOKEN, 36_000_000);
    defaultTest(
      'AaveV3Ethereum_GhoIncidentReport_20231113',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_debtTokenRevisionUpdate() public {
    assertTrue(
      IGhoVariableDebtTokenHelper(AaveV3EthereumAssets.GHO_V_TOKEN).DEBT_TOKEN_REVISION() == 0x2
    );
    executePayload(vm, address(proposal));
    assertTrue(
      IGhoVariableDebtTokenHelper(AaveV3EthereumAssets.GHO_V_TOKEN).DEBT_TOKEN_REVISION() == 0x3
    );
  }
}
