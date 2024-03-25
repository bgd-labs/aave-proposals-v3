// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseAdaptersUpdatePayload, ICrossChainReceiver, ICrossChainForwarder} from './BaseAdaptersUpdatePayload.sol';
import {GovernanceV3Optimism} from 'aave-address-book/GovernanceV3Optimism.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title Native bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Optimism_NativeBridgeAdaptersUpdate_20240322 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3Optimism.CROSS_CHAIN_CONTROLLER,
      newAdapter: 0xAE93BEa44dcbE52B625169588574d31e36fb3A67,
      adapterToRemove: 0x81d32B36380e6266e1BDd490eAC56cdB300afBe0 // not removing
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
