// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseAdaptersUpdatePayload} from './BaseAdaptersUpdatePayload.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title LayerZero bridge adapter update to V2
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/29
 */
contract AaveV3Polygon_LayerZeroBridgeAdapterUpdateToV2_20240322 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER,
      lzNewAdapter: 0x7FAE7765abB4c8f778d57337bB720d0BC53057e3,
      lzAdapterToRemove: 0xDA4B6024aA06f7565BBcAaD9B8bE24C3c229AAb5
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

    destinationAdapters[0].adapter = 0x8410d9BD353b420ebA8C48ff1B0518426C280FCC;
    destinationAdapters[0].chainId = ChainIds.MAINNET;

    return destinationAdapters;
  }
}
