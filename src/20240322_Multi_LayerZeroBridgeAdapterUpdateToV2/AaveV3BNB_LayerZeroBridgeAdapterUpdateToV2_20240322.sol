// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseAdaptersUpdatePayload, ICrossChainForwarder} from './BaseAdaptersUpdatePayload.sol';
import {GovernanceV3BNB} from 'aave-address-book/GovernanceV3BNB.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title LayerZero bridge adapter update to V2
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/29
 */
contract AaveV3BNB_LayerZeroBridgeAdapterUpdateToV2_20240322 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3BNB.CROSS_CHAIN_CONTROLLER,
      lzNewAdapter: 0xa5cc218513305221201f196760E9e64e9D49d98A,
      lzAdapterToRemove: 0xFF1137243698CaA18EE364Cc966CF0e02A4e6327
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
