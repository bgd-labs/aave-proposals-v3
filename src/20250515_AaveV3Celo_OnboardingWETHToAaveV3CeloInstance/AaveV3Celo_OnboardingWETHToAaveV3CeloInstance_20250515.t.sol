// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Celo} from 'aave-address-book/AaveV3Celo.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Celo_OnboardingWETHToAaveV3CeloInstance_20250515} from './AaveV3Celo_OnboardingWETHToAaveV3CeloInstance_20250515.sol';

/**
 * @dev Test for AaveV3Celo_OnboardingWETHToAaveV3CeloInstance_20250515
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250515_AaveV3Celo_OnboardingWETHToAaveV3CeloInstance/AaveV3Celo_OnboardingWETHToAaveV3CeloInstance_20250515.t.sol -vv
 */
contract AaveV3Celo_OnboardingWETHToAaveV3CeloInstance_20250515_Test is ProtocolV3TestBase {
  AaveV3Celo_OnboardingWETHToAaveV3CeloInstance_20250515 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('celo'), 35741475);
    proposal = new AaveV3Celo_OnboardingWETHToAaveV3CeloInstance_20250515();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Celo_OnboardingWETHToAaveV3CeloInstance_20250515',
      AaveV3Celo.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasWETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Celo.POOL.getReserveAToken(proposal.WETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Celo.DUST_BIN)), 5 * 10 ** 16);
  }

  function test_WETHAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aWETH = AaveV3Celo.POOL.getReserveAToken(proposal.WETH());
    assertEq(
      IEmissionManager(AaveV3Celo.EMISSION_MANAGER).getEmissionAdmin(proposal.WETH()),
      proposal.WETH_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Celo.EMISSION_MANAGER).getEmissionAdmin(aWETH),
      proposal.WETH_LM_ADMIN()
    );
  }
}
