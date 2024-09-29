// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';

import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_SetACIAsEmissionManagerForUSDSAndAUSDS_20240929} from './AaveV3Ethereum_SetACIAsEmissionManagerForUSDSAndAUSDS_20240929.sol';

/**
 * @dev Test for AaveV3Ethereum_SetACIAsEmissionManagerForUSDSAndAUSDS_20240929
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240929_AaveV3Ethereum_SetACIAsEmissionManagerForUSDSAndAUSDS/AaveV3Ethereum_SetACIAsEmissionManagerForUSDSAndAUSDS_20240929.t.sol -vv
 */
contract AaveV3Ethereum_SetACIAsEmissionManagerForUSDSAndAUSDS_20240929_Test is ProtocolV3TestBase {
  AaveV3Ethereum_SetACIAsEmissionManagerForUSDSAndAUSDS_20240929 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20858722);
    proposal = new AaveV3Ethereum_SetACIAsEmissionManagerForUSDSAndAUSDS_20240929();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_SetACIAsEmissionManagerForUSDSAndAUSDS_20240929',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_emissions_admin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(proposal.USDS()),
      proposal.ACI_MULTISIG()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(proposal.aEthUSDS()),
      proposal.ACI_MULTISIG()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(proposal.aEthLidoUSDS()),
      proposal.ACI_MULTISIG()
    );
  }
}
