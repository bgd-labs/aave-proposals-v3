// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

import {ProtocolV2TestBase} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_FullDeprecationOfDPIAcrossAaveDeployments_20251008} from './AaveV2Ethereum_FullDeprecationOfDPIAcrossAaveDeployments_20251008.sol';

/**
 * @dev Test for AaveV2Ethereum_FullDeprecationOfDPIAcrossAaveDeployments_20251008
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251008_Multi_FullDeprecationOfDPIAcrossAaveDeployments/AaveV2Ethereum_FullDeprecationOfDPIAcrossAaveDeployments_20251008.t.sol -vv
 */
contract AaveV2Ethereum_FullDeprecationOfDPIAcrossAaveDeployments_20251008_Test is
  ProtocolV2TestBase
{
  AaveV2Ethereum_FullDeprecationOfDPIAcrossAaveDeployments_20251008 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23533325);
    proposal = new AaveV2Ethereum_FullDeprecationOfDPIAcrossAaveDeployments_20251008();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Ethereum_FullDeprecationOfDPIAcrossAaveDeployments_20251008',
      AaveV2Ethereum.POOL,
      address(proposal)
    );
  }
}
