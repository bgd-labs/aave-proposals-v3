// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Freeze wstETH on Plasma
 * @author Lido (implemented by ACI via Skyward)
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/direct-to-aip-freeze-wsteth-on-plasma/23400
 */
contract AaveV3Plasma_FreezeWstETHOnPlasma_20251111 is IProposalGenericExecutor {
  function execute() external {
    AaveV3Plasma.POOL_CONFIGURATOR.setReserveFreeze(AaveV3PlasmaAssets.wstETH_UNDERLYING, true);
  }
}
