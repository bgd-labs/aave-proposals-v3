// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {CommonTestBase} from 'aave-helpers/CommonTestBase.sol';
import {IAaveOracle} from 'aave-address-book/AaveV2.sol';
import {AaveV1Ethereum_FixedREPPriceFeed_20231031} from './AaveV1Ethereum_FixedREPPriceFeed_20231031.sol';

/**
 * @dev Test for AaveV1Ethereum_FixedREPPriceFeed_20231031
 * command: make test-contract filter=AaveV1Ethereum_FixedREPPriceFeed_20231031
 */
contract AaveV1Ethereum_FixedREPPriceFeed_20231031_Test is CommonTestBase {
  AaveV1Ethereum_FixedREPPriceFeed_20231031 internal proposal;

  address public constant REP = 0x1985365e9f78359a9B6AD760e32412f4a445E862;
  address public constant REP_ADAPTER = 0xc7751400F809cdB0C167F87985083C558a0610F7;
  address public constant AAVE_V1_ORACLE = 0x76B47460d7F7c5222cFb6b6A75615ab10895DDe4;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18470486);
    proposal = new AaveV1Ethereum_FixedREPPriceFeed_20231031();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_proposalExecution() public {
    executePayload(vm, address(proposal));

    IAaveOracle oracle = IAaveOracle(AAVE_V1_ORACLE);
    address newSource = oracle.getSourceOfAsset(REP);
    assertEq(newSource, REP_ADAPTER);

    assertEq(oracle.getAssetPrice(REP), 462569569300000);
  }
}
