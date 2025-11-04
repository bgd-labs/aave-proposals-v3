// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Plasma_OnboardSyrupUSDTToAaveV3PlasmaInstance_20251016} from './AaveV3Plasma_OnboardSyrupUSDTToAaveV3PlasmaInstance_20251016.sol';

/**
 * @dev Test for AaveV3Plasma_OnboardSyrupUSDTToAaveV3PlasmaInstance_20251016
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251016_AaveV3Plasma_OnboardSyrupUSDTToAaveV3PlasmaInstance/AaveV3Plasma_OnboardSyrupUSDTToAaveV3PlasmaInstance_20251016.t.sol -vv
 */
contract AaveV3Plasma_OnboardSyrupUSDTToAaveV3PlasmaInstance_20251016_Test is ProtocolV3TestBase {
  AaveV3Plasma_OnboardSyrupUSDTToAaveV3PlasmaInstance_20251016 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 3703191);
    proposal = new AaveV3Plasma_OnboardSyrupUSDTToAaveV3PlasmaInstance_20251016();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Plasma_OnboardSyrupUSDTToAaveV3PlasmaInstance_20251016',
      AaveV3Plasma.POOL,
      address(proposal)
    );
  }

  function test_dustBinHassyrupUSDTFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Plasma.POOL.getReserveAToken(proposal.syrupUSDT());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Plasma.DUST_BIN)), 100 * 10 ** 6);
  }

  function test_syrupUSDTAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address asyrupUSDT = AaveV3Plasma.POOL.getReserveAToken(proposal.syrupUSDT());
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(proposal.syrupUSDT()),
      proposal.syrupUSDT_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(asyrupUSDT),
      proposal.syrupUSDT_LM_ADMIN()
    );
  }
}
