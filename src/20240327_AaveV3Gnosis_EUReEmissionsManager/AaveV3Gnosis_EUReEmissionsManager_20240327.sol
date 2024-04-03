// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title EURe Emissions Manager
 * @author Aave Chan Initiative
 * - Discussion: https://governance.aave.com/t/arfc-set-aci-as-emissions-manager-for-eure-on-aave-v3-gnosis-market/17130
 */
contract AaveV3Gnosis_EUReEmissionsManager_20240327 is IProposalGenericExecutor {
  address public constant EURe_EMISSION_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function execute() external {
    IEmissionManager(AaveV3Gnosis.EMISSION_MANAGER).setEmissionAdmin(
      AaveV3GnosisAssets.EURe_UNDERLYING,
      EURe_EMISSION_ADMIN
    );
  }
}
