// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Set ACI as Emission Manager for wAVAX on the Avalanche network
 * @author ACI
 * - Discussion: https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898/4
 */
contract AaveV3Avalanche_SetACIAsEmissionManagerForWAVAXOnTheAvalancheNetwork_20240620 is
  IProposalGenericExecutor
{
  address public constant AVAX_EMISSION_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;
  address public constant GGAVAX = 0xA25EaF2906FA1a3a13EdAc9B9657108Af7B703e3;

  function execute() external {
    IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).setEmissionAdmin(
      AaveV3AvalancheAssets.WAVAX_UNDERLYING,
      AVAX_EMISSION_ADMIN
    );
    IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).setEmissionAdmin(
      AaveV3AvalancheAssets.sAVAX_UNDERLYING,
      AVAX_EMISSION_ADMIN
    );
    IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).setEmissionAdmin(
      GGAVAX,
      AVAX_EMISSION_ADMIN
    );
  }
}
