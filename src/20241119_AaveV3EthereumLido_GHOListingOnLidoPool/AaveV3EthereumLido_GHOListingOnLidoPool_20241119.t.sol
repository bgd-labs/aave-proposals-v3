// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_GHOListingOnLidoPool_20241119} from './AaveV3EthereumLido_GHOListingOnLidoPool_20241119.sol';

/**
 * @dev Test for AaveV3EthereumLido_GHOListingOnLidoPool_20241119
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241119_AaveV3EthereumLido_GHOListingOnLidoPool/AaveV3EthereumLido_GHOListingOnLidoPool_20241119.t.sol -vv
 */
contract AaveV3EthereumLido_GHOListingOnLidoPool_20241119_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_GHOListingOnLidoPool_20241119 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21223745);
    proposal = new AaveV3EthereumLido_GHOListingOnLidoPool_20241119();
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

  function test_collectorHasGHOFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.GHO());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3EthereumLido.COLLECTOR)), 10 ** 18);
  }
}
