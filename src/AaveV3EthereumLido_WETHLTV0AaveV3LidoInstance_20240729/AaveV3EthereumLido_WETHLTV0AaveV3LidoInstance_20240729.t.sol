// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729} from './AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729.sol';

/**
 * @dev Test for AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729/AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729.t.sol -vv
 */
contract AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20414432);
    proposal = new AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }
}
