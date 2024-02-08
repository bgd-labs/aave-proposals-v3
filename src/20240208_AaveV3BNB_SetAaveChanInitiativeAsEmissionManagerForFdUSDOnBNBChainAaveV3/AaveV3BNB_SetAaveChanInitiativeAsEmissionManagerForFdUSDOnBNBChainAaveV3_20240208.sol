// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Set Aave Chan Initiative as Emission Manager for fdUSD on BNB Chain Aave V3
 * @author  Aave Chan Initiative (ACI)
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-fdusd-on-bnb-chain-aave-v3/16558
 */
contract AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208 is
  IProposalGenericExecutor
{
  address constant EMISSION_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;
  address constant FDUSD_ADDRESS = 0xc5f0f7b66764F6ec8C8Dff7BA683102295E16409;

  function execute() external {
    IEmissionManager(AaveV3BNB.EMISSION_MANAGER).setEmissionAdmin(FDUSD_ADDRESS, EMISSION_ADMIN);
  }
}
