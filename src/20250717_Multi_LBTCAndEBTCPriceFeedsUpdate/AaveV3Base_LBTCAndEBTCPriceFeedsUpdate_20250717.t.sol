// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_LBTCAndEBTCPriceFeedsUpdate_20250717} from './AaveV3Base_LBTCAndEBTCPriceFeedsUpdate_20250717.sol';

/**
 * @dev Test for AaveV3Base_LBTCAndEBTCPriceFeedsUpdate_20250717
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250717_Multi_LBTCAndEBTCPriceFeedsUpdate/AaveV3Base_LBTCAndEBTCPriceFeedsUpdate_20250717.t.sol -vv
 */
contract AaveV3Base_LBTCAndEBTCPriceFeedsUpdate_20250717_Test is ProtocolV3TestBase {
  AaveV3Base_LBTCAndEBTCPriceFeedsUpdate_20250717 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 33891700);
    proposal = new AaveV3Base_LBTCAndEBTCPriceFeedsUpdate_20250717();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_LBTCAndEBTCPriceFeedsUpdate_20250717',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_LBTC_priceFeedAdapter() public {
    address feedBefore = AaveV3Base.ORACLE.getSourceOfAsset(AaveV3BaseAssets.LBTC_UNDERLYING);

    GovV3Helpers.executePayload(vm, address(proposal));

    address feedAfter = AaveV3Base.ORACLE.getSourceOfAsset(AaveV3BaseAssets.LBTC_UNDERLYING);

    assertNotEq(feedBefore, feedAfter);

    assertEq(feedAfter, proposal.LBTC_CAPO_ADAPTER());
  }
}
