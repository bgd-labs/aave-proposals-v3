// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';
import {ProtocolV3TestBase} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930} from './AaveV3ZkSync_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930.sol';

/**
 * @dev Test for AaveV3ZkSync_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20250930_Multi_EnablePriceOracleSentinelOnAaveV3CeloZkSync/AaveV3ZkSync_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930.t.sol -vv
 */
contract AaveV3ZkSync_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930_Test is
  ProtocolV3TestBase
{
  AaveV3ZkSync_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930 internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 64967448);
    proposal = new AaveV3ZkSync_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930();

    super.setUp();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930',
      AaveV3ZkSync.POOL,
      address(proposal)
    );
  }

  function test_sentinelConfigured() public {
    executePayload(vm, address(proposal));

    assertEq(
      AaveV3ZkSync.POOL_ADDRESSES_PROVIDER.getPriceOracleSentinel(),
      proposal.PRICE_ORACLE_SENTINEL()
    );
  }
}
