// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_IncreaseCCIPFacilitatorCapacity_20240707} from './AaveV3Arbitrum_IncreaseCCIPFacilitatorCapacity_20240707.sol';

interface IGHOToken {
  function getFacilitator(address facilitator) external returns (uint128, uint128, string memory);
}

/**
 * @dev Test for AaveV3Arbitrum_IncreaseCCIPFacilitatorCapacity_20240707
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240707_AaveV3Ethereum_IncreaseCCIPFacilitatorCapacity/AaveV3Arbitrum_IncreaseCCIPFacilitatorCapacity_20240707.t.sol -vv
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
    (uint128 currentLimit, , ) = IGHOToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).getFacilitator(
      proposal.FACILITATOR()
    );
    assertEq(currentLimit, 1_000_000 ether);

    executePayload(vm, address(proposal));

    (uint128 newLimit, , ) = IGHOToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).getFacilitator(
      proposal.FACILITATOR()
    );

    assertEq(newLimit, proposal.NEW_LIMIT());
  }
}
