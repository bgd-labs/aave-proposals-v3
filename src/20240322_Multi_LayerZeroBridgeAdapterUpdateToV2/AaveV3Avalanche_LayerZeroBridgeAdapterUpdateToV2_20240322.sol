// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseAdaptersUpdatePayload} from './BaseAdaptersUpdatePayload.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
/**
 * @title LayerZero bridge adapter update to V2
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/29
 */
contract AaveV3Avalanche_LayerZeroBridgeAdapterUpdateToV2_20240322 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER,
      lzNewAdapter: 0x10f02995a399C0dC0FaF29914220E9C1bCdE8640,
      lzAdapterToRemove: 0xf41193E25408F652AF878c47E4401A01B5E4B682
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
