// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3MegaEth, AaveV3MegaEthAssets} from 'aave-address-book/AaveV3MegaEth.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {GovernanceV3MegaEth} from 'aave-address-book/GovernanceV3MegaEth.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {Errors} from 'aave-v3-origin/contracts/protocol/libraries/helpers/Errors.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance_20260409} from './AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance_20260409.sol';

/**
 * @dev Test for AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance_20260409
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260409_AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance/AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance_20260409.t.sol -vv
 */
contract AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance_20260409_Test is ProtocolV3TestBase {
  AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance_20260409 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('megaeth'), 12933915);
    proposal = new AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance_20260409();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3MegaEth_OnboardUSDeToTheAaveV3MegaETHInstance_20260409',
      AaveV3MegaEth.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasUSDeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3MegaEth.POOL.getReserveAToken(proposal.USDe());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3MegaEth.DUST_BIN)), 10 ** 18);
  }

  function test_borrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = address(505);
    uint256 supplyAmount = IERC20(proposal.USDe()).balanceOf(address(AaveV3MegaEth.COLLECTOR));

    vm.startPrank(GovernanceV3MegaEth.EXECUTOR_LVL_1);
    AaveV3MegaEth.COLLECTOR.transfer(IERC20(proposal.USDe()), user, supplyAmount);
    vm.stopPrank();

    vm.startPrank(user);

    IERC20(proposal.USDe()).approve(address(AaveV3MegaEth.POOL), supplyAmount);
    AaveV3MegaEth.POOL.supply(proposal.USDe(), supplyAmount, user, 0);

    // USDe has LTV=0 outside e-mode, borrow must revert
    vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
    AaveV3MegaEth.POOL.borrow(AaveV3MegaEthAssets.USDT0_UNDERLYING, 1, 2, 0, user);

    vm.stopPrank();
  }

  function test_eMode_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    uint8 eModeId = _findEModeCategoryId('USDe__Stablecoins');

    address user = address(505);
    uint256 supplyAmount = IERC20(proposal.USDe()).balanceOf(address(AaveV3MegaEth.COLLECTOR));

    vm.startPrank(GovernanceV3MegaEth.EXECUTOR_LVL_1);
    AaveV3MegaEth.COLLECTOR.transfer(IERC20(proposal.USDe()), user, supplyAmount);
    vm.stopPrank();

    vm.startPrank(user);

    AaveV3MegaEth.POOL.setUserEMode(eModeId);

    IERC20(proposal.USDe()).approve(address(AaveV3MegaEth.POOL), supplyAmount);
    AaveV3MegaEth.POOL.supply(proposal.USDe(), supplyAmount, user, 0);

    address aUSDe = AaveV3MegaEth.POOL.getReserveAToken(proposal.USDe());
    assertApproxEqAbs(IERC20(aUSDe).balanceOf(user), supplyAmount, 1);

    // borrow USDT0 against USDe collateral in e-mode
    // supplyAmount is ~0.063 USDe (18 decimals), convert to USDT0 (6 decimals) and take half
    uint256 borrowAmount = supplyAmount / 1e12 / 2;
    AaveV3MegaEth.POOL.borrow(AaveV3MegaEthAssets.USDT0_UNDERLYING, borrowAmount, 2, 0, user);

    assertApproxEqAbs(IERC20(AaveV3MegaEthAssets.USDT0_V_TOKEN).balanceOf(user), borrowAmount, 1);

    // repay and withdraw
    IERC20(AaveV3MegaEthAssets.USDT0_UNDERLYING).approve(address(AaveV3MegaEth.POOL), borrowAmount);
    AaveV3MegaEth.POOL.repay(AaveV3MegaEthAssets.USDT0_UNDERLYING, borrowAmount, 2, user);
    AaveV3MegaEth.POOL.withdraw(proposal.USDe(), supplyAmount / 2, user);

    vm.stopPrank();
  }

  function test_lmAdminConfiguration() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address aUSDe = AaveV3MegaEth.POOL.getReserveAToken(proposal.USDe());
    address vUSDe = AaveV3MegaEth.POOL.getReserveVariableDebtToken(proposal.USDe());

    assertEq(
      IEmissionManager(AaveV3MegaEth.EMISSION_MANAGER).getEmissionAdmin(proposal.USDe()),
      proposal.LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3MegaEth.EMISSION_MANAGER).getEmissionAdmin(aUSDe),
      proposal.LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3MegaEth.EMISSION_MANAGER).getEmissionAdmin(vUSDe),
      proposal.LM_ADMIN()
    );
  }

  function _findEModeCategoryId(string memory label) internal view returns (uint8) {
    for (uint8 i = 1; i < 255; i++) {
      if (
        keccak256(bytes(AaveV3MegaEth.POOL.getEModeCategoryLabel(i))) == keccak256(bytes(label))
      ) {
        return i;
      }
    }
    revert('eMode category not found');
  }
}
