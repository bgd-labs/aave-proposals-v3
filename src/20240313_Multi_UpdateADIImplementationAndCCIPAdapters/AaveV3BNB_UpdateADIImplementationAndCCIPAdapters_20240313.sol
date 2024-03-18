// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';
import {GovernanceV3BNB} from 'aave-address-book/GovernanceV3BNB.sol';
import {BaseAdaptersUpdatePayload} from './BaseAdaptersUpdatePayload.sol';

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/21
 */
contract AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3BNB.CROSS_CHAIN_CONTROLLER,
      proxyAdmin: MiscBNB.PROXY_ADMIN,
      newCCCImplementation: 0xf41193E25408F652AF878c47E4401A01B5E4B682,
      ccipNewAdapter: 0xAE93BEa44dcbE52B625169588574d31e36fb3A67,
      ccipAdapterToRemove: 0x746c675dAB49Bcd5BB9Dc85161f2d7Eb435009bf
    })
  )
{
  function getChainsToReceive() public pure override returns (uint256[] memory) {
    uint256[] memory chains = new uint256[](1);
    chains[0] = ChainIds.MAINNET;
    return chains;
  }
}
