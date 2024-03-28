// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IGhoStewardV2} from './interfaces/IGhoStewardV2.sol';
import {IGhoToken} from './interfaces/IGho.sol';
import {IGsm} from './interfaces/IGsm.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @title Activate Gho Stewards
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x29f63b24638ee822f88632572ca4b061774771c0cc6d0ae5ccdeb538177232cd
 * - Discussion: https://governance.aave.com/t/arfc-gho-stewards-borrow-rate-update/16956
 */
contract AaveV3Ethereum_ActivateGhoStewards_20240326 is IProposalGenericExecutor {
  address public constant GHO_STEWARD = 0x8F2411a538381aae2b464499005F0211e867d84f;
  address public constant GSM_USDC = 0x0d8eFfC11dF3F229AA1EA0509BC9DFa632A13578;
  address public constant GSM_USDT = 0x686F8D21520f4ecEc7ba577be08354F4d1EB8262;

  function execute() external {
    // Give risk admin role to the steward
    AaveV3Ethereum.ACL_MANAGER.addRiskAdmin(GHO_STEWARD);

    // Give bucket manager role to the steward
    IGhoToken(MiscEthereum.GHO_TOKEN).grantRole(
      IGhoToken(MiscEthereum.GHO_TOKEN).BUCKET_MANAGER_ROLE(),
      GHO_STEWARD
    );

    // Give configurator role on usdc, usdt gsm to the stewards
    IGsm(GSM_USDC).grantRole(IGsm(GSM_USDC).CONFIGURATOR_ROLE(), GHO_STEWARD);
    IGsm(GSM_USDT).grantRole(IGsm(GSM_USDT).CONFIGURATOR_ROLE(), GHO_STEWARD);

    // Whitelist all the facilitators on the stewards, including: GhoAToken, GhoFlashMinter, GSM USDC, GSM USDT
    IGhoStewardV2(GHO_STEWARD).setControlledFacilitator(
      IGhoToken(MiscEthereum.GHO_TOKEN).getFacilitatorsList(),
      true
    );
  }
}
