// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Celo} from 'aave-address-book/AaveV3Celo.sol';
import {GovernanceV3Celo} from 'aave-address-book/GovernanceV3Celo.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Celo_AaveV33CeloActivation_20250224} from './AaveV3Celo_AaveV33CeloActivation_20250224.sol';

/**
 * @dev Test for AaveV3Celo_AaveV33CeloActivation_20250224
 * command: FOUNDRY_PROFILE=celo forge test --match-path=src/20250224_AaveV3Celo_AaveV33CeloActivation/AaveV3Celo_AaveV33CeloActivation_20250224.t.sol -vv
 */
contract AaveV3Celo_AaveV33CeloActivation_20250224_Test is ProtocolV3TestBase {
  AaveV3Celo_AaveV33CeloActivation_20250224 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('celo'), 30544771);
    proposal = new AaveV3Celo_AaveV33CeloActivation_20250224();

    // TODO: remove after seeding
    _seedFundsToExecutor();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Celo_AaveV33CeloActivation_20250224',
      AaveV3Celo.POOL,
      address(proposal),
      false
    );
  }

  function test_collectorHasUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Celo.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.USDC()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Celo.COLLECTOR)), 10 ** 6);
  }

  function test_collectorHasUSDTFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Celo.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.USDT()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Celo.COLLECTOR)), 10 ** 6);
  }

  function test_collectorHascEURFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Celo.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.cEUR()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Celo.COLLECTOR)), 10 ** 18);
  }

  function test_collectorHascUSDFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Celo.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.cUSD()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Celo.COLLECTOR)), 10 ** 18);
  }

  function test_collectorHasCELOFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Celo.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.CELO()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Celo.COLLECTOR)), 10 ** 18);
  }

  function _seedFundsToExecutor() internal {
    deal(proposal.USDC(), address(GovernanceV3Celo.EXECUTOR_LVL_1), proposal.USDC_SEED_AMOUNT());
    deal(proposal.USDT(), address(GovernanceV3Celo.EXECUTOR_LVL_1), proposal.USDT_SEED_AMOUNT());
    deal(proposal.cEUR(), address(GovernanceV3Celo.EXECUTOR_LVL_1), proposal.cEUR_SEED_AMOUNT());
    deal(proposal.cUSD(), address(GovernanceV3Celo.EXECUTOR_LVL_1), proposal.cUSD_SEED_AMOUNT());
  }
}
