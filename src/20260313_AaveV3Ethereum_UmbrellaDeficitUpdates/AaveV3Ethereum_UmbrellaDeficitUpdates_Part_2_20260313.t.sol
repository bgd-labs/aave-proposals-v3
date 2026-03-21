// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_UmbrellaDeficitUpdates_Part_2_20260313} from './AaveV3Ethereum_UmbrellaDeficitUpdates_Part_2_20260313.sol';

/**
 * @dev Test for AaveV3Ethereum_UmbrellaDeficitUpdates_Part_2_20260313
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260313_AaveV3Ethereum_UmbrellaDeficitUpdates/AaveV3Ethereum_UmbrellaDeficitUpdates_Part_2_20260313.t.sol -vv
 */
contract AaveV3Ethereum_UmbrellaDeficitUpdates_Part_2_20260313_Test is ProtocolV3TestBase {
  AaveV3Ethereum_UmbrellaDeficitUpdates_Part_2_20260313 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24699000);
    proposal = new AaveV3Ethereum_UmbrellaDeficitUpdates_Part_2_20260313();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_UmbrellaDeficitUpdates_Part_2_20260313',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_CrvEnsDeficitElimination() public {
    uint256 crvDeficit = AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.CRV_UNDERLYING);
    uint256 ensDeficit = AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.ENS_UNDERLYING);

    // For this block, this cap is actual, but situation might change in several days
    assertLt(crvDeficit, proposal.CRV_DEFICIT_ELIMINATION_CAP());
    assertLt(ensDeficit, proposal.ENS_DEFICIT_ELIMINATION_CAP());

    // Deficit should be greater than indicated in the proposal
    assertGt(crvDeficit, 394_356 * 1e18);
    assertGt(ensDeficit, 5_768 * 1e18);

    executePayload(vm, address(proposal));

    assertEq(AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.CRV_UNDERLYING), 0);
    assertEq(AaveV3Ethereum.POOL.getReserveDeficit(AaveV3EthereumAssets.ENS_UNDERLYING), 0);
  }
}
