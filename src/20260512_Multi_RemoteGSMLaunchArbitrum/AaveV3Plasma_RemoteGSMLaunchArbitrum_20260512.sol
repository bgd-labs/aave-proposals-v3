// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GhoPlasma} from 'aave-address-book/GhoPlasma.sol';
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
contract AaveV3Plasma_RemoteGSMLaunchArbitrum_20260512 is IProposalGenericExecutor {
  using SafeCast for uint256;

  function execute() external {
    // Increase bucket capacity to allow token movements to Plasma, accounting for the extra capacity initially bridged
    // to Arbitrum in this proposal.
    (uint256 currentFacilitatorBucketCapacity, ) = IGhoToken(GhoPlasma.GHO_TOKEN)
      .getFacilitatorBucket(GhoPlasma.GHO_CCIP_TOKEN_POOL);

    IGhoToken(GhoPlasma.GHO_TOKEN).setFacilitatorBucketCapacity(
      GhoPlasma.GHO_CCIP_TOKEN_POOL,
      currentFacilitatorBucketCapacity.toUint128() +
        RemoteGSMLaunchArbitrumSetup.GHO_BRIDGE_AMOUNT.toUint128()
    );

    // Normalize all GHO lanes rate-limit config to canonical defaults.
    RemoteGSMLaunchArbitrumSetup.normalizeIORateLimitsForAllNetworks(
      GhoPlasma.GHO_CCIP_TOKEN_POOL,
      CCIPChainSelectors.PLASMA
    );
  }
}
