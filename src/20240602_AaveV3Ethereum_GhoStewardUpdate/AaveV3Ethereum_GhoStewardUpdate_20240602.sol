// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IGhoStewardV2} from './interfaces/IGhoStewardV2.sol';
import {IGhoToken} from './interfaces/IGho.sol';
import {IGsm} from './interfaces/IGSM.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @title Gho Steward Update
 * @author ACI
 * - Discussion: https://governance.aave.com/t/arfc-gho-stewards/16466/11
 */
contract AaveV3Ethereum_GhoStewardUpdate_20240602 is IProposalGenericExecutor {
  address public constant OLD_GHO_STEWARD = 0x8F2411a538381aae2b464499005F0211e867d84f;
  address public constant GHO_STEWARD = 0x138d0f32C4D2eD3d4eEB37B1A059e56aFde87AB5;

  function execute() external {
    // Remove Pool admin role to the old steward
    AaveV3Ethereum.ACL_MANAGER.removePoolAdmin(OLD_GHO_STEWARD);

    // Give Risk admin role to the steward
    AaveV3Ethereum.ACL_MANAGER.addRiskAdmin(GHO_STEWARD);

    // Give bucket manager role to the steward
    IGhoToken(MiscEthereum.GHO_TOKEN).grantRole(
      IGhoToken(MiscEthereum.GHO_TOKEN).BUCKET_MANAGER_ROLE(),
      GHO_STEWARD
    );

    // Give configurator role on usdc, usdt gsm to the stewards
    IGsm(MiscEthereum.GSM_USDC).grantRole(
      IGsm(MiscEthereum.GSM_USDC).CONFIGURATOR_ROLE(),
      GHO_STEWARD
    );
    IGsm(MiscEthereum.GSM_USDT).grantRole(
      IGsm(MiscEthereum.GSM_USDT).CONFIGURATOR_ROLE(),
      GHO_STEWARD
    );

    // Whitelist all the facilitators on the stewards, including: GhoAToken, GhoFlashMinter, GSM USDC, GSM USDT
    IGhoStewardV2(GHO_STEWARD).setControlledFacilitator(
      IGhoToken(MiscEthereum.GHO_TOKEN).getFacilitatorsList(),
      true
    );
  }
}
