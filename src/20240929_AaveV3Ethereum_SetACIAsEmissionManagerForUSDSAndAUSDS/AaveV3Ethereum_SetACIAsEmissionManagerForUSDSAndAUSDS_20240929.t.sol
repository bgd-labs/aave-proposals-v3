// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {DataTypes} from 'aave-v3-origin/core/contracts/protocol/libraries/types/DataTypes.sol';
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
    GovV3Helpers.executePayload(vm, 183);
    defaultTest(
      'AaveV3Ethereum_SetACIAsEmissionManagerForUSDSAndAUSDS_20240929',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_emissions_admin() public {
    GovV3Helpers.executePayload(vm, 183);
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(proposal.USDS()),
      proposal.ACI_MULTISIG()
    );
    DataTypes.ReserveDataLegacy memory protoUSDS = AaveV3Ethereum.POOL.getReserveData(
      proposal.USDS()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(protoUSDS.aTokenAddress),
      proposal.ACI_MULTISIG()
    );
    DataTypes.ReserveDataLegacy memory lidoUSDS = AaveV3EthereumLido.POOL.getReserveData(
      proposal.USDS()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(lidoUSDS.aTokenAddress),
      proposal.ACI_MULTISIG()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(proposal.awstETH()),
      proposal.ACI_MULTISIG()
    );
  }
}
