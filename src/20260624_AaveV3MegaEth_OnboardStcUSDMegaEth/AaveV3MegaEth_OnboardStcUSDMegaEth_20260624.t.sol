// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3MegaEth, AaveV3MegaEthAssets} from 'aave-address-book/AaveV3MegaEth.sol';
import {GovernanceV3MegaEth} from 'aave-address-book/GovernanceV3MegaEth.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {Errors} from 'aave-v3-origin/contracts/protocol/libraries/helpers/Errors.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3MegaEth_OnboardStcUSDMegaEth_20260624} from './AaveV3MegaEth_OnboardStcUSDMegaEth_20260624.sol';

/**
 * @dev Test for AaveV3MegaEth_OnboardStcUSDMegaEth_20260624
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260624_AaveV3MegaEth_OnboardStcUSDMegaEth/AaveV3MegaEth_OnboardStcUSDMegaEth_20260624.t.sol -vv
 */
contract AaveV3MegaEth_OnboardStcUSDMegaEth_20260624_Test is ProtocolV3TestBase {
  AaveV3MegaEth_OnboardStcUSDMegaEth_20260624 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('megaeth'), 19510725);
    proposal = new AaveV3MegaEth_OnboardStcUSDMegaEth_20260624();

    // Seed the executor with stcUSD until it is funded on-chain, so _postExecute can supply the seed amount
    deal(proposal.stcUSD(), GovernanceV3MegaEth.EXECUTOR_LVL_1, proposal.stcUSD_SEED_AMOUNT());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3MegaEth_OnboardStcUSDMegaEth_20260624',
      AaveV3MegaEth.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasstcUSDFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3MegaEth.POOL.getReserveAToken(proposal.stcUSD());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3MegaEth.DUST_BIN)), 10 ** 18);
  }

  function test_eModeConfiguration() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    uint8 eMode_StcUSD_Stablecoins = _findEModeCategoryId('stcUSD_Stablecoins');
    _assertEModeCollateralConfig({
      id: eMode_StcUSD_Stablecoins,
      ltv: 88_00,
      liquidationThreshold: 90_00,
      liquidationBonus: 100_00 + 4_00,
      isolated: true
    });

    address[] memory collaterals_StcUSD_Stablecoins = new address[](1);
    collaterals_StcUSD_Stablecoins[0] = proposal.stcUSD();
    assertEq(
      AaveV3MegaEth.POOL.getEModeCategoryCollateralBitmap(eMode_StcUSD_Stablecoins),
      _toBitmap(collaterals_StcUSD_Stablecoins)
    );

    address[] memory borrowables_StcUSD_Stablecoins = new address[](2);
    borrowables_StcUSD_Stablecoins[0] = AaveV3MegaEthAssets.USDT0_UNDERLYING;
    borrowables_StcUSD_Stablecoins[1] = AaveV3MegaEthAssets.USDm_UNDERLYING;
    assertEq(
      AaveV3MegaEth.POOL.getEModeCategoryBorrowableBitmap(eMode_StcUSD_Stablecoins),
      _toBitmap(borrowables_StcUSD_Stablecoins)
    );
  }
  function test_eMode_StcUSD_Stablecoins_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyAndBorrowInEMode(
      'stcUSD_Stablecoins',
      proposal.stcUSD(),
      AaveV3MegaEthAssets.USDT0_UNDERLYING
    );
  }
  function test_stcUSDBorrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    // USDT0 is unfunded at the fork block, so seed borrowable liquidity before borrowing
    _seedLiquidity(AaveV3MegaEthAssets.USDT0_UNDERLYING, 10_000);

    address user = makeAddr('borrowWithoutEModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(proposal.stcUSD()).decimals();
    deal(proposal.stcUSD(), user, supplyAmount);

    vm.startPrank(user);

    IERC20(proposal.stcUSD()).approve(address(AaveV3MegaEth.POOL), supplyAmount);
    AaveV3MegaEth.POOL.supply(proposal.stcUSD(), supplyAmount, user, 0);

    // LTV is 0 outside the e-mode, so the borrow must revert
    vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
    AaveV3MegaEth.POOL.borrow(AaveV3MegaEthAssets.USDT0_UNDERLYING, 1, 2, 0, user);

    vm.stopPrank();
  }
  function _seedLiquidity(address asset, uint256 wholeTokens) internal {
    uint256 amount = wholeTokens * 10 ** IERC20Metadata(asset).decimals();
    address liquidityProvider = makeAddr('liquidityProvider');
    deal(asset, liquidityProvider, amount);

    vm.startPrank(liquidityProvider);
    IERC20(asset).approve(address(AaveV3MegaEth.POOL), amount);
    AaveV3MegaEth.POOL.supply(asset, amount, liquidityProvider, 0);
    vm.stopPrank();
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
  function _assertEModeCollateralConfig(
    uint8 id,
    uint256 ltv,
    uint256 liquidationThreshold,
    uint256 liquidationBonus,
    bool isolated
  ) internal view {
    DataTypes.CollateralConfig memory cfg = AaveV3MegaEth.POOL.getEModeCategoryCollateralConfig(id);
    assertEq(cfg.ltv, ltv);
    assertEq(cfg.liquidationThreshold, liquidationThreshold);
    assertEq(cfg.liquidationBonus, liquidationBonus);
    assertEq(AaveV3MegaEth.POOL.getIsEModeCategoryIsolated(id), isolated);
  }
  function _toBitmap(address[] memory assets) internal view returns (uint128 bitmap) {
    for (uint256 i = 0; i < assets.length; i++) {
      bitmap |= uint128(1) << AaveV3MegaEth.POOL.getReserveData(assets[i]).id;
    }
  }
  function _supplyAndBorrowInEMode(
    string memory label,
    address collateral,
    address borrowAsset
  ) internal {
    uint8 eModeId = _findEModeCategoryId(label);

    // the borrowable reserve is unfunded at the fork block, so seed liquidity before borrowing
    _seedLiquidity(borrowAsset, 10_000);

    address user = makeAddr('eModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(collateral).decimals();
    deal(collateral, user, supplyAmount);

    vm.startPrank(user);

    AaveV3MegaEth.POOL.setUserEMode(eModeId);

    IERC20(collateral).approve(address(AaveV3MegaEth.POOL), supplyAmount);
    AaveV3MegaEth.POOL.supply(collateral, supplyAmount, user, 0);

    uint256 borrowAmount = 10 * 10 ** IERC20Metadata(borrowAsset).decimals();
    AaveV3MegaEth.POOL.borrow(borrowAsset, borrowAmount, 2, 0, user);

    address vToken = AaveV3MegaEth.POOL.getReserveVariableDebtToken(borrowAsset);
    assertApproxEqAbs(IERC20(vToken).balanceOf(user), borrowAmount, 1);

    IERC20(borrowAsset).approve(address(AaveV3MegaEth.POOL), borrowAmount);
    AaveV3MegaEth.POOL.repay(borrowAsset, borrowAmount, 2, user);
    AaveV3MegaEth.POOL.withdraw(collateral, supplyAmount / 2, user);

    vm.stopPrank();
  }
}
