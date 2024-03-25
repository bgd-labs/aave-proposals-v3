// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseAdaptersUpdatePayload, ICrossChainReceiver, ICrossChainForwarder} from './BaseAdaptersUpdatePayload.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title Native bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Polygon_NativeBridgeAdaptersUpdate_20240322 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER,
      newAdapter: 0x853649f897383f89d8441346Cf26a9ed02720B02,
      adapterToRemove: 0xb13712De579E1f9943502FFCf72eab6ec348cF79 // not removing
    })
  )
{
  function getChainsToReceive() public pure override returns (uint256[] memory) {
    uint256[] memory chains = new uint256[](1);
    chains[0] = ChainIds.MAINNET;
    return chains;
  }

  function getForwarderBridgeAdaptersToEnable()
    public
    view
    override
    returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory)
  {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        8
      );

    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: NEW_ADAPTER,
      destinationBridgeAdapter: 0x1562F1b2487F892BBA8Ef325aF054Fd157510a71,
      destinationChainId: ChainIds.MAINNET
    });

    return bridgeAdaptersToEnable;
  }
}
