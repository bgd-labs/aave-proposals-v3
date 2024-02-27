// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Arbitrum_AaveProtocolEmbassy_20240220} from './AaveV3Arbitrum_AaveProtocolEmbassy_20240220.sol';

/**
 * @dev Test for AaveV3Arbitrum_AaveProtocolEmbassy_20240220
 * command: make test-contract filter=AaveV3Arbitrum_AaveProtocolEmbassy_20240220
 */
contract AaveV3Arbitrum_AaveProtocolEmbassy_20240220_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_AaveProtocolEmbassy_20240220 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 182366085);
    proposal = new AaveV3Arbitrum_AaveProtocolEmbassy_20240220();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    uint256 balanceCollectorBefore = IERC20(AaveV3ArbitrumAssets.ARB_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );

    assertEq(IERC20(AaveV3ArbitrumAssets.ARB_UNDERLYING).balanceOf(proposal.SAFE()), 0);

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3ArbitrumAssets.ARB_UNDERLYING).balanceOf(address(AaveV3Arbitrum.COLLECTOR)),
      0
    );
    assertEq(
      IERC20(AaveV3ArbitrumAssets.ARB_UNDERLYING).balanceOf(proposal.SAFE()),
      balanceCollectorBefore
    );
  }
}
