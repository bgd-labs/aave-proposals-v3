// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_IncreaseCCIPFacilitatorCapacity_20240707} from './AaveV3Ethereum_IncreaseCCIPFacilitatorCapacity_20240707.sol';

interface UpgradeableLockReleaseTokenPool {
  function getBridgeLimit() external returns (uint256);

  function setBridgeLimit(uint256 limit) external;
}

/**
 * @dev Test for AaveV3Ethereum_IncreaseCCIPFacilitatorCapacity_20240707
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240707_AaveV3Ethereum_IncreaseCCIPFacilitatorCapacity/AaveV3Ethereum_IncreaseCCIPFacilitatorCapacity_20240707.t.sol -vv
 */
contract AaveV3Ethereum_IncreaseCCIPFacilitatorCapacity_20240707_Test is ProtocolV3TestBase {
  AaveV3Ethereum_IncreaseCCIPFacilitatorCapacity_20240707 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20257789);
    proposal = new AaveV3Ethereum_IncreaseCCIPFacilitatorCapacity_20240707();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_newLimitIsSet() public {
    // Current limit is 1M
    assertEq(
      UpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL).getBridgeLimit(),
      1_000_000 ether
    );

    executePayload(vm, address(proposal));

    assertEq(
      UpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL).getBridgeLimit(),
      proposal.NEW_LIMIT()
    );
  }
}
