// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {IGhoToken} from 'gho-core/gho/interfaces/IGhoToken.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Arbitrum_IncreaseCCIPFacilitatorCapacity_20240707} from './AaveV3Arbitrum_IncreaseCCIPFacilitatorCapacity_20240707.sol';

/**
 * @dev Test for AaveV3Arbitrum_IncreaseCCIPFacilitatorCapacity_20240707
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20240707_AaveV3Ethereum_IncreaseCCIPFacilitatorCapacity/AaveV3Arbitrum_IncreaseCCIPFacilitatorCapacity_20240707.t.sol -vv
 */
contract AaveV3Arbitrum_IncreaseCCIPFacilitatorCapacity_20240707_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_IncreaseCCIPFacilitatorCapacity_20240707 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 230441155);
    proposal = new AaveV3Arbitrum_IncreaseCCIPFacilitatorCapacity_20240707();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_newLimitIsSet() public {
    IGhoToken.Facilitator memory prevFacilitator = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING)
      .getFacilitator(MiscArbitrum.GHO_CCIP_TOKEN_POOL);
    assertEq(prevFacilitator.bucketCapacity, 1_000_000 ether);

    executePayload(vm, address(proposal));

    IGhoToken.Facilitator memory facilitator = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING)
      .getFacilitator(MiscArbitrum.GHO_CCIP_TOKEN_POOL);

    assertEq(facilitator.bucketCapacity, proposal.NEW_LIMIT());
  }
}
