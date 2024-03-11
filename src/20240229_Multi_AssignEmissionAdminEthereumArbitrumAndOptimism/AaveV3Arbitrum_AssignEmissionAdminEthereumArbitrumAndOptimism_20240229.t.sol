// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229} from './AaveV3Arbitrum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229.sol';
import {IEmissionManager} from '@aave/periphery-v3/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @dev Test for AaveV3Arbitrum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229
 * command: make test-contract filter=AaveV3Arbitrum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229
 */
contract AaveV3Arbitrum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229_Test is
  ProtocolV3TestBase
{
  AaveV3Arbitrum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229 internal proposal;

  address internal arbEmissionAdmin = 0xE79C65a313a1f4Ca5D1d15414E0c515056dA90b4;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 185767002);
    proposal = new AaveV3Arbitrum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );

    address admin = IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER).getEmissionAdmin(
      AaveV3ArbitrumAssets.ARB_UNDERLYING
    );

    assertEq(admin, arbEmissionAdmin);
    assertEq(admin, proposal.EMISSION_ADMIN());
  }
}
