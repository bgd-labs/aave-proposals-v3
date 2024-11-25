// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_GHOListingOnLidoPool_20241119} from './AaveV3EthereumLido_GHOListingOnLidoPool_20241119.sol';
import {GHODirectMinterDeploymentLib} from './GHOListingOnLidoPool_20241119.s.sol';

/**
 * @dev Test for AaveV3EthereumLido_GHOListingOnLidoPool_20241119
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241119_AaveV3EthereumLido_GHOListingOnLidoPool/AaveV3EthereumLido_GHOListingOnLidoPool_20241119.t.sol -vv
 */
contract AaveV3EthereumLido_GHOListingOnLidoPool_20241119_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_GHOListingOnLidoPool_20241119 internal proposal;
  address internal vault;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21265036);

    vault = GHODirectMinterDeploymentLib._deploy();
    proposal = new AaveV3EthereumLido_GHOListingOnLidoPool_20241119(vault);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_GHOListingOnLidoPool_20241119',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }
}
