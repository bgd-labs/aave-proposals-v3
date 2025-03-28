// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_OnboardRsETHToArbitrum_20250326} from './AaveV3Arbitrum_OnboardRsETHToArbitrum_20250326.sol';

/**
 * @dev Test for AaveV3Arbitrum_OnboardRsETHToArbitrum_20250326
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20250326_AaveV3Arbitrum_OnboardRsETHToArbitrum/AaveV3Arbitrum_OnboardRsETHToArbitrum_20250326.t.sol -vv
 */
contract AaveV3Arbitrum_OnboardRsETHToArbitrum_20250326_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_OnboardRsETHToArbitrum_20250326 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 319859244);
    proposal = new AaveV3Arbitrum_OnboardRsETHToArbitrum_20250326();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_OnboardRsETHToArbitrum_20250326',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasrsETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Arbitrum.POOL.getReserveAToken(proposal.rsETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Arbitrum.DUST_BIN)), 35 * 10 ** 15);
  }

  function test_rsETHAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address arsETH = AaveV3Arbitrum.POOL.getReserveAToken(proposal.rsETH());
    assertEq(
      IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER).getEmissionAdmin(proposal.rsETH()),
      proposal.rsETH_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER).getEmissionAdmin(arsETH),
      proposal.rsETH_LM_ADMIN()
    );
  }
}
