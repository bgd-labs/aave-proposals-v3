// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets, AaveV3ArbitrumEModes} from 'aave-address-book/AaveV3Arbitrum.sol';

/**
 * @title WETH LTV Restoration Across V3 Instances
 * @author Aave Labs
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-weth-unfreeze-and-ltv-restoration-across-aave-v3-instances/24878
 */
contract AaveV3Arbitrum_WETHLTVRestorationAcrossV3Instances_20260511 is IProposalGenericExecutor {
  uint8 public constant ETH_EMODE_ID = AaveV3ArbitrumEModes.WETH_wstETH_weETH__WETH;

  function execute() external {
    address weth = AaveV3ArbitrumAssets.WETH_UNDERLYING;
    AaveV3Arbitrum.POOL_CONFIGURATOR.setReserveLtvzero({asset: weth, ltvzero: false});
    AaveV3Arbitrum.POOL_CONFIGURATOR.setAssetLtvzeroInEMode({
      asset: weth,
      categoryId: ETH_EMODE_ID,
      ltvzero: false
    });
  }
}
