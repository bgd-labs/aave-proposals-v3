// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_TemporaryFreezeOfLongTailV2Assets_20240418} from './AaveV2Ethereum_TemporaryFreezeOfLongTailV2Assets_20240418.sol';

/**
 * @dev Test for AaveV2Ethereum_TemporaryFreezeOfLongTailV2Assets_20240418
 * command: make test-contract filter=AaveV2Ethereum_TemporaryFreezeOfLongTailV2Assets_20240418
 */
contract AaveV2Ethereum_TemporaryFreezeOfLongTailV2Assets_20240418_Test is ProtocolV2TestBase {
  AaveV2Ethereum_TemporaryFreezeOfLongTailV2Assets_20240418 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19682923);
    proposal = new AaveV2Ethereum_TemporaryFreezeOfLongTailV2Assets_20240418();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Ethereum_TemporaryFreezeOfLongTailV2Assets_20240418',
      AaveV2Ethereum.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](6);
    assetsChanged[0] = AaveV2EthereumAssets.USDP_UNDERLYING;
    assetsChanged[1] = AaveV2EthereumAssets.GUSD_UNDERLYING;
    assetsChanged[2] = AaveV2EthereumAssets.LUSD_UNDERLYING;
    assetsChanged[3] = AaveV2EthereumAssets.FRAX_UNDERLYING;
    assetsChanged[4] = AaveV2EthereumAssets.sUSD_UNDERLYING;
    assetsChanged[5] = AaveV2EthereumAssets.AAVE_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    for (uint i = 0; i < assetsChanged.length; i++) {
      ReserveConfig memory configAfter = _findReserveConfig(allConfigsAfter, assetsChanged[i]);
      assertEq(configAfter.isFrozen, true);
    }
  }
}
