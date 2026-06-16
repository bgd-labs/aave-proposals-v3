import {ENGINE_FLAGS, MarketIdentifier} from '../types';
import {EModeCategoryCreation, EModeCategoryUpdate, Listing} from './types';
import {pascalCase} from '../common';
import {testExecuteProposal} from '../utils/constants';
import {translateJsPercentToSol} from '../prompts/percentPrompt';

export function translateAssetForTest(
  value: string,
  market: MarketIdentifier,
  newListings: ReadonlySet<string>,
) {
  if (newListings.has(value)) return `proposal.${value}()`;
  return `${market}Assets.${value}_UNDERLYING`;
}

export function eModeTestHelpers(market: MarketIdentifier): string[] {
  return [
    `function _findEModeCategoryId(string memory label) internal view returns (uint8) {
      for (uint8 i = 1; i < 255; i++) {
        if (keccak256(bytes(${market}.POOL.getEModeCategoryLabel(i))) == keccak256(bytes(label))) {
          return i;
        }
      }
      revert('eMode category not found');
    }`,
    `function _assertEModeCollateralConfig(
      uint8 id,
      uint256 ltv,
      uint256 liquidationThreshold,
      uint256 liquidationBonus,
      bool isolated
    ) internal view {
      DataTypes.CollateralConfig memory cfg = ${market}.POOL.getEModeCategoryCollateralConfig(id);
      assertEq(cfg.ltv, ltv);
      assertEq(cfg.liquidationThreshold, liquidationThreshold);
      assertEq(cfg.liquidationBonus, liquidationBonus);
      assertEq(${market}.POOL.getIsEModeCategoryIsolated(id), isolated);
    }`,
    `function _toBitmap(address[] memory assets) internal view returns (uint128 bitmap) {
      for (uint256 i = 0; i < assets.length; i++) {
        bitmap |= uint128(1) << ${market}.POOL.getReserveData(assets[i]).id;
      }
    }`,
    `function _supplyAndBorrowInEMode(string memory label, address collateral, address borrowAsset) internal {
      uint8 eModeId = _findEModeCategoryId(label);

      address user = makeAddr('eModeUser');
      uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(collateral).decimals();
      deal(collateral, user, supplyAmount);

      vm.startPrank(user);

      ${market}.POOL.setUserEMode(eModeId);

      IERC20(collateral).approve(address(${market}.POOL), supplyAmount);
      ${market}.POOL.supply(collateral, supplyAmount, user, 0);

      uint256 borrowAmount = 10 * 10 ** IERC20Metadata(borrowAsset).decimals();
      ${market}.POOL.borrow(borrowAsset, borrowAmount, 2, 0, user);

      address vToken = ${market}.POOL.getReserveVariableDebtToken(borrowAsset);
      assertApproxEqAbs(IERC20(vToken).balanceOf(user), borrowAmount, 1);

      IERC20(borrowAsset).approve(address(${market}.POOL), borrowAmount);
      ${market}.POOL.repay(borrowAsset, borrowAmount, 2, user);
      ${market}.POOL.withdraw(collateral, supplyAmount / 2, user);

      vm.stopPrank();
    }`,
  ];
}

function eModeConfigurationTest(
  market: MarketIdentifier,
  cfgs: EModeCategoryCreation[],
  newListings: ReadonlySet<string>,
): string {
  const blocks = cfgs
    .map((cfg) => {
      const suffix = pascalCase(cfg.label);
      const idVar = `eMode_${suffix}`;
      return `uint8 ${idVar} = _findEModeCategoryId('${cfg.label}');
      _assertEModeCollateralConfig({
        id: ${idVar},
        ltv: ${translateJsPercentToSol(cfg.ltv)},
        liquidationThreshold: ${translateJsPercentToSol(cfg.liqThreshold)},
        liquidationBonus: 100_00 + ${translateJsPercentToSol(cfg.liqBonus)},
        isolated: ${cfg.isolated === 'ENABLED'}
      });

      address[] memory collaterals_${suffix} = new address[](${cfg.collateralAssets.length});
      ${cfg.collateralAssets
        .map(
          (asset, i) =>
            `collaterals_${suffix}[${i}] = ${translateAssetForTest(asset, market, newListings)};`,
        )
        .join('\n')}
      assertEq(${market}.POOL.getEModeCategoryCollateralBitmap(${idVar}), _toBitmap(collaterals_${suffix}));

      address[] memory borrowables_${suffix} = new address[](${cfg.borrowableAssets.length});
      ${cfg.borrowableAssets
        .map(
          (asset, i) =>
            `borrowables_${suffix}[${i}] = ${translateAssetForTest(asset, market, newListings)};`,
        )
        .join('\n')}
      assertEq(${market}.POOL.getEModeCategoryBorrowableBitmap(${idVar}), _toBitmap(borrowables_${suffix}));`;
    })
    .join('\n\n');

  return `function test_eModeConfiguration() public {
      ${testExecuteProposal(market)}
      ${blocks}
    }`;
}

export function eModeCreationTests(
  market: MarketIdentifier,
  cfgs: EModeCategoryCreation[],
  newListings: ReadonlySet<string>,
  listings: Listing[],
): string[] {
  const fns: string[] = [eModeConfigurationTest(market, cfgs, newListings)];

  for (const cfg of cfgs) {
    if (!cfg.collateralAssets.length || !cfg.borrowableAssets.length) continue;
    const collateral = cfg.collateralAssets[0];
    const borrowable =
      cfg.borrowableAssets.find((b) => !newListings.has(b) && b !== collateral) ??
      cfg.borrowableAssets.find((b) => b !== collateral) ??
      cfg.borrowableAssets[0];
    fns.push(`function test_eMode_${pascalCase(cfg.label)}_supplyAndBorrow() public {
      ${testExecuteProposal(market)}
      _supplyAndBorrowInEMode('${cfg.label}', ${translateAssetForTest(
        collateral,
        market,
        newListings,
      )}, ${translateAssetForTest(borrowable, market, newListings)});
    }`);
  }

  for (const listing of listings) {
    if (Number(listing.ltv) !== 0) continue;
    const eMode = cfgs.find((c) => c.collateralAssets.includes(listing.assetSymbol));
    if (!eMode || !eMode.borrowableAssets.length) continue;
    const borrowable =
      eMode.borrowableAssets.find((b) => !newListings.has(b)) ?? eMode.borrowableAssets[0];
    fns.push(`function test_${listing.assetSymbol}BorrowWithoutEModeReverts() public {
      ${testExecuteProposal(market)}

      address user = makeAddr('borrowWithoutEModeUser');
      uint256 supplyAmount = 1_000 * 10 ** IERC20Metadata(proposal.${listing.assetSymbol}()).decimals();
      deal(proposal.${listing.assetSymbol}(), user, supplyAmount);

      vm.startPrank(user);

      IERC20(proposal.${listing.assetSymbol}()).approve(address(${market}.POOL), supplyAmount);
      ${market}.POOL.supply(proposal.${listing.assetSymbol}(), supplyAmount, user, 0);

      // LTV is 0 outside the e-mode, so the borrow must revert
      vm.expectRevert(abi.encodeWithSelector(Errors.LtvValidationFailed.selector));
      ${market}.POOL.borrow(${translateAssetForTest(borrowable, market, newListings)}, 1, 2, 0, user);

      vm.stopPrank();
    }`);
  }

  return [...fns, ...eModeTestHelpers(market)];
}

export function eModeUpdateTests(market: MarketIdentifier, cfgs: EModeCategoryUpdate[]): string[] {
  const KEEP_CURRENT = 'EngineFlags.KEEP_CURRENT';
  const beforeBlocks: string[] = [];
  const assertBlocks: string[] = [];

  cfgs.forEach((cfg, ix) => {
    const cfgVar = `cfg_${ix}`;
    const beforeVar = `before_${ix}`;
    const isolatedBeforeVar = `beforeIsolated_${ix}`;
    const ltv = translateJsPercentToSol(cfg.ltv);
    const liqThreshold = translateJsPercentToSol(cfg.liqThreshold);
    const liqBonus = translateJsPercentToSol(cfg.liqBonus);

    if ([ltv, liqThreshold, liqBonus].includes(KEEP_CURRENT))
      beforeBlocks.push(
        `DataTypes.CollateralConfig memory ${beforeVar} = ${market}.POOL.getEModeCategoryCollateralConfig(${cfg.eModeCategory});`,
      );
    if (cfg.isolated === ENGINE_FLAGS.KEEP_CURRENT)
      beforeBlocks.push(
        `bool ${isolatedBeforeVar} = ${market}.POOL.getIsEModeCategoryIsolated(${cfg.eModeCategory});`,
      );

    const asserts: string[] = [
      `DataTypes.CollateralConfig memory ${cfgVar} = ${market}.POOL.getEModeCategoryCollateralConfig(${cfg.eModeCategory});`,
      `assertEq(${cfgVar}.ltv, ${ltv === KEEP_CURRENT ? `${beforeVar}.ltv` : ltv});`,
      `assertEq(${cfgVar}.liquidationThreshold, ${
        liqThreshold === KEEP_CURRENT ? `${beforeVar}.liquidationThreshold` : liqThreshold
      });`,
      `assertEq(${cfgVar}.liquidationBonus, ${
        liqBonus === KEEP_CURRENT ? `${beforeVar}.liquidationBonus` : `100_00 + ${liqBonus}`
      });`,
    ];
    if (cfg.isolated === ENGINE_FLAGS.KEEP_CURRENT)
      asserts.push(
        `assertEq(${market}.POOL.getIsEModeCategoryIsolated(${cfg.eModeCategory}), ${isolatedBeforeVar});`,
      );
    else
      asserts.push(
        `${
          cfg.isolated === ENGINE_FLAGS.ENABLED ? 'assertTrue' : 'assertFalse'
        }(${market}.POOL.getIsEModeCategoryIsolated(${cfg.eModeCategory}));`,
      );

    assertBlocks.push(asserts.join('\n'));
  });

  return [
    `function test_eModeUpdatesConfiguration() public {
      ${beforeBlocks.join('\n')}
      ${testExecuteProposal(market)}
      ${assertBlocks.join('\n\n')}
    }`,
  ];
}
