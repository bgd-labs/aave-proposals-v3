// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/adi/SimpleReceiverAdapterUpdate.sol';
import {GovernanceV3Scroll} from 'aave-address-book/GovernanceV3Scroll.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title Hyperlane bridge adapter update to V3
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/31
 */
contract AaveV3Scroll_HyperlaneBridgeAdapterUpdateToV3_20240320 is
  SimpleReceiverAdapterUpdate(
    SimpleReceiverAdapterUpdate.ConstructorInput({
      ccc: GovernanceV3Scroll.CROSS_CHAIN_CONTROLLER,
      newAdapter: address(0), // no new adapter
      adapterToRemove: 0x118DFD5418890c0332042ab05173Db4A2C1d283c
    })
  )
{
  function getChainsToReceive() public pure override returns (uint256[] memory) {
    uint256[] memory chains = new uint256[](1);
    chains[0] = ChainIds.MAINNET;
    return chains;
  }
}
