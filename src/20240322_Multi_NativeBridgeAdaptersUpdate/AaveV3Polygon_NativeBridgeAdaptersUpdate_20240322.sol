// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseAdaptersUpdatePayload, ICrossChainReceiver, ICrossChainForwarder} from './BaseAdaptersUpdatePayload.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title Native bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/26
 */
contract AaveV3Polygon_NativeBridgeAdaptersUpdate_20240322 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER,
      newAdapter: 0x853649f897383f89d8441346Cf26a9ed02720B02,
      adapterToRemove: 0xb13712De579E1f9943502FFCf72eab6ec348cF79
    })
  )
{
  function getChainsToReceive() public pure override returns (uint256[] memory) {
    uint256[] memory chains = new uint256[](1);
    chains[0] = ChainIds.MAINNET;
    return chains;
  }

  function getDestinationAdapters()
    public
    pure
    override
    returns (DestinationAdaptersInput[] memory)
  {
    DestinationAdaptersInput[] memory destinationAdapters = new DestinationAdaptersInput[](1);

    destinationAdapters[0].adapter = 0x1562F1b2487F892BBA8Ef325aF054Fd157510a71;
    destinationAdapters[0].chainId = ChainIds.MAINNET;

    return destinationAdapters;
  }
}
