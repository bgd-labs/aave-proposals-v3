// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GhoPlasma} from 'aave-address-book/GhoPlasma.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';
import {IUpgradeableBurnMintTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Add GHO and deploy GSM on Plasma.
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xeb3572580924976867073ad9c8012cb9e52093c76dafebd7d3aebf318f2576fb
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-plasma-set-aci-as-emissions-manager-for-rewards/22994/6
 */
contract AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part1 is
  IProposalGenericExecutor
{
  uint128 public constant DEFAULT_RATE_LIMITER_CAPACITY = 1_500_000e18;
  uint128 public constant DEFAULT_RATE_LIMITER_RATE = 300e18;

  // 50M GHO to be bridged, add 10% leeway initially in case other bridges take place
  uint256 public constant NEW_CAPACITY = 55_000_000 ether;

  function execute() external {
    IUpgradeableBurnMintTokenPool(GhoPlasma.GHO_CCIP_TOKEN_POOL).setChainRateLimiterConfig(
      CCIPChainSelectors.ETHEREUM,
      IRateLimiter.Config({
        isEnabled: true,
        capacity: DEFAULT_RATE_LIMITER_CAPACITY,
        rate: DEFAULT_RATE_LIMITER_RATE
      }),
      IRateLimiter.Config({
        isEnabled: true,
        capacity: uint128(NEW_CAPACITY),
        rate: uint128(NEW_CAPACITY) - 1 // Set rate to capacity so it fills to limit right away (-1 because they cannot be the same)
      })
    );
  }
}
