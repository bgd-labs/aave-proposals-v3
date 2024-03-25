// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseAdaptersUpdatePayload, ICrossChainForwarder} from './BaseAdaptersUpdatePayload.sol';
import {GovernanceV3BNB} from 'aave-address-book/GovernanceV3BNB.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title Hyperlane bridge adapter update to V3
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3BNB_HyperlaneBridgeAdapterUpdateToV3_20240320 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3BNB.CROSS_CHAIN_CONTROLLER,
      hlNewAdapter: 0x3F006299eC88985c18E6e885EeA29A49eC579882,
      hlAdapterToRemove: 0x118DFD5418890c0332042ab05173Db4A2C1d283c
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
}
