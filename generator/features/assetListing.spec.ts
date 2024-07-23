// sum.test.js
import {expect, describe, it} from 'vitest';
import {assetListing} from './assetListing';
import {MOCK_OPTIONS, assetListingConfig} from './mocks/configs';
import {generateFiles} from '../generator';
import {FEATURE, PoolConfigs} from '../types';

describe('feature: assetListing', () => {
  it('should return reasonable code', () => {
    const output = assetListing.build({
      options: MOCK_OPTIONS,
      pool: 'AaveV3Ethereum',
      cfg: assetListingConfig,
      cache: {blockNumber: 42},
    });
    expect(output).toMatchSnapshot();
  });

  it('should properly generate files', async () => {
    const poolConfigs: PoolConfigs = {
      [MOCK_OPTIONS.pools[0]]: {
        pool: MOCK_OPTIONS.pools[0],
        artifacts: [
          assetListing.build({
            options: MOCK_OPTIONS,
            pool: 'AaveV3Ethereum',
            cfg: assetListingConfig,
            cache: {blockNumber: 42},
          }),
        ],
        configs: {[FEATURE.ASSET_LISTING]: assetListingConfig},
        cache: {blockNumber: 42},
      },
    };
    const files = await generateFiles(MOCK_OPTIONS, poolConfigs);
    expect(files).toMatchSnapshot();
  });

  it('regression: isolation mode should be flase when ceiling is zero', async () => {
    const poolConfigs: PoolConfigs = {
      [MOCK_OPTIONS.pools[0]]: {
        pool: MOCK_OPTIONS.pools[0],
        artifacts: [
          assetListing.build({
            options: MOCK_OPTIONS,
            pool: 'AaveV3Ethereum',
            cfg: [{...assetListingConfig[0], debtCeiling: '0'}],
            cache: {blockNumber: 42},
          }),
        ],
        configs: {[FEATURE.ASSET_LISTING]: [{...assetListingConfig[0], debtCeiling: 0}]},
        cache: {blockNumber: 42},
      },
    };
    const files = await generateFiles(MOCK_OPTIONS, poolConfigs);
    expect(files).toMatchSnapshot();
  });
});
