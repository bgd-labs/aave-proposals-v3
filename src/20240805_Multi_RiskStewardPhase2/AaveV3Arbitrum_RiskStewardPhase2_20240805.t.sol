// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IRiskSteward} from './interfaces/IRiskSteward.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_RiskStewardPhase2_20240805} from './AaveV3Arbitrum_RiskStewardPhase2_20240805.sol';

/**
 * @dev Test for AaveV3Arbitrum_RiskStewardPhase2_20240805
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20240805_Multi_RiskStewardPhase2/AaveV3Arbitrum_RiskStewardPhase2_20240805.t.sol -vv
 */
contract AaveV3Arbitrum_RiskStewardPhase2_20240805_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_RiskStewardPhase2_20240805 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 269547589);
    proposal = new AaveV3Arbitrum_RiskStewardPhase2_20240805();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_RiskStewardPhase2_20240805',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_permissions() public {
    assertFalse(
      IRiskSteward(AaveV3Arbitrum.RISK_STEWARD).isAddressRestricted(
        AaveV3ArbitrumAssets.GHO_UNDERLYING
      )
    );
    executePayload(vm, address(proposal));

    assertEq(AaveV3Arbitrum.ACL_MANAGER.isRiskAdmin(AaveV3Arbitrum.RISK_STEWARD), true);
    assertTrue(
      IRiskSteward(AaveV3Arbitrum.RISK_STEWARD).isAddressRestricted(
        AaveV3ArbitrumAssets.GHO_UNDERLYING
      )
    );
  }
}
