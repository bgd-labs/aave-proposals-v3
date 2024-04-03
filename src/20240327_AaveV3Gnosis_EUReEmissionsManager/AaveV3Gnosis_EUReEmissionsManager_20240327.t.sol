// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_EUReEmissionsManager_20240327} from './AaveV3Gnosis_EUReEmissionsManager_20240327.sol';

/**
 * @dev Test for AaveV3Gnosis_EUReEmissionsManager_20240327
 * command: make test-contract filter=AaveV3Gnosis_EUReEmissionsManager_20240327
 */
contract AaveV3Gnosis_EUReEmissionsManager_20240327_Test is ProtocolV3TestBase {
  AaveV3Gnosis_EUReEmissionsManager_20240327 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 33145615);
    proposal = new AaveV3Gnosis_EUReEmissionsManager_20240327();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Gnosis_EUReEmissionsManager_20240327', AaveV3Gnosis.POOL, address(proposal));
  }

  function test_isEmmissionAdmin() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      IEmissionManager(AaveV3Gnosis.EMISSION_MANAGER).getEmissionAdmin(
        AaveV3GnosisAssets.EURe_UNDERLYING
      ),
      0xac140648435d03f784879cd789130F22Ef588Fcd
    );
  }
}
