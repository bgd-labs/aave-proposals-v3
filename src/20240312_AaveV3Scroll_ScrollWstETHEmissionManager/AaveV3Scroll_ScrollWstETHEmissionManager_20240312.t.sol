// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Scroll, AaveV3ScrollAssets} from 'aave-address-book/AaveV3Scroll.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Scroll_ScrollWstETHEmissionManager_20240312} from './AaveV3Scroll_ScrollWstETHEmissionManager_20240312.sol';

/**
 * @dev Test for AaveV3Scroll_ScrollWstETHEmissionManager_20240312
 * command: make test-contract filter=AaveV3Scroll_ScrollWstETHEmissionManager_20240312
 */
contract AaveV3Scroll_ScrollWstETHEmissionManager_20240312_Test is ProtocolV3TestBase {
  AaveV3Scroll_ScrollWstETHEmissionManager_20240312 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 4077518);
    proposal = new AaveV3Scroll_ScrollWstETHEmissionManager_20240312();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_ScrollWstETHEmissionManager_20240312',
      AaveV3Scroll.POOL,
      address(proposal)
    );
  }

  function test_isEmmissionAdmin() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(
      IEmissionManager(AaveV3Scroll.EMISSION_MANAGER).getEmissionAdmin(
        AaveV3ScrollAssets.wstETH_UNDERLYING
      ),
      0xC18F11735C6a1941431cCC5BcF13AF0a052A5022
    );
  }
}
