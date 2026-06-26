// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Monad} from 'aave-address-book/AaveV3Monad.sol';
import {GovernanceV3Monad} from 'aave-address-book/GovernanceV3Monad.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Monad_AaveV3MonadActivation_20260623} from './AaveV3Monad_AaveV3MonadActivation_20260623.sol';
import {AaveV3Monad_AaveV3MonadGHOListing_20260623} from './AaveV3Monad_AaveV3MonadGHOListing_20260623.sol';

/**
 * @dev Test for AaveV3Monad_AaveV3MonadGHOListing_20260623
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3Monad_AaveV3MonadGHOListing_20260623.t.sol -vv
 */
contract AaveV3Monad_AaveV3MonadGHOListing_20260623_Test is ProtocolV3TestBase {
  AaveV3Monad_AaveV3MonadGHOListing_20260623 internal proposal;
  AaveV3Monad_AaveV3MonadActivation_20260623 internal activation;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('monad'), 83865577);

    // the GHO listing depends on the eModes created by the activation payload, so execute it first
    activation = new AaveV3Monad_AaveV3MonadActivation_20260623();
    deal(activation.USDT0(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.USDT0_SEED_AMOUNT());
    deal(activation.USDC(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.USDC_SEED_AMOUNT());
    deal(activation.USDe(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.USDe_SEED_AMOUNT());
    deal(activation.mUSD(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.mUSD_SEED_AMOUNT());
    deal(activation.AUSD(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.AUSD_SEED_AMOUNT());
    deal(activation.WETH(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.WETH_SEED_AMOUNT());
    deal(activation.cbBTC(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.cbBTC_SEED_AMOUNT());
    deal(activation.wstETH(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.wstETH_SEED_AMOUNT());
    deal(activation.weETH(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.weETH_SEED_AMOUNT());
    deal(
      activation.syrupUSDC(),
      GovernanceV3Monad.EXECUTOR_LVL_1,
      activation.syrupUSDC_SEED_AMOUNT()
    );
    deal(activation.sUSDe(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.sUSDe_SEED_AMOUNT());
    GovV3Helpers.executePayload(vm, address(activation));

    proposal = new AaveV3Monad_AaveV3MonadGHOListing_20260623();
    deal(proposal.GHO(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.GHO_SEED_AMOUNT());
  }

  /**
   * @dev AUSD uses namespaced storage that forge-std `deal` cannot write; the generic e2e funds
   * test users via `deal`, so route AUSD through an on-chain holder instead.
   */
  function deal(address token, address to, uint256 give) internal override {
    if (token == activation.AUSD()) {
      vm.prank(0xD5D960E8C380B724a48AC59E2DfF1b2CB4a1eAee);
      IERC20(token).transfer(to, give);
      return;
    }
    super.deal(token, to, give);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    // GHO has no supply on Monad yet; give it a non-zero total supply so the newly-listed-asset
    // supply-cap plausibility check (supplyCap vs token totalSupply) passes
    deal(proposal.GHO(), makeAddr('ghoSupply'), 1_000_000 * 10 ** 18, true);

    defaultTest('AaveV3Monad_AaveV3MonadGHOListing_20260623', AaveV3Monad.POOL, address(proposal));
  }

  function test_dustBinHasGHOFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.GHO());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)),
      proposal.GHO_SEED_AMOUNT()
    );
  }

  function test_priceFeedMatchesProposal() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    // GHO uses a fixed $1 feed, so there is no underlying SVR feed to unwrap
    assertEq(
      AaveV3Monad.ORACLE.getSourceOfAsset(proposal.GHO()),
      proposal.GHO_PRICE_FEED(),
      'oracle source != listed price feed'
    );
  }

  function test_GHOAddedToEModes() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address[] memory gho = new address[](1);
    gho[0] = proposal.GHO();
    uint128 ghoBitmap = _toBitmap(gho);

    uint8 eMode_syrupUSDC__Stablecoins = _findEModeCategoryId('syrupUSDC__Stablecoins');
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(eMode_syrupUSDC__Stablecoins) & ghoBitmap,
      ghoBitmap
    );
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryCollateralBitmap(eMode_syrupUSDC__Stablecoins) & ghoBitmap,
      0
    );

    uint8 eMode_USDe_sUSDe__Stablecoins = _findEModeCategoryId('USDe_sUSDe__Stablecoins');
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(eMode_USDe_sUSDe__Stablecoins) & ghoBitmap,
      ghoBitmap
    );
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryCollateralBitmap(eMode_USDe_sUSDe__Stablecoins) & ghoBitmap,
      0
    );
  }

  function test_GHOEModesPreserveExistingConfiguration() public {
    EModeSnapshot memory syrupBefore = _snapshotEMode('syrupUSDC__Stablecoins');
    EModeSnapshot memory usdeBefore = _snapshotEMode('USDe_sUSDe__Stablecoins');

    GovV3Helpers.executePayload(vm, address(proposal));

    address[] memory gho = new address[](1);
    gho[0] = proposal.GHO();
    uint128 ghoBitmap = _toBitmap(gho);

    // GHO was not borrowable in these eModes before the listing
    assertEq(syrupBefore.borrowableBitmap & ghoBitmap, 0);
    assertEq(usdeBefore.borrowableBitmap & ghoBitmap, 0);

    // category risk params, label and the collateral set are untouched by adding GHO
    _assertEModeParamsAndCollateralUnchanged(syrupBefore);
    _assertEModeParamsAndCollateralUnchanged(usdeBefore);

    // the previously borrowable assets are preserved; GHO is the only addition
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(syrupBefore.id),
      syrupBefore.borrowableBitmap | ghoBitmap
    );
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(usdeBefore.id),
      usdeBefore.borrowableBitmap | ghoBitmap
    );
  }

  function test_otherEModesUnaffectedByGHOListing() public {
    EModeSnapshot memory wstethBefore = _snapshotEMode('wstETH__WETH');
    EModeSnapshot memory weethBefore = _snapshotEMode('weETH__WETH');

    GovV3Helpers.executePayload(vm, address(proposal));

    // GHO is not added to these eModes, so nothing about them may change
    _assertEModeParamsAndCollateralUnchanged(wstethBefore);
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(wstethBefore.id),
      wstethBefore.borrowableBitmap
    );

    _assertEModeParamsAndCollateralUnchanged(weethBefore);
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(weethBefore.id),
      weethBefore.borrowableBitmap
    );
  }

  function test_existingReservesUnaffectedByGHOListing() public {
    ReserveConfig[] memory configsBefore = _getReservesConfigs(AaveV3Monad.POOL);

    GovV3Helpers.executePayload(vm, address(proposal));

    ReserveConfig[] memory configsAfter = _getReservesConfigs(AaveV3Monad.POOL);

    // GHO is the only new reserve; every previously listed reserve must be unchanged
    assertEq(configsAfter.length, configsBefore.length + 1);
    for (uint256 i = 0; i < configsBefore.length; i++) {
      _requireNoChangeInConfigs(
        configsBefore[i],
        _findReserveConfig(configsAfter, configsBefore[i].underlying)
      );
    }
  }

  function test_revertsIfActivationNotExecuted() public {
    // fork a clean state where the activation payload has not run yet, so the pool has 0 reserves
    vm.createSelectFork(vm.rpcUrl('monad'), 83865577);
    AaveV3Monad_AaveV3MonadGHOListing_20260623 ghoListing = new AaveV3Monad_AaveV3MonadGHOListing_20260623();

    vm.expectRevert(bytes('ACTIVATION_PAYLOAD_NOT_EXECUTED'));
    ghoListing.execute();
  }

  struct EModeSnapshot {
    uint8 id;
    string label;
    DataTypes.CollateralConfig collateralConfig;
    bool isolated;
    uint128 collateralBitmap;
    uint128 borrowableBitmap;
  }

  function _snapshotEMode(string memory label) internal view returns (EModeSnapshot memory snap) {
    snap.id = _findEModeCategoryId(label);
    snap.label = label;
    snap.collateralConfig = AaveV3Monad.POOL.getEModeCategoryCollateralConfig(snap.id);
    snap.isolated = AaveV3Monad.POOL.getIsEModeCategoryIsolated(snap.id);
    snap.collateralBitmap = AaveV3Monad.POOL.getEModeCategoryCollateralBitmap(snap.id);
    snap.borrowableBitmap = AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(snap.id);
  }

  function _assertEModeParamsAndCollateralUnchanged(EModeSnapshot memory snap) internal view {
    assertEq(AaveV3Monad.POOL.getEModeCategoryLabel(snap.id), snap.label);

    DataTypes.CollateralConfig memory cfg = AaveV3Monad.POOL.getEModeCategoryCollateralConfig(
      snap.id
    );
    assertEq(cfg.ltv, snap.collateralConfig.ltv);
    assertEq(cfg.liquidationThreshold, snap.collateralConfig.liquidationThreshold);
    assertEq(cfg.liquidationBonus, snap.collateralConfig.liquidationBonus);
    assertEq(AaveV3Monad.POOL.getIsEModeCategoryIsolated(snap.id), snap.isolated);
    assertEq(AaveV3Monad.POOL.getEModeCategoryCollateralBitmap(snap.id), snap.collateralBitmap);
  }

  function _findEModeCategoryId(string memory label) internal view returns (uint8) {
    for (uint8 i = 1; i < 255; i++) {
      if (keccak256(bytes(AaveV3Monad.POOL.getEModeCategoryLabel(i))) == keccak256(bytes(label))) {
        return i;
      }
    }
    revert('eMode category not found');
  }

  function _toBitmap(address[] memory assets) internal view returns (uint128 bitmap) {
    for (uint256 i = 0; i < assets.length; i++) {
      bitmap |= uint128(1) << AaveV3Monad.POOL.getReserveData(assets[i]).id;
    }
  }
}
