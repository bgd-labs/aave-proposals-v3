// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {IPriceCapAdapter} from '../interfaces/IPriceCapAdapter.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_LBTCAndEBTCPriceFeedsUpdate_20250717} from './AaveV3Ethereum_LBTCAndEBTCPriceFeedsUpdate_20250717.sol';

/**
 * @dev Test for AaveV3Ethereum_LBTCAndEBTCPriceFeedsUpdate_20250717
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250717_Multi_LBTCAndEBTCPriceFeedsUpdate/AaveV3Ethereum_LBTCAndEBTCPriceFeedsUpdate_20250717.t.sol -vv
 */
contract AaveV3Ethereum_LBTCAndEBTCPriceFeedsUpdate_20250717_Test is ProtocolV3TestBase {
  AaveV3Ethereum_LBTCAndEBTCPriceFeedsUpdate_20250717 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23118114);
    proposal = new AaveV3Ethereum_LBTCAndEBTCPriceFeedsUpdate_20250717();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_LBTCAndEBTCPriceFeedsUpdate_20250717',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_eBTC_priceFeedAdapter() public {
    address feedBefore = AaveV3Ethereum.ORACLE.getSourceOfAsset(
      AaveV3EthereumAssets.eBTC_UNDERLYING
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    address feedAfter = AaveV3Ethereum.ORACLE.getSourceOfAsset(
      AaveV3EthereumAssets.eBTC_UNDERLYING
    );

    assertNotEq(feedBefore, feedAfter);

    assertEq(feedAfter, proposal.EBTC_CAPO_ADAPTER());
  }

  function test_LBTC_priceFeedAdapter() public {
    address feedBefore = AaveV3Ethereum.ORACLE.getSourceOfAsset(
      AaveV3EthereumAssets.LBTC_UNDERLYING
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    address feedAfter = AaveV3Ethereum.ORACLE.getSourceOfAsset(
      AaveV3EthereumAssets.LBTC_UNDERLYING
    );

    assertNotEq(feedBefore, feedAfter);

    assertEq(feedAfter, proposal.LBTC_CAPO_ADAPTER());
  }
}
