// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3PolygonZkEvm} from 'aave-address-book/AaveV3PolygonZkEvm.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112} from './AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112.sol';

/**
 * @dev Test for AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112
 * command: make test-contract filter=AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112
 */
contract AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112_Test is ProtocolV3TestBase {
  AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygonzkevm'), 9196867);
    proposal = new AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112',
      AaveV3PolygonZkEvm.POOL,
      address(proposal)
    );
  }

  function test_collectorHasUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3PolygonZkEvm
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.USDC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3PolygonZkEvm.COLLECTOR)), 10 ** 6);
  }

  function test_collectorHasWETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3PolygonZkEvm
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.WETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3PolygonZkEvm.COLLECTOR)), 10 ** 18);
  }

  function test_collectorHasMATICFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3PolygonZkEvm
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.MATIC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3PolygonZkEvm.COLLECTOR)), 10 ** 18);
  }
}
