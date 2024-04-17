// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_OptimismSusdEmissionAdmin_20240312} from './AaveV3Optimism_OptimismSusdEmissionAdmin_20240312.sol';

/**
 * @dev Test for AaveV3Optimism_OptimismSusdEmissionAdmin_20240312
 * command: make test-contract filter=AaveV3Optimism_OptimismSusdEmissionAdmin_20240312
 */
contract AaveV3Optimism_OptimismSusdEmissionAdmin_20240312_Test is ProtocolV3TestBase {
  AaveV3Optimism_OptimismSusdEmissionAdmin_20240312 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 117342386);
    proposal = new AaveV3Optimism_OptimismSusdEmissionAdmin_20240312();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_OptimismSusdEmissionAdmin_20240312',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }

  function test_isEmmissionAdmin() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      IEmissionManager(AaveV3Optimism.EMISSION_MANAGER).getEmissionAdmin(
        AaveV3OptimismAssets.sUSD_UNDERLYING
      ),
      0xac140648435d03f784879cd789130F22Ef588Fcd
    );
  }
}
