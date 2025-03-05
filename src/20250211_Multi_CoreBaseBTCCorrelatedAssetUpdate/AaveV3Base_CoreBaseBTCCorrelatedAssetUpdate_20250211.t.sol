// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_CoreBaseBTCCorrelatedAssetUpdate_20250211} from './AaveV3Base_CoreBaseBTCCorrelatedAssetUpdate_20250211.sol';

/**
 * @dev Test for AaveV3Base_CoreBaseBTCCorrelatedAssetUpdate_20250211
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20250211_Multi_CoreBaseBTCCorrelatedAssetUpdate/AaveV3Base_CoreBaseBTCCorrelatedAssetUpdate_20250211.t.sol -vv
 */
contract AaveV3Base_CoreBaseBTCCorrelatedAssetUpdate_20250211_Test is ProtocolV3TestBase {
  AaveV3Base_CoreBaseBTCCorrelatedAssetUpdate_20250211 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 26982148);
    proposal = new AaveV3Base_CoreBaseBTCCorrelatedAssetUpdate_20250211();

    deal(proposal.LBTC(), AaveV3Base.ACL_ADMIN, proposal.LBTC_SEED_AMOUNT());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_CoreBaseBTCCorrelatedAssetUpdate_20250211',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_binHasLBTCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.LBTC()
    );
    assertEq(IERC20(aTokenAddress).balanceOf(AaveV3Base.DUST_BIN), 10 ** 5);
  }
}
