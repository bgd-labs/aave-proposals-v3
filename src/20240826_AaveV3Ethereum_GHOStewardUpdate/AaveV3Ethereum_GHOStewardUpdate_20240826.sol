// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IGhoStewardV2} from './interfaces/IGhoStewardV2.sol';
import {IGhoToken} from './interfaces/IGho.sol';
import {IGsm} from './interfaces/IGSM.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @title GHO Steward Update
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: TODO
 */
contract AaveV3Ethereum_GHOStewardUpdate_20240826 is IProposalGenericExecutor {
  address public constant GHO_STEWARD = 0x1180eE41eC15Dd0accC13a1e646B3152bECFf8F6;
  address public constant OLD_GHO_STEWARD = 0xb9481a29f0f996BCAc759aB201FB3844c81866c4;

  function execute() external {
    // Remove Risk admin role to the old steward
    AaveV3Ethereum.ACL_MANAGER.removeRiskAdmin(OLD_GHO_STEWARD);

    // Revoke old steward's bucket manager role
    IGhoToken(MiscEthereum.GHO_TOKEN).revokeRole(
      IGhoToken(MiscEthereum.GHO_TOKEN).BUCKET_MANAGER_ROLE(),
      OLD_GHO_STEWARD
    );

    // Revoke old steward's configurator role on usdc, usdt gsm
    IGsm(MiscEthereum.GSM_USDC).revokeRole(
      IGsm(MiscEthereum.GSM_USDC).CONFIGURATOR_ROLE(),
      OLD_GHO_STEWARD
    );
    IGsm(MiscEthereum.GSM_USDT).revokeRole(
      IGsm(MiscEthereum.GSM_USDT).CONFIGURATOR_ROLE(),
      OLD_GHO_STEWARD
    );

    // Give Risk admin role to the new steward
    AaveV3Ethereum.ACL_MANAGER.addRiskAdmin(GHO_STEWARD);

    // Give bucket manager role to the new steward
    IGhoToken(MiscEthereum.GHO_TOKEN).grantRole(
      IGhoToken(MiscEthereum.GHO_TOKEN).BUCKET_MANAGER_ROLE(),
      GHO_STEWARD
    );

    // Give configurator role on usdc, usdt gsm to the new steward
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
