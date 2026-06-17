// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {Errors} from 'aave-v3-origin/contracts/protocol/libraries/helpers/Errors.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_OnBoardPTsrUSDe22Oct2026EthereumCore_20260617} from './AaveV3Ethereum_OnBoardPTsrUSDe22Oct2026EthereumCore_20260617.sol';

/**
 * @dev Test for AaveV3Ethereum_OnBoardPTsrUSDe22Oct2026EthereumCore_20260617
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260617_AaveV3Ethereum_OnBoardPTsrUSDe22Oct2026EthereumCore/AaveV3Ethereum_OnBoardPTsrUSDe22Oct2026EthereumCore_20260617.t.sol -vv
 */
contract AaveV3Ethereum_OnBoardPTsrUSDe22Oct2026EthereumCore_20260617_Test is ProtocolV3TestBase {
  AaveV3Ethereum_OnBoardPTsrUSDe22Oct2026EthereumCore_20260617 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25337409);
    proposal = new AaveV3Ethereum_OnBoardPTsrUSDe22Oct2026EthereumCore_20260617();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_OnBoardPTsrUSDe22Oct2026EthereumCore_20260617',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasPT_srUSDe_22OCT2026Funds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Ethereum.POOL.getReserveAToken(proposal.PT_srUSDe_22OCT2026());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.DUST_BIN)), 10 ** 18);
  }

  function test_eModeConfiguration() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    uint8 eMode_PTSrUSDeStablecoins = _findEModeCategoryId('PT-srUSDe Stablecoins');
    _assertEModeCollateralConfig({
      id: eMode_PTSrUSDeStablecoins,
      ltv: 88_42,
      liquidationThreshold: 90_42,
      liquidationBonus: 100_00 + 5_68,
      isolated: true
    });

    address[] memory collaterals_PTSrUSDeStablecoins = new address[](2);
    collaterals_PTSrUSDeStablecoins[0] = AaveV3EthereumAssets.sUSDe_UNDERLYING;
    collaterals_PTSrUSDeStablecoins[1] = proposal.PT_srUSDe_22OCT2026();
    assertEq(
      AaveV3Ethereum.POOL.getEModeCategoryCollateralBitmap(eMode_PTSrUSDeStablecoins),
      _toBitmap(collaterals_PTSrUSDeStablecoins)
    );

    address[] memory borrowables_PTSrUSDeStablecoins = new address[](3);
    borrowables_PTSrUSDeStablecoins[0] = AaveV3EthereumAssets.USDC_UNDERLYING;
    borrowables_PTSrUSDeStablecoins[1] = AaveV3EthereumAssets.USDT_UNDERLYING;
    borrowables_PTSrUSDeStablecoins[2] = AaveV3EthereumAssets.USDe_UNDERLYING;
    assertEq(
      AaveV3Ethereum.POOL.getEModeCategoryBorrowableBitmap(eMode_PTSrUSDeStablecoins),
      _toBitmap(borrowables_PTSrUSDeStablecoins)
    );

    uint8 eMode_PTSrUSDeUSDe = _findEModeCategoryId('PT-srUSDe USDe');
    _assertEModeCollateralConfig({
      id: eMode_PTSrUSDeUSDe,
      ltv: 91_06,
      liquidationThreshold: 93_06,
      liquidationBonus: 100_00 + 2_68,
      isolated: true
    });

    address[] memory collaterals_PTSrUSDeUSDe = new address[](2);
    collaterals_PTSrUSDeUSDe[0] = AaveV3EthereumAssets.sUSDe_UNDERLYING;
    collaterals_PTSrUSDeUSDe[1] = proposal.PT_srUSDe_22OCT2026();
    assertEq(
      AaveV3Ethereum.POOL.getEModeCategoryCollateralBitmap(eMode_PTSrUSDeUSDe),
      _toBitmap(collaterals_PTSrUSDeUSDe)
    );

    address[] memory borrowables_PTSrUSDeUSDe = new address[](1);
    borrowables_PTSrUSDeUSDe[0] = AaveV3EthereumAssets.USDe_UNDERLYING;
    assertEq(
      AaveV3Ethereum.POOL.getEModeCategoryBorrowableBitmap(eMode_PTSrUSDeUSDe),
      _toBitmap(borrowables_PTSrUSDeUSDe)
    );
  }
  function test_eMode_PTSrUSDeStablecoins_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyAndBorrowInEMode(
      'PT-srUSDe Stablecoins',
      AaveV3EthereumAssets.sUSDe_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING
    );
  }
  function test_eMode_PTSrUSDeUSDe_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyAndBorrowInEMode(
      'PT-srUSDe USDe',
      AaveV3EthereumAssets.sUSDe_UNDERLYING,
      AaveV3EthereumAssets.USDe_UNDERLYING
    );
  }
  function test_PT_srUSDe_22OCT2026BorrowWithoutEModeReverts() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address user = makeAddr('borrowWithoutEModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(proposal.PT_srUSDe_22OCT2026()).decimals();
    deal(proposal.PT_srUSDe_22OCT2026(), user, supplyAmount);

    vm.startPrank(user);

    IERC20(proposal.PT_srUSDe_22OCT2026()).approve(address(AaveV3Ethereum.POOL), supplyAmount);
    AaveV3Ethereum.POOL.supply(proposal.PT_srUSDe_22OCT2026(), supplyAmount, user, 0);

    // LTV is 0 outside the e-mode, so the borrow must revert
    vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
    AaveV3Ethereum.POOL.borrow(AaveV3EthereumAssets.USDC_UNDERLYING, 1, 2, 0, user);

    vm.stopPrank();
  }
  function _findEModeCategoryId(string memory label) internal view returns (uint8) {
    for (uint8 i = 1; i < 255; i++) {
      if (
        keccak256(bytes(AaveV3Ethereum.POOL.getEModeCategoryLabel(i))) == keccak256(bytes(label))
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
    DataTypes.CollateralConfig memory cfg = AaveV3Ethereum.POOL.getEModeCategoryCollateralConfig(
      id
    );
    assertEq(cfg.ltv, ltv);
    assertEq(cfg.liquidationThreshold, liquidationThreshold);
    assertEq(cfg.liquidationBonus, liquidationBonus);
    assertEq(AaveV3Ethereum.POOL.getIsEModeCategoryIsolated(id), isolated);
  }
  function _toBitmap(address[] memory assets) internal view returns (uint128 bitmap) {
    for (uint256 i = 0; i < assets.length; i++) {
      bitmap |= uint128(1) << AaveV3Ethereum.POOL.getReserveData(assets[i]).id;
    }
  }
  function _supplyAndBorrowInEMode(
    string memory label,
    address collateral,
    address borrowAsset
  ) internal {
    uint8 eModeId = _findEModeCategoryId(label);

    address user = makeAddr('eModeUser');
    uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(collateral).decimals();
    deal(collateral, user, supplyAmount);

    vm.startPrank(user);

    AaveV3Ethereum.POOL.setUserEMode(eModeId);

    IERC20(collateral).approve(address(AaveV3Ethereum.POOL), supplyAmount);
    AaveV3Ethereum.POOL.supply(collateral, supplyAmount, user, 0);

    uint256 borrowAmount = 10 * 10 ** IERC20Metadata(borrowAsset).decimals();
    AaveV3Ethereum.POOL.borrow(borrowAsset, borrowAmount, 2, 0, user);

    address vToken = AaveV3Ethereum.POOL.getReserveVariableDebtToken(borrowAsset);
    assertApproxEqAbs(IERC20(vToken).balanceOf(user), borrowAmount, 2);

    IERC20(borrowAsset).approve(address(AaveV3Ethereum.POOL), borrowAmount);
    AaveV3Ethereum.POOL.repay(borrowAsset, borrowAmount, 2, user);
    AaveV3Ethereum.POOL.withdraw(collateral, supplyAmount / 2, user);

    vm.stopPrank();
  }
}
