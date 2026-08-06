// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GhoMonad} from 'aave-address-book/GhoMonad.sol';
import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';

import {RemoteGSMLaunchArbitrumSetup} from './setup/RemoteGSMLaunchArbitrumSetup.sol';

/**
 * @title Remote GSM Launch: Arbitrum
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xf24321514fb593af9e5082d26a1358819ec0f648db8fdb5c2b083f53ef785793
 * - Discussion: https://governance.aave.com/t/arfc-launch-remotegsm-on-arbitrum/24986
 */
contract AaveV3Monad_RemoteGSMLaunchArbitrum_20260512 is IProposalGenericExecutor {
  using SafeCast for uint256;

  function execute() external {
    // Increase bucket capacity to allow token movements to Monad, accounting for the extra capacity initially bridged
    // to Arbitrum in this proposal.
    (uint256 currentFacilitatorBucketCapacity, ) = IGhoToken(GhoMonad.GHO_TOKEN)
      .getFacilitatorBucket(GhoMonad.GHO_CCIP_TOKEN_POOL);

    IGhoToken(GhoMonad.GHO_TOKEN).setFacilitatorBucketCapacity(
      GhoMonad.GHO_CCIP_TOKEN_POOL,
      currentFacilitatorBucketCapacity.toUint128() +
        RemoteGSMLaunchArbitrumSetup.GHO_BRIDGE_AMOUNT.toUint128()
    );

    // Normalize all GHO lanes rate-limit config to canonical defaults.
    RemoteGSMLaunchArbitrumSetup.normalizeIORateLimitsForAllNetworks(
      GhoMonad.GHO_CCIP_TOKEN_POOL,
      CCIPChainSelectors.MONAD
    );
  }
}
