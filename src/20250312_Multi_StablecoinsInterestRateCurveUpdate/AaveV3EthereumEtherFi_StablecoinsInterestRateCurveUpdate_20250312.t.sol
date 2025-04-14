// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumEtherFi} from 'aave-address-book/AaveV3EthereumEtherFi.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumEtherFi_StablecoinsInterestRateCurveUpdate_20250312} from './AaveV3EthereumEtherFi_StablecoinsInterestRateCurveUpdate_20250312.sol';

/**
 * @dev Test for AaveV3EthereumEtherFi_StablecoinsInterestRateCurveUpdate_20250312
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3EthereumEtherFi_StablecoinsInterestRateCurveUpdate_20250312.t.sol -vv
 */
contract AaveV3EthereumEtherFi_StablecoinsInterestRateCurveUpdate_20250312_Test is
  ProtocolV3TestBase
{
  AaveV3EthereumEtherFi_StablecoinsInterestRateCurveUpdate_20250312 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22032215);
    proposal = new AaveV3EthereumEtherFi_StablecoinsInterestRateCurveUpdate_20250312();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumEtherFi_StablecoinsInterestRateCurveUpdate_20250312',
      AaveV3EthereumEtherFi.POOL,
      address(proposal)
    );
  }
}
