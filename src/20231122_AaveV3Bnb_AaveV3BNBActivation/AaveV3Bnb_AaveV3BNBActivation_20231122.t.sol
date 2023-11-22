// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Bnb} from 'aave-address-book/AaveV3Bnb.sol';
import {GovernanceV3BNB} from 'aave-address-book/GovernanceV3BNB.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Bnb_AaveV3BNBActivation_20231122} from './AaveV3Bnb_AaveV3BNBActivation_20231122.sol';

/**
 * @dev Test for AaveV3Bnb_AaveV3BNBActivation_20231122
 * command: make test-contract filter=AaveV3Bnb_AaveV3BNBActivation_20231122
 */
contract AaveV3Bnb_AaveV3BNBActivation_20231122_Test is ProtocolV3TestBase {
  AaveV3Bnb_AaveV3BNBActivation_20231122 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 33713775);
    proposal = new AaveV3Bnb_AaveV3BNBActivation_20231122();

    _fundExecutorWithAssetsToList();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Bnb_AaveV3BNBActivation_20231122', AaveV3Bnb.POOL, address(proposal), true);
  }

  function test_collectorHasCakeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Bnb.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.Cake()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Bnb.COLLECTOR)), 10 ** 18);
  }

  function test_collectorHasWBNBFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Bnb.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.WBNB()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Bnb.COLLECTOR)), 10 ** 18);
  }

  function test_collectorHasBTCBFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Bnb.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.BTCB()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Bnb.COLLECTOR)), 10 ** 18);
  }

  function test_collectorHasETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Bnb.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.ETH()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Bnb.COLLECTOR)), 10 ** 18);
  }

  function test_collectorHasUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Bnb.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.USDC()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Bnb.COLLECTOR)), 10 ** 18);
  }

  function test_collectorHasUSDTFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Bnb.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.USDT()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Bnb.COLLECTOR)), 10 ** 18);
  }

  function _fundExecutorWithAssetsToList() internal {
    deal2(proposal.Cake(), GovernanceV3BNB.EXECUTOR_LVL_1, proposal.Cake_SEED_AMOUNT());
    deal2(proposal.WBNB(), GovernanceV3BNB.EXECUTOR_LVL_1, proposal.WBNB_SEED_AMOUNT());
    deal2(proposal.BTCB(), GovernanceV3BNB.EXECUTOR_LVL_1, proposal.BTCB_SEED_AMOUNT());
    deal2(proposal.ETH(), GovernanceV3BNB.EXECUTOR_LVL_1, proposal.ETH_SEED_AMOUNT());
    deal2(proposal.USDC(), GovernanceV3BNB.EXECUTOR_LVL_1, proposal.USDC_SEED_AMOUNT());
    deal2(proposal.USDT(), GovernanceV3BNB.EXECUTOR_LVL_1, proposal.USDT_SEED_AMOUNT());
    vm.stopPrank();
  }
}
