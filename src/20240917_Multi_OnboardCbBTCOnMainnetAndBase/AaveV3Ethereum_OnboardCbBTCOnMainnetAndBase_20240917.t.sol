// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_OnboardCbBTCOnMainnetAndBase_20240917} from './AaveV3Ethereum_OnboardCbBTCOnMainnetAndBase_20240917.sol';

/**
 * @dev Test for AaveV3Ethereum_OnboardCbBTCOnMainnetAndBase_20240917
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240917_Multi_OnboardCbBTCOnMainnetAndBase/AaveV3Ethereum_OnboardCbBTCOnMainnetAndBase_20240917.t.sol -vv
 */
contract AaveV3Ethereum_OnboardCbBTCOnMainnetAndBase_20240917_Test is ProtocolV3TestBase {
  AaveV3Ethereum_OnboardCbBTCOnMainnetAndBase_20240917 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20769192);
    proposal = new AaveV3Ethereum_OnboardCbBTCOnMainnetAndBase_20240917();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_OnboardCbBTCOnMainnetAndBase_20240917',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_collectorHascbBTCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.cbBTC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 2e5);
  }
}
