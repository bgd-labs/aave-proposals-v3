// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_RiskStewardPhase2_20240805} from './AaveV3Ethereum_RiskStewardPhase2_20240805.sol';
import {IRiskSteward} from './interfaces/IRiskSteward.sol';

/**
 * @dev Test for AaveV3Ethereum_RiskStewardPhase2_20240805
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240805_Multi_RiskStewardPhase2/AaveV3Ethereum_RiskStewardPhase2_20240805.t.sol -vv
 */
contract AaveV3Ethereum_RiskStewardPhase2_20240805_Test is ProtocolV3TestBase {
  AaveV3Ethereum_RiskStewardPhase2_20240805 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21085127);
    proposal = new AaveV3Ethereum_RiskStewardPhase2_20240805();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_RiskStewardPhase2_20240805',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_permissions() public {
    assertFalse(
      IRiskSteward(AaveV3Ethereum.RISK_STEWARD).isAddressRestricted(
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );
    executePayload(vm, address(proposal));

    assertEq(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(AaveV3Ethereum.RISK_STEWARD), true);
    assertTrue(
      IRiskSteward(AaveV3Ethereum.RISK_STEWARD).isAddressRestricted(
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );
  }
}
