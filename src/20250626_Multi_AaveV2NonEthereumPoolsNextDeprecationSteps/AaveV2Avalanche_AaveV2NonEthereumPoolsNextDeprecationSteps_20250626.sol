// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';

/**
 * @title Aave v2 non-Ethereum pools next deprecation steps
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/direct-to-aip-aave-v2-non-ethereum-pools-next-deprecation-steps/22445
 */
contract AaveV2Avalanche_AaveV2NonEthereumPoolsNextDeprecationSteps_20250626 is
  IProposalGenericExecutor
{
  function execute() external {
    address[] memory reservesToFreeze = new address[](5);
    reservesToFreeze[0] = AaveV2AvalancheAssets.DAIe_UNDERLYING;
    reservesToFreeze[1] = AaveV2AvalancheAssets.USDCe_UNDERLYING;
    reservesToFreeze[2] = AaveV2AvalancheAssets.USDTe_UNDERLYING;
    reservesToFreeze[3] = AaveV2AvalancheAssets.WAVAX_UNDERLYING;
    reservesToFreeze[4] = AaveV2AvalancheAssets.WETHe_UNDERLYING;

    for (uint256 i = 0; i < reservesToFreeze.length; i++) {
      AaveV2Avalanche.POOL_CONFIGURATOR.freezeReserve(reservesToFreeze[i]);
    }
  }
}
