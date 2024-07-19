// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {IGhoToken} from 'gho-core/gho/interfaces/IGhoToken.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Increase CCIP Facilitator Capacity
 * @author @karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-gho-arb-increase-ccip-facilitator-capacity/18169
 */
contract AaveV3Arbitrum_IncreaseCCIPFacilitatorCapacity_20240707 is IProposalGenericExecutor {
  uint128 public constant NEW_LIMIT = 2_500_000 ether;

  function execute() external {
    IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).setFacilitatorBucketCapacity(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL,
      NEW_LIMIT
    );
  }
}
