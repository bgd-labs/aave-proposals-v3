// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Allow Balancer To Claim Mining Rewards
 * @author @TokenLogic, @BGDLabs
 * - Snapshot: https://snapshot.org/#/s:aave.eth/proposal/0x054d40462303edd7e3a3c90b945a187e037cf412751631e9b01ba536acbdd40b
 * - Discussion: https://governance.aave.com/t/arfc-whitelist-balancer-dao-to-claim-liquidity-mining-rewards/20653
 */
contract AaveV3Gnosis_AllowBalancerToClaimMiningRewards_20250122 is IProposalGenericExecutor {
  address public immutable CLAIMER = 0x9ff471F9f98F42E5151C7855fD1b5aa906b1AF7e;
  address public immutable BALANCER_VAULT = 0xbA1333333333a1BA1108E8412f11850A5C319bA9;

  function execute() external {
    IEmissionManager(AaveV3Gnosis.EMISSION_MANAGER).setClaimer(BALANCER_VAULT, CLAIMER);
  }
}
