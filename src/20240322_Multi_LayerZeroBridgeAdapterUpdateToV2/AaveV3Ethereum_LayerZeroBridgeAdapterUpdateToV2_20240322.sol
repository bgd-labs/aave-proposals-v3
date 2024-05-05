// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseAdaptersUpdatePayload, ICrossChainForwarder} from './BaseAdaptersUpdatePayload.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title LayerZero bridge adapter update to V2
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/29
 */
contract AaveV3Ethereum_LayerZeroBridgeAdapterUpdateToV2_20240322 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      lzNewAdapter: 0x8410d9BD353b420ebA8C48ff1B0518426C280FCC,
      lzAdapterToRemove: 0x2a323be63e08E08536Fc3b5d8C6f24825e68895e // this adapter is for communication for (eth -> avax, pol, bnb)
    })
  )
{
  // we define it here as its custom for this specific case (lz on eth -> gnosis communication. only forwarding)
  address public constant LZ_FORWARDER_TO_REMOVE_GNOSIS =
    0x1783DA119C35ED03e608f88cB9528Aba8174fFfc;

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

    destinationAdapters[0].adapter = 0x10f02995a399C0dC0FaF29914220E9C1bCdE8640;
    destinationAdapters[0].chainId = ChainIds.AVALANCHE;

    destinationAdapters[1].adapter = 0x7FAE7765abB4c8f778d57337bB720d0BC53057e3;
    destinationAdapters[1].chainId = ChainIds.POLYGON;

    destinationAdapters[2].adapter = 0xa5cc218513305221201f196760E9e64e9D49d98A;
    destinationAdapters[2].chainId = ChainIds.BNB;

    destinationAdapters[3].adapter = 0x9b6f5ef589A3DD08670Dd146C11C4Fb33E04494F;
    destinationAdapters[3].chainId = ChainIds.GNOSIS;

    return destinationAdapters;
  }

  // we override this method, as in lz case, we have two lz adapters. the normal one that sends (to avax, pol, bnb) and receives (from avax and pol)
  // and the adapter to send to gnosis
  function getForwarderBridgeAdaptersToRemove()
    public
    view
    override
    returns (ICrossChainForwarder.BridgeAdapterToDisable[] memory)
  {
    ICrossChainForwarder.BridgeAdapterToDisable[]
      memory forwarderAdaptersToRemove = new ICrossChainForwarder.BridgeAdapterToDisable[](2);

    uint256[] memory chainIds = new uint256[](3);
    chainIds[0] = ChainIds.POLYGON;
    chainIds[1] = ChainIds.BNB;
    chainIds[2] = ChainIds.AVALANCHE;

    forwarderAdaptersToRemove[0] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: LZ_ADAPTER_TO_REMOVE,
      chainIds: chainIds
    });
    forwarderAdaptersToRemove[1] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: LZ_FORWARDER_TO_REMOVE_GNOSIS,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[1].chainIds[0] = ChainIds.GNOSIS;

    return forwarderAdaptersToRemove;
  }
}
