// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AdoptTheSEALSafeHarborAgreement_20251006} from './AaveV3Ethereum_AdoptTheSEALSafeHarborAgreement_20251006.sol';

/**
 * @dev Test for AaveV3Ethereum_AdoptTheSEALSafeHarborAgreement_20251006
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251006_AaveV3Ethereum_AdoptTheSEALSafeHarborAgreement/AaveV3Ethereum_AdoptTheSEALSafeHarborAgreement_20251006.t.sol -vv
 */
contract AaveV3Ethereum_AdoptTheSEALSafeHarborAgreement_20251006_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AdoptTheSEALSafeHarborAgreement_20251006 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23516158);
    proposal = new AaveV3Ethereum_AdoptTheSEALSafeHarborAgreement_20251006();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AdoptTheSEALSafeHarborAgreement_20251006',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_agreement() public {
    executePayload(vm, address(proposal));

    assertEq(
      proposal.REGISTRY().getAgreement(GovernanceV3Ethereum.EXECUTOR_LVL_1),
      0x585aFfCCFF9398AfdB12bDfF2E74182437f45aF0
    );
  }
}
