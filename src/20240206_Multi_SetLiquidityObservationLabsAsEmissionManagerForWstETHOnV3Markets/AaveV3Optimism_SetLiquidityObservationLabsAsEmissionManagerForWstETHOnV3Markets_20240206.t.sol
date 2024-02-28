// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206} from './AaveV3Optimism_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @dev Test for AaveV3Optimism_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206
 * command: make test-contract filter=AaveV3Optimism_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206
 */
contract AaveV3Optimism_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206_Test is
  ProtocolV3TestBase
{
  AaveV3Optimism_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 115824413);
    proposal = new AaveV3Optimism_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets_20240206',
      AaveV3Optimism.POOL,
      address(proposal)
    );

    // test emission manager update
    assertEq(
      IEmissionManager(AaveV3Optimism.EMISSION_MANAGER).getEmissionAdmin(
        AaveV3OptimismAssets.wstETH_UNDERLYING
      ),
      0xC18F11735C6a1941431cCC5BcF13AF0a052A5022
    );
  }
}
