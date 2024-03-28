// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {BaseAdaptersUpdatePayload} from './BaseAdaptersUpdatePayload.sol';

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/21
 */
contract AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER,
      proxyAdmin: MiscPolygon.PROXY_ADMIN,
      newCCCImplementation: 0x87a95917DE670088d81B9a8B30E3B36704Ba3043,
      ccipNewAdapter: 0xe79757D55a1600eF28D816a893E78E9FCDE2019E,
      ccipAdapterToRemove: 0x95Fa2c817169E26956AB8795c84a225b55d7db5B
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
