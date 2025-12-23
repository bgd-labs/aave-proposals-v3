// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_OnboardSyrupUSDCToAaveV3BaseInstance_20251223} from './AaveV3Base_OnboardSyrupUSDCToAaveV3BaseInstance_20251223.sol';

/**
 * @dev Test for AaveV3Base_OnboardSyrupUSDCToAaveV3BaseInstance_20251223
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251223_AaveV3Base_OnboardSyrupUSDCToAaveV3BaseInstance/AaveV3Base_OnboardSyrupUSDCToAaveV3BaseInstance_20251223.t.sol -vv
 */
contract AaveV3Base_OnboardSyrupUSDCToAaveV3BaseInstance_20251223_Test is ProtocolV3TestBase {
  AaveV3Base_OnboardSyrupUSDCToAaveV3BaseInstance_20251223 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 39861991);
    proposal = new AaveV3Base_OnboardSyrupUSDCToAaveV3BaseInstance_20251223();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_OnboardSyrupUSDCToAaveV3BaseInstance_20251223',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_dustBinHassyrupUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Base.POOL.getReserveAToken(proposal.syrupUSDC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Base.DUST_BIN)), 100 * 10 ** 6);
  }

  function test_syrupUSDCAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address asyrupUSDC = AaveV3Base.POOL.getReserveAToken(proposal.syrupUSDC());
    assertEq(
      IEmissionManager(AaveV3Base.EMISSION_MANAGER).getEmissionAdmin(proposal.syrupUSDC()),
      proposal.syrupUSDC_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Base.EMISSION_MANAGER).getEmissionAdmin(asyrupUSDC),
      proposal.syrupUSDC_LM_ADMIN()
    );
  }
}
