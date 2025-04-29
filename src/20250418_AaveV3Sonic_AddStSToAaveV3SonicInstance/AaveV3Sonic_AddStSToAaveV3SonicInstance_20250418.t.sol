// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Sonic} from 'aave-address-book/AaveV3Sonic.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Sonic_AddStSToAaveV3SonicInstance_20250418} from './AaveV3Sonic_AddStSToAaveV3SonicInstance_20250418.sol';

/**
 * @dev Test for AaveV3Sonic_AddStSToAaveV3SonicInstance_20250418
 * command: FOUNDRY_PROFILE=sonic forge test --match-path=src/20250418_AaveV3Sonic_AddStSToAaveV3SonicInstance/AaveV3Sonic_AddStSToAaveV3SonicInstance_20250418.t.sol -vv
 */
contract AaveV3Sonic_AddStSToAaveV3SonicInstance_20250418_Test is ProtocolV3TestBase {
  AaveV3Sonic_AddStSToAaveV3SonicInstance_20250418 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('sonic'), 22210973);
    proposal = new AaveV3Sonic_AddStSToAaveV3SonicInstance_20250418();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Sonic_AddStSToAaveV3SonicInstance_20250418',
      AaveV3Sonic.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasstSFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Sonic.POOL.getReserveAToken(proposal.stS());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Sonic.DUST_BIN)), 200 * 10 ** 18);
  }

  function test_stSAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address astS = AaveV3Sonic.POOL.getReserveAToken(proposal.stS());
    assertEq(
      IEmissionManager(AaveV3Sonic.EMISSION_MANAGER).getEmissionAdmin(proposal.stS()),
      proposal.stS_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Sonic.EMISSION_MANAGER).getEmissionAdmin(astS),
      proposal.stS_LM_ADMIN()
    );
  }
}
