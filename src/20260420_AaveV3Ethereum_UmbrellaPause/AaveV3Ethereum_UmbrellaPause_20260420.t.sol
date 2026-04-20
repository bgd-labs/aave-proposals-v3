// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_UmbrellaPause_20260420} from './AaveV3Ethereum_UmbrellaPause_20260420.sol';
import {UmbrellaEthereumAssets} from 'aave-address-book/UmbrellaEthereum.sol';

interface IPausable {
  function paused() external view returns (bool);
}

/**
 * @dev Test for AaveV3Ethereum_UmbrellaPause_20260420
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260420_AaveV3Ethereum_UmbrellaPause/AaveV3Ethereum_UmbrellaPause_20260420.t.sol -vv
 */
contract AaveV3Ethereum_UmbrellaPause_20260420_Test is ProtocolV3TestBase {
  AaveV3Ethereum_UmbrellaPause_20260420 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24921270);
    proposal = new AaveV3Ethereum_UmbrellaPause_20260420();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_UmbrellaPause_20260420', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_execute() public {
    assertFalse(IPausable(UmbrellaEthereumAssets.STK_WA_USDC_V1).paused());
    assertFalse(IPausable(UmbrellaEthereumAssets.STK_WA_USDT_V1).paused());
    assertFalse(IPausable(UmbrellaEthereumAssets.STK_WA_WETH_V1).paused());
    assertFalse(IPausable(UmbrellaEthereumAssets.STK_GHO_V1).paused());

    GovV3Helpers.executePayload(vm, address(proposal));

    assertTrue(IPausable(UmbrellaEthereumAssets.STK_WA_USDC_V1).paused());
    assertTrue(IPausable(UmbrellaEthereumAssets.STK_WA_USDT_V1).paused());
    assertTrue(IPausable(UmbrellaEthereumAssets.STK_WA_WETH_V1).paused());
    assertTrue(IPausable(UmbrellaEthereumAssets.STK_GHO_V1).paused());
  }
}
