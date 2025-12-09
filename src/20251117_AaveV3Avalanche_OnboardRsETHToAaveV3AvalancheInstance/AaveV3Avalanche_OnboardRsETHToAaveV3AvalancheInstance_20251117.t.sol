// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_OnboardRsETHToAaveV3AvalancheInstance_20251117} from './AaveV3Avalanche_OnboardRsETHToAaveV3AvalancheInstance_20251117.sol';

/**
 * @dev Test for AaveV3Avalanche_OnboardRsETHToAaveV3AvalancheInstance_20251117
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251117_AaveV3Avalanche_OnboardRsETHToAaveV3AvalancheInstance/AaveV3Avalanche_OnboardRsETHToAaveV3AvalancheInstance_20251117.t.sol -vv
 */
contract AaveV3Avalanche_OnboardRsETHToAaveV3AvalancheInstance_20251117_Test is ProtocolV3TestBase {
  AaveV3Avalanche_OnboardRsETHToAaveV3AvalancheInstance_20251117 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 72125217);
    proposal = new AaveV3Avalanche_OnboardRsETHToAaveV3AvalancheInstance_20251117();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_OnboardRsETHToAaveV3AvalancheInstance_20251117',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_dustBinHaswrsETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Avalanche.POOL.getReserveAToken(proposal.wrsETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Avalanche.DUST_BIN)), 3 * 10 ** 16);
  }

  function test_wrsETHAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address awrsETH = AaveV3Avalanche.POOL.getReserveAToken(proposal.wrsETH());
    assertEq(
      IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).getEmissionAdmin(proposal.wrsETH()),
      proposal.wrsETH_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).getEmissionAdmin(awrsETH),
      proposal.wrsETH_LM_ADMIN()
    );
  }
}
