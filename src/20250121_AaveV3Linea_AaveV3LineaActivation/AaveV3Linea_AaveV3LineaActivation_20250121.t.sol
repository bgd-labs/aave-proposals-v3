// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Linea} from 'aave-address-book/AaveV3Linea.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Linea_AaveV3LineaActivation_20250121} from './AaveV3Linea_AaveV3LineaActivation_20250121.sol';

/**
 * @dev Test for AaveV3Linea_AaveV3LineaActivation_20250121
 * command: FOUNDRY_PROFILE=linea forge test --match-path=src/20250121_AaveV3Linea_AaveV3LineaActivation/AaveV3Linea_AaveV3LineaActivation_20250121.t.sol -vv
 */
contract AaveV3Linea_AaveV3LineaActivation_20250121_Test is ProtocolV3TestBase {
  AaveV3Linea_AaveV3LineaActivation_20250121 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('linea'), 14852350);
    proposal = new AaveV3Linea_AaveV3LineaActivation_20250121();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Linea_AaveV3LineaActivation_20250121', AaveV3Linea.POOL, address(proposal));
  }

  function test_collectorHasWETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.WETH()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Linea.COLLECTOR)), 10 ** 18);
  }

  function test_collectorHasWBTCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.WBTC()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Linea.COLLECTOR)), 10 ** 8);
  }

  function test_collectorHasUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.USDC()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Linea.COLLECTOR)), 10 ** 6);
  }

  function test_collectorHasUSDTFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.USDT()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Linea.COLLECTOR)), 10 ** 6);
  }

  function test_collectorHaswstETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.wstETH()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Linea.COLLECTOR)), 10 ** 18);
  }

  function test_collectorHasezETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.ezETH()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Linea.COLLECTOR)), 10 ** 18);
  }

  function test_collectorHasweETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.weETH()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Linea.COLLECTOR)), 10 ** 18);
  }
}
