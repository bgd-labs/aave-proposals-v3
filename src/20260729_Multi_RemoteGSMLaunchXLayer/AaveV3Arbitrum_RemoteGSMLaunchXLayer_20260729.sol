// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';

import {RemoteGSMLaunchXLayerFacilitatorProposalBase} from './setup/RemoteGSMLaunchXLayerFacilitatorProposalBase.sol';

/**
 * @title Remote GSM Launch: XLayer
 * @author TokenLogic
 * - Snapshot: TODO_SNAPSHOT_PENDING
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-v3-on-x-layer/23175
 */
contract AaveV3Arbitrum_RemoteGSMLaunchXLayer_20260729 is
  RemoteGSMLaunchXLayerFacilitatorProposalBase
{
  function GHO_TOKEN() public pure override returns (address) {
    return GhoArbitrum.GHO_TOKEN;
  }

  function GHO_CCIP_TOKEN_POOL() public pure override returns (address) {
    return GhoArbitrum.GHO_CCIP_TOKEN_POOL;
  }
}
