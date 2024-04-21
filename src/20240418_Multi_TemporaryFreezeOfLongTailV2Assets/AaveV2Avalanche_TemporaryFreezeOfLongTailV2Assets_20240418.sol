// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
/**
 * @title Temporary Freeze of Long-Tail V2 Assets
 * @author Chaos Labs
 * - Discussion: https://governance.aave.com/t/arfc-temporary-freeze-of-long-tail-v2-assets/17403
 */
contract AaveV2Avalanche_TemporaryFreezeOfLongTailV2Assets_20240418 is IProposalGenericExecutor {
  function execute() external {
    AaveV2Avalanche.POOL_CONFIGURATOR.freezeReserve(AaveV2AvalancheAssets.AAVEe_UNDERLYING);
  }
}
