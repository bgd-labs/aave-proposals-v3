// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseAdaptersUpdatePayload, ICrossChainForwarder} from './BaseAdaptersUpdatePayload.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Gnosis.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title Hyperlane bridge adapter update to V3
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3Gnosis.CROSS_CHAIN_CONTROLLER,
      hlNewAdapter: 0xA806DA549FcB2B4912a7dFFE4c1aA7A1ed0Bd5C9,
      hlAdapterToRemove: 0x4A4c73d563395ad827511F70097d4Ef82E653805
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
