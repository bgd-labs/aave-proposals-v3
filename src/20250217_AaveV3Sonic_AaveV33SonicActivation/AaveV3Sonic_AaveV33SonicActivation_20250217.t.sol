// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Sonic} from 'aave-address-book/AaveV3Sonic.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Sonic_AaveV33SonicActivation_20250217} from './AaveV3Sonic_AaveV33SonicActivation_20250217.sol';

/**
 * @dev Test for AaveV3Sonic_AaveV33SonicActivation_20250217
 * command: FOUNDRY_PROFILE=sonic forge test --match-path=src/20250217_AaveV3Sonic_AaveV33SonicActivation/AaveV3Sonic_AaveV33SonicActivation_20250217.t.sol -vv
 */
contract AaveV3Sonic_AaveV33SonicActivation_20250217_Test is ProtocolV3TestBase {
  AaveV3Sonic_AaveV33SonicActivation_20250217 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('sonic'), 8268984);
    proposal = new AaveV3Sonic_AaveV33SonicActivation_20250217();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Sonic_AaveV33SonicActivation_20250217', AaveV3Sonic.POOL, address(proposal));
  }

  function test_collectorHasWETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Sonic.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.WETH()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Sonic.COLLECTOR)), 10 ** 18);
  }

  function test_collectorHasUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Sonic.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.USDC()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Sonic.COLLECTOR)), 10 ** 6);
  }

  function test_collectorHaswSFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Sonic.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.wS()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Sonic.COLLECTOR)), 10 ** 18);
  }
}
