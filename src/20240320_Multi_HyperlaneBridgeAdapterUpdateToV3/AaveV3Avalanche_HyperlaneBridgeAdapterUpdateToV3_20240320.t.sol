// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320} from './AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320.sol';
import 'aave-helpers/adi/test/ADITestBase.sol';
import {AaveV3Ethereum_HyperlaneBridgeAdapterUpdateToV3_20240320} from './AaveV3Ethereum_HyperlaneBridgeAdapterUpdateToV3_20240320.sol';

/**
 * @dev Test for AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320
 * command: make test-contract filter=AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320
 */
contract AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320_Test is ADITestBase {
  AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320 public payload;
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 43150105);
    payload = new AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320();
  }

  function getDestinationPayloadsByChain()
    public
    view
    override
    returns (DestinationPayload[] memory)
  {
    DestinationPayload[] memory destinationPayload = new DestinationPayload[](1);
    destinationPayload[0] = DestinationPayload({
      chainId: ChainIds.MAINNET,
      payloadCode: type(AaveV3Ethereum_HyperlaneBridgeAdapterUpdateToV3_20240320).creationCode
    });

    return destinationPayload;
  }

  function test_defaultTest() public {
    defaultTest(
      'AaveV3Avalanche_HyperlaneBridgeAdapterUpdateToV3_20240320',
      GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER,
      address(payload),
      true
    );
  }
}
