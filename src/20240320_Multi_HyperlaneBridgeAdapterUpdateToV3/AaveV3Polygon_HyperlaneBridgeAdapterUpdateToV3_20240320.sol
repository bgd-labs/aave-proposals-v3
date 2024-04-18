// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/adi/SimpleOneToManyAdapterUpdate.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title Hyperlane bridge adapter update to V3
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/31
 */
contract AaveV3Polygon_HyperlaneBridgeAdapterUpdateToV3_20240320 is
  SimpleOneToManyAdapterUpdate(
    SimpleOneToManyAdapterUpdate.ConstructorInput({
      ccc: GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER,
      newAdapter: 0x3e72665008dC237bdd91C04C10782Ed1987a4019,
      adapterToRemove: 0x3c25b96fF62D21E90556869272a277eE2E229747
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

    destinationAdapters[0].adapter = 0x01dcb90Cf13b82Cde4A0BAcC655585a83Af3cCC1;
    destinationAdapters[0].chainId = ChainIds.MAINNET;

    return destinationAdapters;
  }
}
