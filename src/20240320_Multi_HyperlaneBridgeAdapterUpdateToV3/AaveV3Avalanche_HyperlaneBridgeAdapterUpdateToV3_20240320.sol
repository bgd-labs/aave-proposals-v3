// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import 'aave-helpers/adi/SimpleOneToManyAdapterUpdate.sol';

/**
 * @title Hyperlane bridge adapter update to V3
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/31
 */
contract AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320 is
  SimpleOneToManyAdapterUpdate(
    SimpleOneToManyAdapterUpdate.ConstructorInput({
      ccc: GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER,
      newAdapter: 0x617332a777780F546261247F621051d0b98975Eb,
      adapterToRemove: 0xa198Fac58E02A5C5F8F7e877895d50cFa9ad1E04
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
