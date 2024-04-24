// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/adi/SimpleOneToManyAdapterUpdate.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Gnosis.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title Hyperlane bridge adapter update to V3
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/31
 */
contract AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320 is
  SimpleOneToManyAdapterUpdate(
    SimpleOneToManyAdapterUpdate.ConstructorInput({
      ccc: GovernanceV3Gnosis.CROSS_CHAIN_CONTROLLER,
      newAdapter: 0xA806DA549FcB2B4912a7dFFE4c1aA7A1ed0Bd5C9,
      adapterToRemove: 0x4A4c73d563395ad827511F70097d4Ef82E653805
    })
  )
{
  function getChainsToReceive() public pure override returns (uint256[] memory) {
    uint256[] memory chains = new uint256[](1);
    chains[0] = ChainIds.MAINNET;
    return chains;
  }
}
