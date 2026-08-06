// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Mantle, AaveV3MantleAssets} from 'aave-address-book/AaveV3Mantle.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Mantle_AaveV3LTVAndEModeUpdate_20260707} from './AaveV3Mantle_AaveV3LTVAndEModeUpdate_20260707.sol';

/**
 * @dev Test for AaveV3Mantle_AaveV3LTVAndEModeUpdate_20260707
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3Mantle_AaveV3LTVAndEModeUpdate_20260707.t.sol -vv
 */
contract AaveV3Mantle_AaveV3LTVAndEModeUpdate_20260707_Test is ProtocolV3TestBase {
  AaveV3Mantle_AaveV3LTVAndEModeUpdate_20260707 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mantle'), 97914064);
    proposal = new AaveV3Mantle_AaveV3LTVAndEModeUpdate_20260707();
  }

  function test_preProposalLtv() public view {
    ReserveConfig[] memory configs = _getReservesConfigs(AaveV3Mantle.POOL);
    ReserveConfig memory wethConfig = _findReserveConfig(
      configs,
      AaveV3MantleAssets.WETH_UNDERLYING
    );
    ReserveConfig memory wmntConfig = _findReserveConfig(
      configs,
      AaveV3MantleAssets.WMNT_UNDERLYING
    );

    assertEq(wethConfig.ltv, 80_50);
    assertEq(wmntConfig.ltv, 40_00);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Mantle_AaveV3LTVAndEModeUpdate_20260707',
      AaveV3Mantle.POOL,
      address(proposal)
    );
  }

  /**
   * @dev checks whether reserve configurations changed or stayed unchanged as expected
   */
  function test_reserveConfigChanges() public {
    address[] memory updatedAssets = new address[](2);
    updatedAssets[0] = AaveV3MantleAssets.WETH_UNDERLYING;
    updatedAssets[1] = AaveV3MantleAssets.WMNT_UNDERLYING;
    reserveConfigChangesTest(AaveV3Mantle.POOL, address(proposal), updatedAssets);
  }

  function _expectedCollateralChanges()
    internal
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[] memory collateralUpdate;
    collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](2);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3MantleAssets.WETH_UNDERLYING,
      ltv: 0,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[1] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3MantleAssets.WMNT_UNDERLYING,
      ltv: 0,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    return collateralUpdate;
  }
  function test_eModeConfiguration() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    uint8 eMode_WMNT__Stablecoins = _findEModeCategoryId('WMNT__Stablecoins');
    _assertEModeCollateralConfig({
      id: eMode_WMNT__Stablecoins,
      ltv: 40_00,
      liquidationThreshold: 45_00,
      liquidationBonus: 100_00 + 10_00,
      isolated: true
    });

    address[] memory collaterals_WMNT__Stablecoins = new address[](1);
    collaterals_WMNT__Stablecoins[0] = AaveV3MantleAssets.WMNT_UNDERLYING;
    assertEq(
      AaveV3Mantle.POOL.getEModeCategoryCollateralBitmap(eMode_WMNT__Stablecoins),
      _toBitmap(collaterals_WMNT__Stablecoins)
    );

    address[] memory borrowables_WMNT__Stablecoins = new address[](3);
    borrowables_WMNT__Stablecoins[0] = AaveV3MantleAssets.USDT0_UNDERLYING;
    borrowables_WMNT__Stablecoins[1] = AaveV3MantleAssets.USDC_UNDERLYING;
    borrowables_WMNT__Stablecoins[2] = AaveV3MantleAssets.GHO_UNDERLYING;
    assertEq(
      AaveV3Mantle.POOL.getEModeCategoryBorrowableBitmap(eMode_WMNT__Stablecoins),
      _toBitmap(borrowables_WMNT__Stablecoins)
    );
  }
  function test_eMode_WMNT__Stablecoins_supplyAndBorrow() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    _supplyAndBorrowInEMode(
      'WMNT__Stablecoins',
      AaveV3MantleAssets.WMNT_UNDERLYING,
      AaveV3MantleAssets.USDT0_UNDERLYING
    );
  }
  function _findEModeCategoryId(string memory label) internal view returns (uint8) {
    for (uint8 i = 1; i < 255; i++) {
      if (keccak256(bytes(AaveV3Mantle.POOL.getEModeCategoryLabel(i))) == keccak256(bytes(label))) {
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
    DataTypes.CollateralConfig memory cfg = AaveV3Mantle.POOL.getEModeCategoryCollateralConfig(id);
    assertEq(cfg.ltv, ltv);
    assertEq(cfg.liquidationThreshold, liquidationThreshold);
    assertEq(cfg.liquidationBonus, liquidationBonus);
    assertEq(AaveV3Mantle.POOL.getIsEModeCategoryIsolated(id), isolated);
  }
  function _toBitmap(address[] memory assets) internal view returns (uint128 bitmap) {
    for (uint256 i = 0; i < assets.length; i++) {
      bitmap |= uint128(1) << AaveV3Mantle.POOL.getReserveData(assets[i]).id;
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

    AaveV3Mantle.POOL.setUserEMode(eModeId);

    IERC20(collateral).approve(address(AaveV3Mantle.POOL), supplyAmount);
    AaveV3Mantle.POOL.supply(collateral, supplyAmount, user, 0);

    uint256 borrowAmount = 10 * 10 ** IERC20Metadata(borrowAsset).decimals();
    AaveV3Mantle.POOL.borrow(borrowAsset, borrowAmount, 2, 0, user);

    address vToken = AaveV3Mantle.POOL.getReserveVariableDebtToken(borrowAsset);
    assertApproxEqAbs(IERC20(vToken).balanceOf(user), borrowAmount, 1);

    IERC20(borrowAsset).approve(address(AaveV3Mantle.POOL), borrowAmount);
    AaveV3Mantle.POOL.repay(borrowAsset, borrowAmount, 2, user);
    AaveV3Mantle.POOL.withdraw(collateral, supplyAmount / 2, user);

    vm.stopPrank();
  }
}
