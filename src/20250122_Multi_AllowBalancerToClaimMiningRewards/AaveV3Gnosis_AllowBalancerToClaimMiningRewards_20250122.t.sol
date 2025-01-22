// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IERC20AaveLM} from 'aave-v3-origin/contracts/extensions/stata-token/interfaces/IERC20AaveLM.sol';

import {AaveV3Gnosis_AllowBalancerToClaimMiningRewards_20250122} from './AaveV3Gnosis_AllowBalancerToClaimMiningRewards_20250122.sol';

/**
 * @dev Test for AaveV3Gnosis_AllowBalancerToClaimMiningRewards_20250122
 * command: FOUNDRY_PROFILE=gnosis forge test --match-path=src/20250122_Multi_AllowBalancerToClaimMiningRewards/AaveV3Gnosis_AllowBalancerToClaimMiningRewards_20250122.t.sol -vv
 */
contract AaveV3Gnosis_AllowBalancerToClaimMiningRewards_20250122_Test is ProtocolV3TestBase {
  AaveV3Gnosis_AllowBalancerToClaimMiningRewards_20250122 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 38172377);
    proposal = new AaveV3Gnosis_AllowBalancerToClaimMiningRewards_20250122();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_AllowBalancerToClaimMiningRewards_20250122',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }
}
