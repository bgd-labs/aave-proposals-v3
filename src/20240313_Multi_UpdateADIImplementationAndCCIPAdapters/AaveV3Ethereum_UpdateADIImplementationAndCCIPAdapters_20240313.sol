// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {BaseAdaptersUpdatePayload} from './BaseAdaptersUpdatePayload.sol';

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/21
 */
contract AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      proxyAdmin: MiscEthereum.PROXY_ADMIN,
      newCCCImplementation: 0x28559c2F4B038b1E836fA419DCcDe7454d8Fe215,
      ccipNewAdapter: 0xB7a6618df58626C3a122ABAFD6Ee63Af63f3Ef29,
      ccipAdapterToRemove: 0xDB8953194810b1942544fA528791278D458719D5
    })
  )
{
  function getChainsToReceive() public pure override returns (uint256[] memory) {
    uint256[] memory chains = new uint256[](2);
    chains[0] = ChainIds.AVALANCHE;
    chains[1] = ChainIds.POLYGON;
    return chains;
  }

  function getDestinationAdapters()
    public
    pure
    override
    returns (DestinationAdaptersInput[] memory)
  {
    DestinationAdaptersInput[] memory destinationAdapters = new DestinationAdaptersInput[](3);

    destinationAdapters[0].adapter = 0x2b88C83727B0E290B76EB3F6133994fF81B7f355;
    destinationAdapters[0].chainId = ChainIds.AVALANCHE;

    destinationAdapters[1].adapter = 0xe79757D55a1600eF28D816a893E78E9FCDE2019E;
    destinationAdapters[1].chainId = ChainIds.POLYGON;

    destinationAdapters[2].adapter = 0xAE93BEa44dcbE52B625169588574d31e36fb3A67;
    destinationAdapters[2].chainId = ChainIds.BNB;

    return destinationAdapters;
  }
}
