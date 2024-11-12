// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108} from './AaveV3Ethereum_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108.sol';

/**
 * @dev Test for AaveV3Ethereum_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241108_Multi_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances/AaveV3Ethereum_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108.t.sol -vv
 */
contract AaveV3Ethereum_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21171005);
    proposal = new AaveV3Ethereum_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_OnboardAndEnableSUSDeLiquidEModeOnAaveV3MainnetAndLidoInstances_20241108',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
