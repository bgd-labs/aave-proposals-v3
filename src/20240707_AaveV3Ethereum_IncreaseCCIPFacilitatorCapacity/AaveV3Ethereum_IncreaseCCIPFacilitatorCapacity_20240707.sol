// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

interface UpgradeableLockReleaseTokenPool {
  function setBridgeLimit(uint256 limit) external;
}

/**
 * @title Increase CCIP Facilitator Capacity
 * @author @karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-gho-arb-increase-ccip-facilitator-capacity/18169
 */
contract AaveV3Ethereum_IncreaseCCIPFacilitatorCapacity_20240707 is IProposalGenericExecutor {
  address public constant GHO_TOKEN_POOL = 0x5756880B6a1EAba0175227bf02a7E87c1e02B28C;
  uint256 public constant NEW_LIMIT = 2_500_000 ether;
  function execute() external {
    UpgradeableLockReleaseTokenPool(GHO_TOKEN_POOL).setBridgeLimit(NEW_LIMIT);
  }
}
