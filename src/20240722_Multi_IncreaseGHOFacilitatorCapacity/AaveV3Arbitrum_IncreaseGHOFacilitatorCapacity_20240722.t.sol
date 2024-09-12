// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722} from './AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {IGhoToken} from 'src/interfaces/IGhoToken.sol';

/**
 * @dev Test for AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20240722_Multi_IncreaseGHOFacilitatorCapacity/AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722.t.sol -vv
 */
contract AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 236255425);
    proposal = new AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_capsUpdates() public {
    ReserveConfig[] memory configs = _getReservesConfigs(AaveV3Arbitrum.POOL);

    ReserveConfig memory GHO = _findReserveConfig(configs, AaveV3ArbitrumAssets.GHO_UNDERLYING);

    assertEq(GHO.supplyCap, 1_000_000);
    assertEq(GHO.borrowCap, 900_000);

    executePayload(vm, address(proposal));

    ReserveConfig[] memory configsAfter = _getReservesConfigs(AaveV3Arbitrum.POOL);

    GHO = _findReserveConfig(configsAfter, AaveV3ArbitrumAssets.GHO_UNDERLYING);

    assertEq(GHO.supplyCap, proposal.NEW_SUPPLY_CAP());
    assertEq(GHO.borrowCap, proposal.NEW_BORROW_CAP());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_newLimitIsSet() public {
    IGhoToken.Facilitator memory prevFacilitator = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING)
      .getFacilitator(MiscArbitrum.GHO_CCIP_TOKEN_POOL);
    assertEq(prevFacilitator.bucketCapacity, 2_500_000 ether);

    executePayload(vm, address(proposal));

    IGhoToken.Facilitator memory facilitator = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING)
      .getFacilitator(MiscArbitrum.GHO_CCIP_TOKEN_POOL);

    assertEq(facilitator.bucketCapacity, proposal.NEW_LIMIT());
  }
}
