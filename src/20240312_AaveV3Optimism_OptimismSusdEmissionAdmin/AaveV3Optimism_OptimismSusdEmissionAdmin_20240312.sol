// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Optimism susd Emission Admin
 * @author Aave Chan Initiative
 * - Snapshot: https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-susd-on-aave-v3-optimism/16867
 * - Discussion: https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-susd-on-aave-v3-optimism/16867
 */
contract AaveV3Optimism_OptimismSusdEmissionAdmin_20240312 is IProposalGenericExecutor {
  address public constant sUSD_EMISSION_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function execute() external {
    IEmissionManager(AaveV3Optimism.EMISSION_MANAGER).setEmissionAdmin(
      AaveV3OptimismAssets.sUSD_UNDERLYING,
      sUSD_EMISSION_ADMIN
    );
  }
}
