// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {AaveV3Ethereum_HyperlaneBridgeAdapterUpdateToV3_20240320} from './AaveV3Ethereum_HyperlaneBridgeAdapterUpdateToV3_20240320.sol';
import 'aave-helpers/adi/test/ADITestBase.sol';
import {AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320} from './AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320.sol';
import {AaveV3BNB_HyperlaneBridgeAdapterUpdateToV3_20240320} from './AaveV3BNB_HyperlaneBridgeAdapterUpdateToV3_20240320.sol';
import {AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320} from './AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320.sol';
import {AaveV3Polygon_HyperlaneBridgeAdapterUpdateToV3_20240320} from './AaveV3Polygon_HyperlaneBridgeAdapterUpdateToV3_20240320.sol';

/**
 * @dev Test for AaveV3Ethereum_HyperlaneBridgeAdapterUpdateToV3_20240320
 * command: make test-contract filter=AaveV3Ethereum_HyperlaneBridgeAdapterUpdateToV3_20240320
 */
contract AaveV3Ethereum_HyperlaneBridgeAdapterUpdateToV3_20240320_Test is ADITestBase {
  AaveV3Ethereum_HyperlaneBridgeAdapterUpdateToV3_20240320 public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19661654);
    payload = new AaveV3Ethereum_HyperlaneBridgeAdapterUpdateToV3_20240320();
  }

  function getDestinationPayloadsByChain()
    public
    view
    override
    returns (DestinationPayload[] memory)
  {
    DestinationPayload[] memory destinationPayload = new DestinationPayload[](4);
    destinationPayload[0] = DestinationPayload({
      chainId: ChainIds.AVALANCHE,
      payloadCode: type(AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320).creationCode
    });
    destinationPayload[1] = DestinationPayload({
      chainId: ChainIds.POLYGON,
      payloadCode: type(AaveV3Polygon_HyperlaneBridgeAdapterUpdateToV3_20240320).creationCode
    });
    destinationPayload[2] = DestinationPayload({
      chainId: ChainIds.BNB,
      payloadCode: type(AaveV3BNB_HyperlaneBridgeAdapterUpdateToV3_20240320).creationCode
    });
    destinationPayload[3] = DestinationPayload({
      chainId: ChainIds.GNOSIS,
      payloadCode: type(AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320).creationCode
    });

    return destinationPayload;
  }

  function test_defaultTest() public {
    defaultTest(
      'AaveV3Ethereum_HyperlaneBridgeAdapterUpdateToV3_20240320',
      GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      address(payload),
      true
    );
  }
}
