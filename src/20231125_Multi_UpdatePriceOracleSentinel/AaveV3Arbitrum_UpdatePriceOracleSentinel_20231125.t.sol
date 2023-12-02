// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125} from './AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125.sol';
import {IPriceOracleSentinel} from 'aave-v3-core/contracts/interfaces/IPriceOracleSentinel.sol';

/**
 * @dev Test for AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125
 * command: make test-contract filter=AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125
 */
contract AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 153919280);
    proposal = new AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_priceOracleSentinelSetCorrectly() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER.getPriceOracleSentinel(),
      proposal.NEW_PRICE_ORACLE_SENTINEL()
    );
  }

  function test_borrwingAndLiquidationAllowed() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertTrue(
      IPriceOracleSentinel(proposal.NEW_PRICE_ORACLE_SENTINEL()).isLiquidationAllowed()
    );
    assertTrue(
      IPriceOracleSentinel(proposal.NEW_PRICE_ORACLE_SENTINEL()).isBorrowAllowed()
    );
  }
}
