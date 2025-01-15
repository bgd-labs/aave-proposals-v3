// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

/**
 * @title Enable balancer claimer
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Gnosis_EnableBalancerClaimer_20250115 is IProposalGenericExecutor {
  address public immutable CLAIMER = 0x9ff471F9f98F42E5151C7855fD1b5aa906b1AF7e;
  address public immutable BALANCER_VAULT = 0xbA1333333333a1BA1108E8412f11850A5C319bA9;

  function execute() external {
    IEmissionManager(AaveV3Gnosis.EMISSION_MANAGER).setClaimer(BALANCER_VAULT, CLAIMER);
  }
}
