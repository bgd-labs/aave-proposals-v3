// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {MiscLinea} from 'aave-address-book/MiscLinea.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {AaveV3Linea} from 'aave-address-book/AaveV3Linea.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {GovernanceV3Linea} from 'aave-address-book/GovernanceV3Linea.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Linea_AaveV3LineaActivation_20250121} from './AaveV3Linea_AaveV3LineaActivation_20250121.sol';

/**
 * @dev Test for AaveV3Linea_AaveV3LineaActivation_20250121
 * command: FOUNDRY_PROFILE=linea forge test --match-path=src/20250121_AaveV3Linea_AaveV3LineaActivation/AaveV3Linea_AaveV3LineaActivation_20250121.t.sol -vv
 */
contract AaveV3Linea_AaveV3LineaActivation_20250121_Test is ProtocolV3TestBase {
  AaveV3Linea_AaveV3LineaActivation_20250121 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('linea'), 14852350);
    proposal = new AaveV3Linea_AaveV3LineaActivation_20250121();

    // TODO: remove after seeding
    _seedFundsToExecutor();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Linea_AaveV3LineaActivation_20250121', AaveV3Linea.POOL, address(proposal));
  }

  function test_seededFundsAndLMAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    _validateCollectorFundsAndLMAdmin(proposal.WETH(), proposal.WETH_SEED_AMOUNT());
    _validateCollectorFundsAndLMAdmin(proposal.WBTC(), proposal.WBTC_SEED_AMOUNT());
    _validateCollectorFundsAndLMAdmin(proposal.USDC(), proposal.USDC_SEED_AMOUNT());
    _validateCollectorFundsAndLMAdmin(proposal.USDT(), proposal.USDT_SEED_AMOUNT());
    _validateCollectorFundsAndLMAdmin(proposal.wstETH(), proposal.wstETH_SEED_AMOUNT());
    _validateCollectorFundsAndLMAdmin(proposal.weETH(), proposal.weETH_SEED_AMOUNT());
    _validateCollectorFundsAndLMAdmin(proposal.ezETH(), proposal.ezETH_SEED_AMOUNT());
  }

  function test_guardianPoolAdmin() public {
    assertFalse(AaveV3Linea.ACL_MANAGER.isPoolAdmin(MiscLinea.PROTOCOL_GUARDIAN));
    executePayload(vm, address(proposal));
    assertTrue(AaveV3Linea.ACL_MANAGER.isPoolAdmin(MiscLinea.PROTOCOL_GUARDIAN));
  }

  function _seedFundsToExecutor() public {
    deal(proposal.WETH(), address(GovernanceV3Linea.EXECUTOR_LVL_1), proposal.WETH_SEED_AMOUNT());
    deal(proposal.WBTC(), address(GovernanceV3Linea.EXECUTOR_LVL_1), proposal.WBTC_SEED_AMOUNT());
    deal(proposal.USDC(), address(GovernanceV3Linea.EXECUTOR_LVL_1), proposal.USDC_SEED_AMOUNT());
    deal(proposal.USDT(), address(GovernanceV3Linea.EXECUTOR_LVL_1), proposal.USDT_SEED_AMOUNT());
    deal(
      proposal.wstETH(),
      address(GovernanceV3Linea.EXECUTOR_LVL_1),
      proposal.wstETH_SEED_AMOUNT()
    );
    deal(proposal.weETH(), address(GovernanceV3Linea.EXECUTOR_LVL_1), proposal.weETH_SEED_AMOUNT());
    deal(proposal.ezETH(), address(GovernanceV3Linea.EXECUTOR_LVL_1), proposal.ezETH_SEED_AMOUNT());
  }

  function _validateCollectorFundsAndLMAdmin(address asset, uint256 seedAmount) internal view {
    (address aToken, , ) = AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(asset);
    assertGe(IERC20(aToken).balanceOf(address(AaveV3Linea.COLLECTOR)), seedAmount);

    assertEq(
      IEmissionManager(AaveV3Linea.EMISSION_MANAGER).getEmissionAdmin(asset),
      proposal.LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Linea.EMISSION_MANAGER).getEmissionAdmin(aToken),
      proposal.LM_ADMIN()
    );
  }
}
