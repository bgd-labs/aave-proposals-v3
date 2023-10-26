// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_AaveV3GnosisActivation_20231026} from './AaveV3Gnosis_AaveV3GnosisActivation_20231026.sol';

/**
 * @dev Test for AaveV3Gnosis_AaveV3GnosisActivation_20231026
 * command: make test-contract filter=AaveV3Gnosis_AaveV3GnosisActivation_20231026
 */
contract AaveV3Gnosis_AaveV3GnosisActivation_20231026_Test is ProtocolV3TestBase {
  AaveV3Gnosis_AaveV3GnosisActivation_20231026 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 30643529);
    proposal = new AaveV3Gnosis_AaveV3GnosisActivation_20231026();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_AaveV3GnosisActivation_20231026',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }

  function test_collectorHasWETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertGe(
      IERC20(0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1).balanceOf(address(AaveV3Gnosis.COLLECTOR)),
      10 ** 18
    );
  }

  function test_collectorHaswstETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertGe(
      IERC20(0x6C76971f98945AE98dD7d4DFcA8711ebea946eA6).balanceOf(address(AaveV3Gnosis.COLLECTOR)),
      10 ** 18
    );
  }

  function test_collectorHasGNOFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertGe(
      IERC20(0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb).balanceOf(address(AaveV3Gnosis.COLLECTOR)),
      10 ** 18
    );
  }

  function test_collectorHasUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertGe(
      IERC20(0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83).balanceOf(address(AaveV3Gnosis.COLLECTOR)),
      10 ** 6
    );
  }

  function test_collectorHasXDAIFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertGe(
      IERC20(0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d).balanceOf(address(AaveV3Gnosis.COLLECTOR)),
      10 ** 18
    );
  }

  function test_collectorHasEUReFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertGe(
      IERC20(0xcB444e90D8198415266c6a2724b7900fb12FC56E).balanceOf(address(AaveV3Gnosis.COLLECTOR)),
      10 ** 18
    );
  }
}
