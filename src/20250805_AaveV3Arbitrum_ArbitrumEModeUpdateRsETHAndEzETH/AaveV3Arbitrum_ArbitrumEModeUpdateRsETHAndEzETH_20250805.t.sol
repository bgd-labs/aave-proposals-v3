// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH_20250805} from './AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH_20250805.sol';

/**
 * @dev Test for AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH_20250805
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250805_AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH/AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH_20250805.t.sol -vv
 */
contract AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH_20250805_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH_20250805 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 370166375);
    proposal = new AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH_20250805();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH_20250805',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }
}
