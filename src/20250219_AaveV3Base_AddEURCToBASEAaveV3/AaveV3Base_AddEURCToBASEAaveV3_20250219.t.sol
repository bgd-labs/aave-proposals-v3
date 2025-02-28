// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_AddEURCToBASEAaveV3_20250219} from './AaveV3Base_AddEURCToBASEAaveV3_20250219.sol';

/**
 * @dev Test for AaveV3Base_AddEURCToBASEAaveV3_20250219
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20250219_AaveV3Base_AddEURCToBASEAaveV3/AaveV3Base_AddEURCToBASEAaveV3_20250219.t.sol -vv
 */
contract AaveV3Base_AddEURCToBASEAaveV3_20250219_Test is ProtocolV3TestBase {
  AaveV3Base_AddEURCToBASEAaveV3_20250219 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 26985479);
    proposal = new AaveV3Base_AddEURCToBASEAaveV3_20250219();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_AddEURCToBASEAaveV3_20250219', AaveV3Base.POOL, address(proposal));
  }

  function test_collectorHasEURCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.EURC()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Base.COLLECTOR)), 100 * 10 ** 6);
  }

  function test_EURCAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aEURC, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.EURC()
    );
    assertEq(
      IEmissionManager(AaveV3Base.EMISSION_MANAGER).getEmissionAdmin(proposal.EURC()),
      proposal.EURC_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Base.EMISSION_MANAGER).getEmissionAdmin(aEURC),
      proposal.EURC_LM_ADMIN()
    );
  }
}
