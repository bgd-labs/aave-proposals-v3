// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_OrbitProgramRenewalQ1AndQ22026_20251231} from './AaveV3EthereumLido_OrbitProgramRenewalQ1AndQ22026_20251231.sol';

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import {OrbitProgramData} from './OrbitProgramData.sol';

/**
 * @dev Test for AaveV3EthereumLido_OrbitProgramRenewalQ1AndQ22026_20251231
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251231_AaveV3EthereumLido_OrbitProgramRenewalQ1AndQ22026/AaveV3EthereumLido_OrbitProgramRenewalQ1AndQ22026_20251231.t.sol -vv
 */
contract AaveV3EthereumLido_OrbitProgramRenewalQ1AndQ22026_20251231_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_OrbitProgramRenewalQ1AndQ22026_20251231 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24134407);
    proposal = new AaveV3EthereumLido_OrbitProgramRenewalQ1AndQ22026_20251231();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_OrbitProgramRenewalQ1AndQ22026_20251231',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_streamCreation() public {
    uint256[] memory ghoBalancesBeforeUsers = new uint256[](4);
    address[] memory ghoPaymentAddresses = OrbitProgramData.getOrbitAddresses();
    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      ghoBalancesBeforeUsers[i] = IERC20(AaveV3EthereumLidoAssets.GHO_UNDERLYING).balanceOf(
        ghoPaymentAddresses[i]
      );
    }

    uint256 nextStreamId = AaveV3EthereumLido.COLLECTOR.getNextStreamId();
    vm.expectRevert();
    AaveV3EthereumLido.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 7 days);

    /// Their GHO balance has increased and call also withdraw from stream as it now exists
    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      assertEq(
        IERC20(AaveV3EthereumLidoAssets.GHO_UNDERLYING).balanceOf(ghoPaymentAddresses[i]),
        ghoBalancesBeforeUsers[i],
        'GHO balance of Orbit recipient is not greater than before'
      );

      vm.prank(ghoPaymentAddresses[i]);
      AaveV3EthereumLido.COLLECTOR.withdrawFromStream(nextStreamId + i, 1);
      assertEq(
        IERC20(AaveV3EthereumLidoAssets.GHO_UNDERLYING).balanceOf(ghoPaymentAddresses[i]),
        ghoBalancesBeforeUsers[i] + 1
      );
    }
  }
}
