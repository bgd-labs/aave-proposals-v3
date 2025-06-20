// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';
import {ProtocolV3TestBase} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_PendlePTDiscountRateRiskOracleActivation_20250606} from './AaveV3ZkSync_PendlePTDiscountRateRiskOracleActivation_20250606.sol';

import {BaseStewardUpdateTest} from '../../../src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/BaseStewardUpdateTest.t.sol';

/**
 * @dev Test for AaveV3ZkSync_PendlePTDiscountRateRiskOracleActivation_20250606
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3ZkSync_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol -vv
 */
contract AaveV3ZkSync_PendlePTDiscountRateRiskOracleActivation_20250606_Test is
  ProtocolV3TestBase,
  BaseStewardUpdateTest
{
  AaveV3ZkSync_PendlePTDiscountRateRiskOracleActivation_20250606 internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 61387801);
    proposal = new AaveV3ZkSync_PendlePTDiscountRateRiskOracleActivation_20250606();

    super.setUp();
  }

  function getBaseTestInput() public virtual override returns (ValidationInput memory) {
    return
      ValidationInput({
        payload: address(proposal),
        aclManager: address(AaveV3ZkSync.ACL_MANAGER),
        currentRiskSteward: AaveV3ZkSync.RISK_STEWARD,
        newRiskSteward: proposal.NEW_RISK_STEWARD(),
        freezingSteward: address(0),
        capsPlusSteward: address(0)
      });
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_PendlePTDiscountRateRiskOracleActivation_20250606',
      AaveV3ZkSync.POOL,
      address(proposal)
    );
  }
}
