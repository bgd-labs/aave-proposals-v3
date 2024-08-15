// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

interface UpgradeableLockReleaseTokenPool {
  function setBridgeLimit(uint256 limit) external;
}
/**
 * @title Increase GHO Facilitator Capacity
 * @author @karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-gho-arb-increase-ccip-facilitator-capacity/18386
 */
contract AaveV3Ethereum_IncreaseGHOFacilitatorCapacity_20240722 is IProposalGenericExecutor {
  uint256 public constant NEW_LIMIT = 20_000_000 ether;

  function execute() external {
    UpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL).setBridgeLimit(NEW_LIMIT);
  }
}
