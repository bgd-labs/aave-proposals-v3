// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

import {IUpgradeableLockReleaseTokenPool} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';
import {AaveV3Ethereum_IncreaseGHOFacilitatorCapacity_20240722} from './AaveV3Ethereum_IncreaseGHOFacilitatorCapacity_20240722.sol';

/**
 * @dev Test for AaveV3Ethereum_IncreaseGHOFacilitatorCapacity_20240722
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240722_Multi_IncreaseGHOFacilitatorCapacity/AaveV3Ethereum_IncreaseGHOFacilitatorCapacity_20240722.t.sol -vv
 */
contract AaveV3Ethereum_IncreaseGHOFacilitatorCapacity_20240722_Test is ProtocolV3TestBase {
  AaveV3Ethereum_IncreaseGHOFacilitatorCapacity_20240722 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20390936);
    proposal = new AaveV3Ethereum_IncreaseGHOFacilitatorCapacity_20240722();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_newLimitIsSet() public {
    // Current limit is 1M
    assertEq(
      IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL).getBridgeLimit(),
      2_500_000 ether
    );

    executePayload(vm, address(proposal));

    assertEq(
      IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL).getBridgeLimit(),
      proposal.NEW_LIMIT()
    );
  }
}
