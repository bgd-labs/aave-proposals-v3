// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GhoInk} from 'aave-address-book/GhoInk.sol';

import {RemoteGSMLaunchXLayerFacilitatorProposalBase} from './setup/RemoteGSMLaunchXLayerFacilitatorProposalBase.sol';

/**
 * @title Remote GSM Launch: XLayer
 * @author TokenLogic
 * - Snapshot: TODO_SNAPSHOT_PENDING
 * - Discussion: TODO_FORUM_POST_PENDING
 */
contract AaveV3Ink_RemoteGSMLaunchXLayer_20260729 is RemoteGSMLaunchXLayerFacilitatorProposalBase {
  function GHO_TOKEN() public pure override returns (address) {
    return GhoInk.GHO_TOKEN;
  }

  function GHO_CCIP_TOKEN_POOL() public pure override returns (address) {
    return GhoInk.GHO_CCIP_TOKEN_POOL;
  }
}
