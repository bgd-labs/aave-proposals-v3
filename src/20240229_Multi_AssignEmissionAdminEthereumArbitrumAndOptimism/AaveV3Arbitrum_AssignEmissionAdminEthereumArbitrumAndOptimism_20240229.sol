// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IEmissionManager} from '@aave/periphery-v3/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Assign Emission Admin - Ethereum, Arbitrum and Optimism
 * @author karpatkey-TokenLogic & ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4518ee2130b2299fdf0827aa6a97b8211b3273f5b07b6f13b8141e5b9ad89e5f
 * - Discussion: https://governance.aave.com/t/arfc-set-arb-emission-admin-to-gauntlet/16554
 */
contract AaveV3Arbitrum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229 is
  IProposalGenericExecutor
{
  IEmissionManager public constant EMISSION_MANAGER =
    IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER);
  address public constant EMISSION_ADMIN = 0xE79C65a313a1f4Ca5D1d15414E0c515056dA90b4;

  function execute() external {
    EMISSION_MANAGER.setEmissionAdmin(AaveV3ArbitrumAssets.ARB_UNDERLYING, EMISSION_ADMIN);
  }
}
