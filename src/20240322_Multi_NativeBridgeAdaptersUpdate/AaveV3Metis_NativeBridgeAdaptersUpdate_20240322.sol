// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseAdaptersUpdatePayload, ICrossChainReceiver, ICrossChainForwarder} from './BaseAdaptersUpdatePayload.sol';
import {GovernanceV3Metis} from 'aave-address-book/GovernanceV3Metis.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title Native bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Metis_NativeBridgeAdaptersUpdate_20240322 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3Metis.CROSS_CHAIN_CONTROLLER,
      newAdapter: 0xf41193E25408F652AF878c47E4401A01B5E4B682,
      adapterToRemove: 0x746c675dAB49Bcd5BB9Dc85161f2d7Eb435009bf // not removing
    })
  )
{
  function getChainsToReceive() public pure override returns (uint256[] memory) {
    uint256[] memory chains = new uint256[](1);
    chains[0] = ChainIds.MAINNET;
    return chains;
  }

  function getForwarderBridgeAdaptersToRemove()
    public
    pure
    override
    returns (ICrossChainForwarder.BridgeAdapterToDisable[] memory)
  {
    return new ICrossChainForwarder.BridgeAdapterToDisable[](0);
  }

  // @dev in this AIP we are not removing old adapter, in case connection gets broken. This way, we would just need to
  // re enable old adapter on origin, and we would have reestablished the connection
  function getReceiverBridgeAdaptersToRemove()
    public
    pure
    override
    returns (ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[] memory)
  {
    return new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](0);
  }
}
