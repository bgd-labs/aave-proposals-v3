// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Base, AaveV3BaseAssets, AaveV3BaseEModes} from 'aave-address-book/AaveV3Base.sol';

/**
 * @title WETH LTV Restoration Across V3 Instances
 * @author Aave Labs
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-weth-unfreeze-and-ltv-restoration-across-aave-v3-instances/24878
 */
contract AaveV3Base_WETHLTVRestorationAcrossV3Instances_20260511 is IProposalGenericExecutor {
  uint8 public constant ETH_EMODE_ID = AaveV3BaseEModes.WETH_cbETH_wstETH_weETH__WETH;

  function execute() external {
    address weth = AaveV3BaseAssets.WETH_UNDERLYING;
    AaveV3Base.POOL_CONFIGURATOR.setReserveLtvzero({asset: weth, ltvzero: false});
    AaveV3Base.POOL_CONFIGURATOR.setAssetLtvzeroInEMode({
      asset: weth,
      categoryId: ETH_EMODE_ID,
      ltvzero: false
    });
  }
}
