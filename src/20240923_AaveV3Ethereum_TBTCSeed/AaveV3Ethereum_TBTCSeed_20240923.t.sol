// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_TBTCSeed_20240923} from './AaveV3Ethereum_TBTCSeed_20240923.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_TBTCSeed_20240923
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240923_AaveV3Ethereum_TBTCSeed/AaveV3Ethereum_TBTCSeed_20240923.t.sol -vv
 */
contract AaveV3Ethereum_TBTCSeed_20240923_Test is ProtocolV3TestBase {
  AaveV3Ethereum_TBTCSeed_20240923 internal proposal;
  address public constant TBTC_ATOKEN = 0x10Ac93971cdb1F5c778144084242374473c350Da;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20812119);
    proposal = new AaveV3Ethereum_TBTCSeed_20240923();
    vm.warp(1727090472);

    deal(proposal.TBTC(), address(proposal), proposal.SEED_AMOUNT());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    proposal.execute();

    assertTrue(
      IERC20(TBTC_ATOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) > proposal.SEED_AMOUNT()
    );
  }
}
