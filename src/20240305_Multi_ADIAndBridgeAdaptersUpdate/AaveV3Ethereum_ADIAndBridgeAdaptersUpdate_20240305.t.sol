// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ICrossChainReceiver} from 'aave-address-book/common/ICrossChainController.sol';

/**
 * @dev Test for AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19367957);
    proposal = new AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
