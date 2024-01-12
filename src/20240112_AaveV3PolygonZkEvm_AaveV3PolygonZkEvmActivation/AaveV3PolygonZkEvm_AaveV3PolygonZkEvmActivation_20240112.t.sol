// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3PolygonZkEvm} from 'aave-address-book/AaveV3PolygonZkEvm.sol';
import {GovernanceV3PolygonZkEvm} from 'aave-address-book/GovernanceV3PolygonZkEvm.sol';
import {MiscPolygonZkEvm} from 'aave-address-book/MiscPolygonZkEvm.sol';
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
    vm.createSelectFork(vm.rpcUrl('zkevm'), 9200441);
    proposal = new AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112();

    // TODO: remove after seeding
    _fundExecutorWithAssetsToList();
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
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3PolygonZkEvm.COLLECTOR)),
      proposal.USDC_SEED_AMOUNT()
    );
  }

  function test_collectorHasWETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3PolygonZkEvm
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.WETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3PolygonZkEvm.COLLECTOR)),
      proposal.WETH_SEED_AMOUNT()
    );
  }

  function test_collectorHasMATICFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3PolygonZkEvm
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.MATIC());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3PolygonZkEvm.COLLECTOR)),
      proposal.MATIC_SEED_AMOUNT()
    );
  }

  function test_AdminPermissions() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertTrue(
      AaveV3PolygonZkEvm.ACL_MANAGER.isRiskAdmin(AaveV3PolygonZkEvm.CAPS_PLUS_RISK_STEWARD)
    );
    assertTrue(AaveV3PolygonZkEvm.ACL_MANAGER.isRiskAdmin(AaveV3PolygonZkEvm.FREEZING_STEWARD));
    assertTrue(AaveV3PolygonZkEvm.ACL_MANAGER.isPoolAdmin(MiscPolygonZkEvm.PROTOCOL_GUARDIAN));
  }

  function _fundExecutorWithAssetsToList() internal {
    deal2(proposal.USDC(), GovernanceV3PolygonZkEvm.EXECUTOR_LVL_1, proposal.USDC_SEED_AMOUNT());
  }
}
