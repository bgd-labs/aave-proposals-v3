// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Monad} from 'aave-address-book/AaveV3Monad.sol';
import {GovernanceV3Monad} from 'aave-address-book/GovernanceV3Monad.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {Errors} from 'aave-v3-origin/contracts/protocol/libraries/helpers/Errors.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Monad_AaveV3MonadActivation_20260623} from './AaveV3Monad_AaveV3MonadActivation_20260623.sol';

/**
 * @dev Test for AaveV3Monad_AaveV3MonadActivation_20260623
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3Monad_AaveV3MonadActivation_20260623.t.sol -vv
 */
contract AaveV3Monad_AaveV3MonadActivation_20260623_Test is ProtocolV3TestBase {
  AaveV3Monad_AaveV3MonadActivation_20260623 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('monad'), 83370000);
    proposal = new AaveV3Monad_AaveV3MonadActivation_20260623();
    // temporary: seed the executor so _postExecute() can supply to the DUST_BIN
    deal(proposal.USDT0(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.USDT0_SEED_AMOUNT());
    deal(proposal.USDC(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.USDC_SEED_AMOUNT());
    deal(proposal.GHO(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.GHO_SEED_AMOUNT());
    deal(proposal.USDe(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.USDe_SEED_AMOUNT());
    deal(proposal.mUSD(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.mUSD_SEED_AMOUNT());
    // AUSD uses namespaced storage that `deal` cannot write; fund from an on-chain holder
    vm.startPrank(0xD5D960E8C380B724a48AC59E2DfF1b2CB4a1eAee);
    IERC20(proposal.AUSD()).transfer(GovernanceV3Monad.EXECUTOR_LVL_1, proposal.AUSD_SEED_AMOUNT());
    vm.stopPrank();
    deal(proposal.WETH(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.WETH_SEED_AMOUNT());
    deal(proposal.cbBTC(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.cbBTC_SEED_AMOUNT());
    deal(proposal.wstETH(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.wstETH_SEED_AMOUNT());
    deal(proposal.weETH(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.weETH_SEED_AMOUNT());
    deal(proposal.syrupUSDC(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.syrupUSDC_SEED_AMOUNT());
    deal(proposal.sUSDe(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.sUSDe_SEED_AMOUNT());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Monad_AaveV3MonadActivation_20260623', AaveV3Monad.POOL, address(proposal));
  }

  function test_dustBinHasUSDT0Funds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.USDT0());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)), 10 ** 6);
  }

  function test_dustBinHasUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.USDC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)), 10 ** 6);
  }

  function test_dustBinHasGHOFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.GHO());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)), 10 ** 18);
  }

  function test_dustBinHasUSDeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.USDe());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)), 10 ** 18);
  }

  function test_dustBinHasmUSDFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.mUSD());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)), 10 ** 6);
  }

  function test_dustBinHasAUSDFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.AUSD());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)), 10 ** 6);
  }

  function test_dustBinHasWETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.WETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)), 10 ** 18);
  }

  function test_dustBinHascbBTCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.cbBTC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)), 10 ** 8);
  }

  function test_dustBinHaswstETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.wstETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)), 10 ** 18);
  }

  function test_dustBinHasweETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.weETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)), 10 ** 18);
  }

  function test_dustBinHassyrupUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.syrupUSDC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)), 10 ** 6);
  }

  function test_dustBinHassUSDeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.sUSDe());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)), 10 ** 18);
  }

  function test_eModeConfiguration() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    uint8 eMode_Maple_syrupUSDC = _findEModeCategoryId('Maple_syrupUSDC');
    _assertEModeCollateralConfig({
      id: eMode_Maple_syrupUSDC,
      ltv: 90_00,
      liquidationThreshold: 92_00,
      liquidationBonus: 100_00 + 4_00,
      isolated: false
    });

    address[] memory collaterals_Maple_syrupUSDC = new address[](1);
    collaterals_Maple_syrupUSDC[0] = proposal.syrupUSDC();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryCollateralBitmap(eMode_Maple_syrupUSDC),
      _toBitmap(collaterals_Maple_syrupUSDC)
    );

    address[] memory borrowables_Maple_syrupUSDC = new address[](5);
    borrowables_Maple_syrupUSDC[0] = proposal.USDT0();
    borrowables_Maple_syrupUSDC[1] = proposal.USDC();
    borrowables_Maple_syrupUSDC[2] = proposal.GHO();
    borrowables_Maple_syrupUSDC[3] = proposal.mUSD();
    borrowables_Maple_syrupUSDC[4] = proposal.AUSD();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(eMode_Maple_syrupUSDC),
      _toBitmap(borrowables_Maple_syrupUSDC)
    );

    uint8 eMode_Liquid_Leverage = _findEModeCategoryId('Liquid_Leverage');
    _assertEModeCollateralConfig({
      id: eMode_Liquid_Leverage,
      ltv: 90_00,
      liquidationThreshold: 92_00,
      liquidationBonus: 100_00 + 4_00,
      isolated: false
    });

    address[] memory collaterals_Liquid_Leverage = new address[](2);
    collaterals_Liquid_Leverage[0] = proposal.USDe();
    collaterals_Liquid_Leverage[1] = proposal.sUSDe();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryCollateralBitmap(eMode_Liquid_Leverage),
      _toBitmap(collaterals_Liquid_Leverage)
    );

    address[] memory borrowables_Liquid_Leverage = new address[](4);
    borrowables_Liquid_Leverage[0] = proposal.USDT0();
    borrowables_Liquid_Leverage[1] = proposal.USDC();
    borrowables_Liquid_Leverage[2] = proposal.GHO();
    borrowables_Liquid_Leverage[3] = proposal.AUSD();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(eMode_Liquid_Leverage),
      _toBitmap(borrowables_Liquid_Leverage)
    );

    uint8 eMode_Lido_Yield_Maximiser = _findEModeCategoryId('Lido_Yield_Maximiser');
    _assertEModeCollateralConfig({
      id: eMode_Lido_Yield_Maximiser,
      ltv: 94_00,
      liquidationThreshold: 96_00,
      liquidationBonus: 100_00 + 1_00,
      isolated: false
    });

    address[] memory collaterals_Lido_Yield_Maximiser = new address[](1);
    collaterals_Lido_Yield_Maximiser[0] = proposal.wstETH();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryCollateralBitmap(eMode_Lido_Yield_Maximiser),
      _toBitmap(collaterals_Lido_Yield_Maximiser)
    );

    address[] memory borrowables_Lido_Yield_Maximiser = new address[](1);
    borrowables_Lido_Yield_Maximiser[0] = proposal.WETH();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(eMode_Lido_Yield_Maximiser),
      _toBitmap(borrowables_Lido_Yield_Maximiser)
    );

    uint8 eMode_EtherFi_Yield_Maximiser = _findEModeCategoryId('EtherFi_Yield_Maximiser');
    _assertEModeCollateralConfig({
      id: eMode_EtherFi_Yield_Maximiser,
      ltv: 93_00,
      liquidationThreshold: 95_00,
      liquidationBonus: 100_00 + 1_00,
      isolated: false
    });

    address[] memory collaterals_EtherFi_Yield_Maximiser = new address[](1);
    collaterals_EtherFi_Yield_Maximiser[0] = proposal.weETH();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryCollateralBitmap(eMode_EtherFi_Yield_Maximiser),
      _toBitmap(collaterals_EtherFi_Yield_Maximiser)
    );

    address[] memory borrowables_EtherFi_Yield_Maximiser = new address[](1);
    borrowables_EtherFi_Yield_Maximiser[0] = proposal.WETH();
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(eMode_EtherFi_Yield_Maximiser),
      _toBitmap(borrowables_EtherFi_Yield_Maximiser)
    );
  }
  function test_eMode_Maple_syrupUSDC_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyAndBorrowInEMode('Maple_syrupUSDC', proposal.syrupUSDC(), proposal.USDT0());
  }
  function test_eMode_Liquid_Leverage_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyAndBorrowInEMode('Liquid_Leverage', proposal.USDe(), proposal.USDT0());
  }
  function test_eMode_Lido_Yield_Maximiser_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyAndBorrowInEMode('Lido_Yield_Maximiser', proposal.wstETH(), proposal.WETH());
  }
  function test_eMode_EtherFi_Yield_Maximiser_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyAndBorrowInEMode('EtherFi_Yield_Maximiser', proposal.weETH(), proposal.WETH());
  }
  function test_USDeBorrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('borrowWithoutEModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(proposal.USDe()).decimals();
    deal(proposal.USDe(), user, supplyAmount);

    vm.startPrank(user);

    IERC20(proposal.USDe()).approve(address(AaveV3Monad.POOL), supplyAmount);
    AaveV3Monad.POOL.supply(proposal.USDe(), supplyAmount, user, 0);

    // LTV is 0 outside the e-mode, so the borrow must revert
    address borrowAsset = proposal.USDT0();
    vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
    AaveV3Monad.POOL.borrow(borrowAsset, 1, 2, 0, user);

    vm.stopPrank();
  }
  function test_wstETHBorrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('borrowWithoutEModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(proposal.wstETH()).decimals();
    deal(proposal.wstETH(), user, supplyAmount);

    vm.startPrank(user);

    IERC20(proposal.wstETH()).approve(address(AaveV3Monad.POOL), supplyAmount);
    AaveV3Monad.POOL.supply(proposal.wstETH(), supplyAmount, user, 0);

    // LTV is 0 outside the e-mode, so the borrow must revert.
    // Borrow USDT0 (globally borrowable); WETH is borrow-disabled outside the e-modes.
    address borrowAsset = proposal.USDT0();
    vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
    AaveV3Monad.POOL.borrow(borrowAsset, 1, 2, 0, user);

    vm.stopPrank();
  }
  function test_weETHBorrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('borrowWithoutEModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(proposal.weETH()).decimals();
    deal(proposal.weETH(), user, supplyAmount);

    vm.startPrank(user);

    IERC20(proposal.weETH()).approve(address(AaveV3Monad.POOL), supplyAmount);
    AaveV3Monad.POOL.supply(proposal.weETH(), supplyAmount, user, 0);

    // LTV is 0 outside the e-mode, so the borrow must revert.
    // Borrow USDT0 (globally borrowable); WETH is borrow-disabled outside the e-modes.
    address borrowAsset = proposal.USDT0();
    vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
    AaveV3Monad.POOL.borrow(borrowAsset, 1, 2, 0, user);

    vm.stopPrank();
  }
  function test_syrupUSDCBorrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('borrowWithoutEModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(proposal.syrupUSDC()).decimals();
    deal(proposal.syrupUSDC(), user, supplyAmount);

    vm.startPrank(user);

    IERC20(proposal.syrupUSDC()).approve(address(AaveV3Monad.POOL), supplyAmount);
    AaveV3Monad.POOL.supply(proposal.syrupUSDC(), supplyAmount, user, 0);

    // LTV is 0 outside the e-mode, so the borrow must revert
    address borrowAsset = proposal.USDT0();
    vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
    AaveV3Monad.POOL.borrow(borrowAsset, 1, 2, 0, user);

    vm.stopPrank();
  }
  function test_sUSDeBorrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('borrowWithoutEModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(proposal.sUSDe()).decimals();
    deal(proposal.sUSDe(), user, supplyAmount);

    vm.startPrank(user);

    IERC20(proposal.sUSDe()).approve(address(AaveV3Monad.POOL), supplyAmount);
    AaveV3Monad.POOL.supply(proposal.sUSDe(), supplyAmount, user, 0);

    // LTV is 0 outside the e-mode, so the borrow must revert
    address borrowAsset = proposal.USDT0();
    vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
    AaveV3Monad.POOL.borrow(borrowAsset, 1, 2, 0, user);

    vm.stopPrank();
  }
  function _findEModeCategoryId(string memory label) internal view returns (uint8) {
    for (uint8 i = 1; i < 255; i++) {
      if (keccak256(bytes(AaveV3Monad.POOL.getEModeCategoryLabel(i))) == keccak256(bytes(label))) {
        return i;
      }
    }
    revert('eMode category not found');
  }
  function _assertEModeCollateralConfig(
    uint8 id,
    uint256 ltv,
    uint256 liquidationThreshold,
    uint256 liquidationBonus,
    bool isolated
  ) internal view {
    DataTypes.CollateralConfig memory cfg = AaveV3Monad.POOL.getEModeCategoryCollateralConfig(id);
    assertEq(cfg.ltv, ltv);
    assertEq(cfg.liquidationThreshold, liquidationThreshold);
    assertEq(cfg.liquidationBonus, liquidationBonus);
    assertEq(AaveV3Monad.POOL.getIsEModeCategoryIsolated(id), isolated);
  }
  function _toBitmap(address[] memory assets) internal view returns (uint128 bitmap) {
    for (uint256 i = 0; i < assets.length; i++) {
      bitmap |= uint128(1) << AaveV3Monad.POOL.getReserveData(assets[i]).id;
    }
  }
  function _supplyAndBorrowInEMode(
    string memory label,
    address collateral,
    address borrowAsset
  ) internal {
    uint8 eModeId = _findEModeCategoryId(label);

    // seed the pool with borrowable liquidity so the e-mode borrow can be filled
    address liquidityProvider = makeAddr('liquidityProvider');
    uint256 liquidityAmount = 1_000 * 10 ** IERC20Metadata(borrowAsset).decimals();
    deal(borrowAsset, liquidityProvider, liquidityAmount);
    vm.startPrank(liquidityProvider);
    IERC20(borrowAsset).approve(address(AaveV3Monad.POOL), liquidityAmount);
    AaveV3Monad.POOL.supply(borrowAsset, liquidityAmount, liquidityProvider, 0);
    vm.stopPrank();

    address user = makeAddr('eModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(collateral).decimals();
    deal(collateral, user, supplyAmount);

    vm.startPrank(user);

    AaveV3Monad.POOL.setUserEMode(eModeId);

    IERC20(collateral).approve(address(AaveV3Monad.POOL), supplyAmount);
    AaveV3Monad.POOL.supply(collateral, supplyAmount, user, 0);

    uint256 borrowAmount = 10 * 10 ** IERC20Metadata(borrowAsset).decimals();
    AaveV3Monad.POOL.borrow(borrowAsset, borrowAmount, 2, 0, user);

    address vToken = AaveV3Monad.POOL.getReserveVariableDebtToken(borrowAsset);
    assertApproxEqAbs(IERC20(vToken).balanceOf(user), borrowAmount, 1);

    IERC20(borrowAsset).approve(address(AaveV3Monad.POOL), borrowAmount);
    AaveV3Monad.POOL.repay(borrowAsset, borrowAmount, 2, user);
    AaveV3Monad.POOL.withdraw(collateral, supplyAmount / 2, user);

    vm.stopPrank();
  }
}
