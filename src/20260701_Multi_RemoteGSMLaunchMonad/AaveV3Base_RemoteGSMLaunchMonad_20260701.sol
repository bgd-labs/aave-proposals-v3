// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GhoBase} from 'aave-address-book/GhoBase.sol';

import {RemoteGSMLaunchMonadFacilitatorProposalBase} from './setup/RemoteGSMLaunchMonadFacilitatorProposalBase.sol';

/**
 * @title Remote GSM Launch: Monad
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-protocol-v3-7-on-monad/24943
 */
contract AaveV3Base_RemoteGSMLaunchMonad_20260701 is RemoteGSMLaunchMonadFacilitatorProposalBase {
  function GHO_TOKEN() public pure override returns (address) {
    return GhoBase.GHO_TOKEN;
  }

  function GHO_CCIP_TOKEN_POOL() public pure override returns (address) {
    return GhoBase.GHO_CCIP_TOKEN_POOL;
  }
}
