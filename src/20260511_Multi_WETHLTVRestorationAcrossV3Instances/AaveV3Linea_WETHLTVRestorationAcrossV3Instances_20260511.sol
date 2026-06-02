// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Linea, AaveV3LineaAssets} from 'aave-address-book/AaveV3Linea.sol';

/**
 * @title WETH LTV Restoration Across V3 Instances
 * @author Aave Labs
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-weth-unfreeze-and-ltv-restoration-across-aave-v3-instances/24878
 */
contract AaveV3Linea_WETHLTVRestorationAcrossV3Instances_20260511 is IProposalGenericExecutor {
  function execute() external {
    AaveV3Linea.POOL_CONFIGURATOR.setReserveLtvzero({
      asset: AaveV3LineaAssets.WETH_UNDERLYING,
      ltvzero: false
    });
  }
}
