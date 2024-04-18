// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/adi/SimpleReceiverAdapterUpdate.sol';
import {GovernanceV3Metis} from 'aave-address-book/GovernanceV3Metis.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title Hyperlane bridge adapter update to V3
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/31
 */
contract AaveV3Metis_HyperlaneBridgeAdapterUpdateToV3_20240320 is
  SimpleReceiverAdapterUpdate(
    SimpleReceiverAdapterUpdate.ConstructorInput({
      ccc: GovernanceV3Metis.CROSS_CHAIN_CONTROLLER,
      newAdapter: address(0), // no new adapter
      adapterToRemove: 0x746c675dAB49Bcd5BB9Dc85161f2d7Eb435009bf
    })
  )
{
  function getChainsToReceive() public pure override returns (uint256[] memory) {
    uint256[] memory chains = new uint256[](1);
    chains[0] = ChainIds.MAINNET;
    return chains;
  }
}
