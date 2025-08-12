// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Linea} from 'aave-address-book/AaveV3Linea.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Linea_OnboardRsETHToAaveV3LineaInstance_20250811} from './AaveV3Linea_OnboardRsETHToAaveV3LineaInstance_20250811.sol';

/**
 * @dev Test for AaveV3Linea_OnboardRsETHToAaveV3LineaInstance_20250811
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250811_AaveV3Linea_OnboardRsETHToAaveV3LineaInstance/AaveV3Linea_OnboardRsETHToAaveV3LineaInstance_20250811.t.sol -vv
 */
contract AaveV3Linea_OnboardRsETHToAaveV3LineaInstance_20250811_Test is ProtocolV3TestBase {
  AaveV3Linea_OnboardRsETHToAaveV3LineaInstance_20250811 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('linea'), 21945022);
    proposal = new AaveV3Linea_OnboardRsETHToAaveV3LineaInstance_20250811();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Linea_OnboardRsETHToAaveV3LineaInstance_20250811',
      AaveV3Linea.POOL,
      address(proposal)
    );
  }

  function test_dustBinHaswrsETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Linea.POOL.getReserveAToken(proposal.wrsETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Linea.DUST_BIN)),
      proposal.wrsETH_SEED_AMOUNT()
    );
  }

  function test_wrsETHAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address awrsETH = AaveV3Linea.POOL.getReserveAToken(proposal.wrsETH());
    assertEq(
      IEmissionManager(AaveV3Linea.EMISSION_MANAGER).getEmissionAdmin(proposal.wrsETH()),
      proposal.wrsETH_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Linea.EMISSION_MANAGER).getEmissionAdmin(awrsETH),
      proposal.wrsETH_LM_ADMIN()
    );
  }
}
