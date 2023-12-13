// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2EthereumAMM} from 'aave-address-book/AaveV2EthereumAMM.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @title Sync emergency admin on v2 AMM
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/10
 */
contract AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207 is IProposalGenericExecutor {
  function execute() external {
    AaveV2EthereumAMM.POOL_ADDRESSES_PROVIDER.setEmergencyAdmin(MiscEthereum.PROTOCOL_GUARDIAN);
  }
}
