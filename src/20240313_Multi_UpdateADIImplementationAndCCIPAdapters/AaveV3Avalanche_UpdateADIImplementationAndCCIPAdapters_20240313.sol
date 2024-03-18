// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {BaseAdaptersUpdatePayload} from './BaseAdaptersUpdatePayload.sol';

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/21
 */
contract AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER,
      proxyAdmin: MiscAvalanche.PROXY_ADMIN,
      newCCCImplementation: 0x5Ef80c5eB6CF65Dab8cD1C0ee258a6D2bD38Bd22,
      ccipNewAdapter: 0x2b88C83727B0E290B76EB3F6133994fF81B7f355,
      ccipAdapterToRemove: 0x3F006299eC88985c18E6e885EeA29A49eC579882
    })
  )
{
  function getChainsToReceive() public pure override returns (uint256[] memory) {
    uint256[] memory chains = new uint256[](1);
    chains[0] = ChainIds.MAINNET;
    return chains;
  }

  function getDestinationAdapters()
    public
    pure
    override
    returns (DestinationAdaptersInput[] memory)
  {
    DestinationAdaptersInput[] memory destinationAdapters = new DestinationAdaptersInput[](1);

    destinationAdapters[0].adapter = 0xB7a6618df58626C3a122ABAFD6Ee63Af63f3Ef29;
    destinationAdapters[0].chainId = ChainIds.MAINNET;

    return destinationAdapters;
  }
}
