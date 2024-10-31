// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumEtherFi} from 'aave-address-book/AaveV3EthereumEtherFi.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumEtherFi_RiskStewardPhase2_20240805} from './AaveV3EthereumEtherFi_RiskStewardPhase2_20240805.sol';

/**
 * @dev Test for AaveV3EthereumEtherFi_RiskStewardPhase2_20240805
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240805_Multi_RiskStewardPhase2/AaveV3EthereumEtherFi_RiskStewardPhase2_20240805.t.sol -vv
 */
contract AaveV3EthereumEtherFi_RiskStewardPhase2_20240805_Test is ProtocolV3TestBase {
  AaveV3EthereumEtherFi_RiskStewardPhase2_20240805 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21085127);
    proposal = new AaveV3EthereumEtherFi_RiskStewardPhase2_20240805();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumEtherFi_RiskStewardPhase2_20240805',
      AaveV3EthereumEtherFi.POOL,
      address(proposal)
    );
  }

  function test_permissions() public {
    executePayload(vm, address(proposal));

    assertEq(
      AaveV3EthereumEtherFi.ACL_MANAGER.isRiskAdmin(AaveV3EthereumEtherFi.RISK_STEWARD),
      true
    );
  }
}
