// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_AddEURCToAvalancheV3Instance_20250821} from './AaveV3Avalanche_AddEURCToAvalancheV3Instance_20250821.sol';

/**
 * @dev Test for AaveV3Avalanche_AddEURCToAvalancheV3Instance_20250821
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250821_AaveV3Avalanche_AddEURCToAvalancheV3Instance/AaveV3Avalanche_AddEURCToAvalancheV3Instance_20250821.t.sol -vv
 */
contract AaveV3Avalanche_AddEURCToAvalancheV3Instance_20250821_Test is ProtocolV3TestBase {
  AaveV3Avalanche_AddEURCToAvalancheV3Instance_20250821 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 68627864);
    proposal = new AaveV3Avalanche_AddEURCToAvalancheV3Instance_20250821();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_AddEURCToAvalancheV3Instance_20250821',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasEURCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Avalanche.POOL.getReserveAToken(proposal.EURC());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Avalanche.DUST_BIN)),
      proposal.EURC_SEED_AMOUNT()
    );
  }

  function test_EURCAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aEURC = AaveV3Avalanche.POOL.getReserveAToken(proposal.EURC());
    assertEq(
      IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).getEmissionAdmin(proposal.EURC()),
      proposal.EURC_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).getEmissionAdmin(aEURC),
      proposal.EURC_LM_ADMIN()
    );
  }
}
