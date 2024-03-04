// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229} from './AaveV3Ethereum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229.sol';
import {IEmissionManager} from '@aave/periphery-v3/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @dev Test for AaveV3Ethereum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229
 * command: make test-contract filter=AaveV3Ethereum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229
 */
contract AaveV3Ethereum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229 internal proposal;

  address internal sdEthxEmissionAdmin = 0xbDa6C9cd7eD043CB739ca2C748dAbd1fCA397132;
  address internal swiseOsethEmissionAdmin = 0x189Cb93839AD52b5e955ddA254Ed7212ae1B1f61;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19335100);
    proposal = new AaveV3Ethereum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229',
      AaveV3Ethereum.POOL,
      address(proposal)
    );

    assertEq(sdEthxEmissionAdmin, proposal.EMISSION_ADMIN_SD_ETHX());
    assertEq(swiseOsethEmissionAdmin, proposal.EMISSION_ADMIN_SWISE_OSETH());

    address sdAdmin = IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(
      proposal.SD()
    );
    assertEq(sdAdmin, proposal.EMISSION_ADMIN_SD_ETHX());

    address ethxAdmin = IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(
      proposal.ETHX()
    );
    assertEq(ethxAdmin, proposal.EMISSION_ADMIN_SD_ETHX());

    address swiseAdmin = IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(
      proposal.SWISE()
    );
    assertEq(swiseAdmin, proposal.EMISSION_ADMIN_SWISE_OSETH());

    address osethAdmin = IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(
      proposal.OSETH()
    );
    assertEq(osethAdmin, proposal.EMISSION_ADMIN_SWISE_OSETH());
  }
}
