// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_SetACIAsEmissionManagerForLiquidityMiningPrograms_20240617} from './AaveV3Arbitrum_SetACIAsEmissionManagerForLiquidityMiningPrograms_20240617.sol';

/**
 * @dev Test for AaveV3Arbitrum_SetACIAsEmissionManagerForLiquidityMiningPrograms_20240617
 * command: make test-contract filter=AaveV3Arbitrum_SetACIAsEmissionManagerForLiquidityMiningPrograms_20240617
 */
contract AaveV3Arbitrum_SetACIAsEmissionManagerForLiquidityMiningPrograms_20240617_Test is
  ProtocolV3TestBase
{
  AaveV3Arbitrum_SetACIAsEmissionManagerForLiquidityMiningPrograms_20240617 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 222894776);
    proposal = new AaveV3Arbitrum_SetACIAsEmissionManagerForLiquidityMiningPrograms_20240617();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_SetACIAsEmissionManagerForLiquidityMiningPrograms_20240617',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_isEmmissionAdmin() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER).getEmissionAdmin(
        AaveV3ArbitrumAssets.ARB_UNDERLYING
      ),
      0xac140648435d03f784879cd789130F22Ef588Fcd
    );
  }
}
