// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Gnosis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_AaveV3GnosisActivation_20231026} from './AaveV3Gnosis_AaveV3GnosisActivation_20231026.sol';

/**
 * @dev Test for AaveV3Gnosis_AaveV3GnosisActivation_20231026
 * command: make test-contract filter=AaveV3Gnosis_AaveV3GnosisActivation_20231026
 */
contract AaveV3Gnosis_AaveV3GnosisActivation_20231026_Test is ProtocolV3TestBase {
  AaveV3Gnosis_AaveV3GnosisActivation_20231026 internal proposal;
  address constant DEPLOYER = 0x956DE559DFc27678FD69d4f49f485196b50BDD0F;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 30643530);
    proposal = new AaveV3Gnosis_AaveV3GnosisActivation_20231026();

    // TODO: remove after funding the executor
    _fundExecutorWithAssetsToList();

    // TODO: remove after transferring the ownership
    vm.startPrank(DEPLOYER);
    IOwnable(GovernanceV3Gnosis.EXECUTOR_LVL_1).transferOwnership(address(GovernanceV3Gnosis.PAYLOADS_CONTROLLER));
    vm.stopPrank();
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
    (address aTokenAddress, ,) = AaveV3Gnosis.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(proposal.WETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Gnosis.COLLECTOR)),
      0.01 * 1e18
    );
  }

  function test_collectorHaswstETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, ,) = AaveV3Gnosis.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(proposal.wstETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Gnosis.COLLECTOR)),
      0.01 * 1e18
    );
  }

  function test_collectorHasGNOFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, ,) = AaveV3Gnosis.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(proposal.GNO());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Gnosis.COLLECTOR)),
      0.1 * 1e18
    );
  }

  function test_collectorHasUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, ,) = AaveV3Gnosis.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(proposal.USDC());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Gnosis.COLLECTOR)),
      10 * 1e6
    );
  }

  function test_collectorHasWXDAIFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, ,) = AaveV3Gnosis.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(proposal.WXDAI());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Gnosis.COLLECTOR)),
      10 * 1e18
    );
  }

  function test_collectorHasEUReFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, ,) = AaveV3Gnosis.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(proposal.EURe());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Gnosis.COLLECTOR)),
      10 * 1e18
    );
  }

  function test_collectorHasSDAIFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, ,) = AaveV3Gnosis.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(proposal.sDAI());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Gnosis.COLLECTOR)),
      10 * 1e18
    );
  }

  function _fundExecutorWithAssetsToList() internal {
    console.log('10 * 1e18', 10 * 1e18);
    deal2(proposal.WETH(), GovernanceV3Gnosis.EXECUTOR_LVL_1, 0.01 * 1e18);
    deal2(proposal.wstETH(), GovernanceV3Gnosis.EXECUTOR_LVL_1, 0.01 * 1e18);
    deal2(proposal.GNO(), GovernanceV3Gnosis.EXECUTOR_LVL_1, 0.1 * 1e18);
    deal2(proposal.USDC(), GovernanceV3Gnosis.EXECUTOR_LVL_1, 10 * 1e6);
    deal2(proposal.WXDAI(), GovernanceV3Gnosis.EXECUTOR_LVL_1, 10 * 1e18);
    deal2(proposal.EURe(), GovernanceV3Gnosis.EXECUTOR_LVL_1, 10 * 1e18);
    deal2(proposal.sDAI(), GovernanceV3Gnosis.EXECUTOR_LVL_1, 10 * 1e18);
    vm.stopPrank();
  }
}

interface IOwnable {
  function transferOwnership(address newOwner) external;

  function owner() external view returns (address);
}
