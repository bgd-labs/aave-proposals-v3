// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance_20251212} from './AaveV3EthereumLido_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance_20251212.sol';

/**
 * @dev Test for AaveV3EthereumLido_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance_20251212
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251212_Multi_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance/AaveV3EthereumLido_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance_20251212.t.sol -vv
 */
contract AaveV3EthereumLido_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance_20251212_Test is
  ProtocolV3TestBase
{
  AaveV3EthereumLido_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance_20251212 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23995637);
    proposal = new AaveV3EthereumLido_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance_20251212();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_AddWETHToTheWrsETHWstETHEModeOnAaveV3BaseInstance_20251212',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }
}
