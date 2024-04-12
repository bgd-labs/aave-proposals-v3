// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseAdaptersUpdatePayload, ICrossChainForwarder} from './BaseAdaptersUpdatePayload.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Gnosis.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title LayerZero bridge adapter update to V2
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/29
 */
contract AaveV3Gnosis_LayerZeroBridgeAdapterUpdateToV2_20240322 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3Gnosis.CROSS_CHAIN_CONTROLLER,
      lzNewAdapter: 0x9b6f5ef589A3DD08670Dd146C11C4Fb33E04494F,
      lzAdapterToRemove: 0x7b62461a3570c6AC8a9f8330421576e417B71EE7
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
