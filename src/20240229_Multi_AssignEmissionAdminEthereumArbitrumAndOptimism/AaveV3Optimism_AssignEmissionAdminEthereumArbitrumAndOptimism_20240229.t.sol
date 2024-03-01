// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229} from './AaveV3Optimism_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229.sol';
import {IEmissionManager} from '@aave/periphery-v3/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @dev Test for AaveV3Optimism_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229
 * command: make test-contract filter=AaveV3Optimism_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229
 */
contract AaveV3Optimism_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229_Test is
  ProtocolV3TestBase
{
  AaveV3Optimism_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229 internal proposal;
  address internal opEmissionsAdmin = 0x3479CEb4b1fcaDC586d4c5F1c16b4d8c0D70Bc71;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 116817141);
    proposal = new AaveV3Optimism_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229',
      AaveV3Optimism.POOL,
      address(proposal)
    );

    address admin = IEmissionManager(AaveV3Optimism.EMISSION_MANAGER).getEmissionAdmin(
      AaveV3OptimismAssets.OP_UNDERLYING
    );
    assertEq(admin, opEmissionsAdmin);
    assertEq(admin, proposal.EMISSION_ADMIN());
  }
}
