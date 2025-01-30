// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Allow Balancer To Claim Mining Rewards
 * @author @TokenLogic, @BGDLabs
 * - Snapshot: https://snapshot.org/#/s:aave.eth/proposal/0x054d40462303edd7e3a3c90b945a187e037cf412751631e9b01ba536acbdd40b
 * - Discussion: https://governance.aave.com/t/arfc-whitelist-balancer-dao-to-claim-liquidity-mining-rewards/20653
 */
contract AaveV3Multi_AllowBalancerToClaimMiningRewards_20250122 is IProposalGenericExecutor {
  address public immutable CLAIMER;
  address public immutable BALANCER_VAULT;
  address public immutable EMISSION_MANAGER;

  constructor(address claimer, address vault, address manager) {
    CLAIMER = claimer;
    BALANCER_VAULT = vault;
    EMISSION_MANAGER = manager;
  }

  function execute() external {
    IEmissionManager(EMISSION_MANAGER).setClaimer(BALANCER_VAULT, CLAIMER);
  }
}
