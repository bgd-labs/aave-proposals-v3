// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseAdaptersUpdatePayload, ICrossChainReceiver, ICrossChainForwarder} from './BaseAdaptersUpdatePayload.sol';
import {GovernanceV3Scroll} from 'aave-address-book/GovernanceV3Scroll.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title Native bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Scroll_NativeBridgeAdaptersUpdate_20240322 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3Scroll.CROSS_CHAIN_CONTROLLER,
      newAdapter: 0x3C06dce358add17aAf230f2234bCCC4afd50d090,
      adapterToRemove: 0x118DFD5418890c0332042ab05173Db4A2C1d283c // not removing
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
