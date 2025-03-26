// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Allow Balancer DAO to Claim Liquidity Mining Rewards (Arbitrum & Base)
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-whitelist-balancer-dao-to-claim-liquidity-mining-rewards-arbitrum-base/21280
 */
contract AaveV3Multi_AllowBalancerDAOToClaimLiquidityMiningRewards_20250318 is
  IProposalGenericExecutor
{
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
