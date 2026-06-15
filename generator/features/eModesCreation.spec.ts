import {expect, describe, it} from 'vitest';
import {assetListing} from './assetListing';
import {eModeCreations} from './eModesCreation';
import {MOCK_OPTIONS, emodeCreations, ptListingConfig} from './mocks/configs';
import {toSolidityIdentifier} from '../common';
import {generateFiles} from '../generator';
import {FEATURE, MarketConfigs} from '../types';

const configs = {
  [FEATURE.ASSET_LISTING]: ptListingConfig,
  [FEATURE.EMODES_CREATION]: emodeCreations,
};

function buildMarketConfigs(): MarketConfigs {
  return {
    [MOCK_OPTIONS.markets[0]]: {
      market: MOCK_OPTIONS.markets[0],
      artifacts: [
        assetListing.build({
          options: MOCK_OPTIONS,
          market: 'AaveV3Ethereum',
          cfg: ptListingConfig,
          cache: {blockNumber: 42},
          configs,
        }),
        eModeCreations.build({
          options: MOCK_OPTIONS,
          market: 'AaveV3Ethereum',
          cfg: emodeCreations,
          cache: {blockNumber: 42},
          configs,
        }),
      ],
      configs,
      cache: {blockNumber: 42},
    },
  };
}

describe('feature: eModesCreation', () => {
  it('toSolidityIdentifier replaces dashes (and other invalid chars) with underscores', () => {
    expect(toSolidityIdentifier('PT-sUSDe-22OCT2026')).toBe('PT_sUSDe_22OCT2026');
    expect(toSolidityIdentifier('cbETH')).toBe('cbETH');
  });

  it('emits the v3.7 isolated flag on the creation struct', () => {
    const output = eModeCreations.build({
      options: MOCK_OPTIONS,
      market: 'AaveV3Ethereum',
      cfg: emodeCreations,
      cache: {blockNumber: 42},
      configs,
    });
    expect(output.code?.fn?.join('\n')).toContain('isolated: true');
  });

  it('should properly generate files', async () => {
    const files = await generateFiles(MOCK_OPTIONS, buildMarketConfigs());
    expect(files).toMatchSnapshot();
  });

  it('generates the expected e-mode test coverage', async () => {
    const files = await generateFiles(MOCK_OPTIONS, buildMarketConfigs());
    const test = files.payloads[0].test;

    // config-assertion test
    expect(test).toContain('function test_eModeConfiguration()');
    expect(test).toContain('getIsEModeCategoryIsolated');
    expect(test).toContain('getEModeCategoryCollateralBitmap');
    expect(test).toContain('getEModeCategoryBorrowableBitmap');
    // e2e supply/borrow + revert (base LTV is 0)
    expect(test).toContain('_supplyAndBorrowInEMode');
    expect(test).toContain('function test_PT_sUSDe_TESTBorrowWithoutEModeReverts()');
    // new listing referenced through the proposal getter, existing assets through the lib
    expect(test).toContain('proposal.PT_sUSDe_TEST()');
    expect(test).toContain('AaveV3EthereumAssets.sUSDe_UNDERLYING');

    // shared helpers must appear exactly once
    expect(test.match(/function _findEModeCategoryId/g)?.length).toBe(1);
    expect(test.match(/function _toBitmap/g)?.length).toBe(1);

    // imports auto-resolved
    expect(test).toContain("import {DataTypes} from 'aave-v3-origin");
    expect(test).toContain("import {Errors} from 'aave-v3-origin");
    expect(test).toContain('IERC20Metadata');
  });
});
