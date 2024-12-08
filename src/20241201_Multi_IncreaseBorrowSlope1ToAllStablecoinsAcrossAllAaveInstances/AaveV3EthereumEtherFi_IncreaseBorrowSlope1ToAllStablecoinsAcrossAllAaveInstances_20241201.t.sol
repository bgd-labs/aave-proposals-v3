// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumEtherFi} from 'aave-address-book/AaveV3EthereumEtherFi.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumEtherFi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201} from './AaveV3EthereumEtherFi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.sol';

/**
 * @dev Test for AaveV3EthereumEtherFi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3EthereumEtherFi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.t.sol -vv
 */
contract AaveV3EthereumEtherFi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201_Test is
  ProtocolV3TestBase
{
  AaveV3EthereumEtherFi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21346502);
    proposal = new AaveV3EthereumEtherFi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumEtherFi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201',
      AaveV3EthereumEtherFi.POOL,
      address(proposal)
    );
  }
}
