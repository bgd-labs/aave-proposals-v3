// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {IEmissionManager} from '@aave/periphery-v3/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Assign Emission Admin - Ethereum, Arbitrum and Optimism
 * @author karpatkey-TokenLogic & ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x66040ad4d46ba756365fbe5c2ed5957d17a3e70db5a00ec532fdc725251d2327
 * - Discussion: https://governance.aave.com/t/arfc-set-op-emission-admin/16621
 */
contract AaveV3Optimism_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229 is
  IProposalGenericExecutor
{
  IEmissionManager public constant EMISSION_MANAGER =
    IEmissionManager(AaveV3Optimism.EMISSION_MANAGER);
  address public constant EMISSION_ADMIN = 0x3479CEb4b1fcaDC586d4c5F1c16b4d8c0D70Bc71;

  function execute() external {
    EMISSION_MANAGER.setEmissionAdmin(AaveV3OptimismAssets.OP_UNDERLYING, EMISSION_ADMIN);
  }
}
