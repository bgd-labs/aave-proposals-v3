// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720} from './AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import 'forge-std/console2.sol';

/**
 * @dev Test for AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240720_AaveV3EthereumLido_LidoEthereumInstanceActivation/AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720.t.sol -vv
 */
contract AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20347071);
    proposal = new AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720();

    deal(proposal.WETH(), GovernanceV3Ethereum.EXECUTOR_LVL_1, 1 ether);
    deal(proposal.wstETH(), GovernanceV3Ethereum.EXECUTOR_LVL_1, 1 ether);

    console2.log(IERC20(proposal.WETH()).balanceOf(GovernanceV3Ethereum.EXECUTOR_LVL_1));
    console2.log(IERC20(proposal.wstETH()).balanceOf(GovernanceV3Ethereum.EXECUTOR_LVL_1));
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_LidoEthereumInstanceActivation_20240720',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_collectorHaswstETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.wstETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 1 ether);
  }

  function test_collectorHasWETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.WETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 1 ether);
  }
}
