// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Linea} from 'aave-address-book/AaveV3Linea.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
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

  function test_collectorHasSeededFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    (address aWETH, , ) = AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.WETH()
    );
    assertGe(IERC20(aWETH).balanceOf(address(AaveV3Linea.COLLECTOR)), proposal.WETH_SEED_AMOUNT());

    (address aWBTC, , ) = AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.WBTC()
    );
    assertGe(IERC20(aWBTC).balanceOf(address(AaveV3Linea.COLLECTOR)), proposal.WBTC_SEED_AMOUNT());

    (address aUSDC, , ) = AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.USDC()
    );
    assertGe(IERC20(aUSDC).balanceOf(address(AaveV3Linea.COLLECTOR)), proposal.USDC_SEED_AMOUNT());

    (address aUSDT, , ) = AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.USDT()
    );
    assertGe(IERC20(aUSDT).balanceOf(address(AaveV3Linea.COLLECTOR)), proposal.USDT_SEED_AMOUNT());

    (address aWstETH, , ) = AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.wstETH()
    );
    assertGe(
      IERC20(aWstETH).balanceOf(address(AaveV3Linea.COLLECTOR)),
      proposal.wstETH_SEED_AMOUNT()
    );

    (address aEzETH, , ) = AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.ezETH()
    );
    assertGe(
      IERC20(aEzETH).balanceOf(address(AaveV3Linea.COLLECTOR)),
      proposal.ezETH_SEED_AMOUNT()
    );

    (address aWeETH, , ) = AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.weETH()
    );
    assertGe(
      IERC20(aWeETH).balanceOf(address(AaveV3Linea.COLLECTOR)),
      proposal.weETH_SEED_AMOUNT()
    );
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
}
