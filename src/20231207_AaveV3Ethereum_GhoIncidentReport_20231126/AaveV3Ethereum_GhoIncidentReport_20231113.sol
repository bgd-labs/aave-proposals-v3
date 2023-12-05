// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IERC20} from 'forge-std/interfaces/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title GHO update on Aave V3 Ethereum Pool for 13/11/2023 Report
 * @dev Upgrades the implementation of the GhoVariableDebtToken contract
 * @author Aave Labs (@aave)
 * - Discussion: https://governance.aave.com/t/arfc-gho-technical-incident-13-11-2023/15642
 */
contract AaveV3Ethereum_GhoIncidentReport_20231113 {
  address public immutable NEW_VGHO_IMPL;

  constructor(address newVGhoImpl) {
    NEW_VGHO_IMPL = newVGhoImpl;
  }

  function execute() external {
    AaveV3Ethereum.POOL_CONFIGURATOR.updateVariableDebtToken(
      ConfiguratorInputTypes.UpdateDebtTokenInput({
        asset: AaveV3EthereumAssets.GHO_UNDERLYING,
        incentivesController: AaveV3Ethereum.DEFAULT_INCENTIVES_CONTROLLER,
        name: IERC20(AaveV3EthereumAssets.GHO_V_TOKEN).name(),
        symbol: IERC20(AaveV3EthereumAssets.GHO_V_TOKEN).symbol(),
        implementation: NEW_VGHO_IMPL,
        params: bytes('')
      })
    );
  }
}
