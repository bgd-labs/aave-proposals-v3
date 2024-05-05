// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/adi/SimpleOneToManyAdapterUpdate.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title Hyperlane bridge adapter update to V3
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/31
 */
contract AaveV3Ethereum_HyperlaneBridgeAdapterUpdateToV3_20240320 is
  SimpleOneToManyAdapterUpdate(
    SimpleOneToManyAdapterUpdate.ConstructorInput({
      ccc: GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      newAdapter: 0x01dcb90Cf13b82Cde4A0BAcC655585a83Af3cCC1,
      adapterToRemove: 0x6Abb61beb5848B476d026C4934E8a6415e2E75a8
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
    DestinationAdaptersInput[] memory destinationAdapters = new DestinationAdaptersInput[](4);

    destinationAdapters[0].adapter = 0x617332a777780F546261247F621051d0b98975Eb;
    destinationAdapters[0].chainId = ChainIds.AVALANCHE;

    destinationAdapters[1].adapter = 0x3e72665008dC237bdd91C04C10782Ed1987a4019;
    destinationAdapters[1].chainId = ChainIds.POLYGON;

    destinationAdapters[2].adapter = 0x3F006299eC88985c18E6e885EeA29A49eC579882;
    destinationAdapters[2].chainId = ChainIds.BNB;

    destinationAdapters[3].adapter = 0xA806DA549FcB2B4912a7dFFE4c1aA7A1ed0Bd5C9;
    destinationAdapters[3].chainId = ChainIds.GNOSIS;

    return destinationAdapters;
  }
}
