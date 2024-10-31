// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_RiskStewardPhase2_20240805} from './AaveV3EthereumLido_RiskStewardPhase2_20240805.sol';

/**
 * @dev Test for AaveV3EthereumLido_RiskStewardPhase2_20240805
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240805_Multi_RiskStewardPhase2/AaveV3EthereumLido_RiskStewardPhase2_20240805.t.sol -vv
 */
contract AaveV3EthereumLido_RiskStewardPhase2_20240805_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_RiskStewardPhase2_20240805 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21085127);
    proposal = new AaveV3EthereumLido_RiskStewardPhase2_20240805();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_RiskStewardPhase2_20240805',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_permissions() public {
    executePayload(vm, address(proposal));

    assertEq(AaveV3EthereumLido.ACL_MANAGER.isRiskAdmin(AaveV3EthereumLido.RISK_STEWARD), true);
  }
}
