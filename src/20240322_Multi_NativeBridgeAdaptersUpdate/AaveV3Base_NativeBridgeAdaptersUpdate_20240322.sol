// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseAdaptersUpdatePayload, ICrossChainReceiver, ICrossChainForwarder} from './BaseAdaptersUpdatePayload.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
/**
 * @title Native bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/26
 */
contract AaveV3Base_NativeBridgeAdaptersUpdate_20240322 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3Base.CROSS_CHAIN_CONTROLLER,
      newAdapter: 0x7120b1f8e5b73c0C0DC99C6e52Fe4937E7EA11e0,
      adapterToRemove: address(0) // @dev We dont remove old adapter so that system can be rescued by just re adding sender on Ethereum aDI
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
