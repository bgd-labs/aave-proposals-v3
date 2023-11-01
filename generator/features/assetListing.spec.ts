// sum.test.js
import {expect, describe, it} from 'vitest';
import {assetListing} from './assetListing';
import {MOCK_OPTIONS, assetListingConfig} from './mocks/configs';
import {generateFiles} from '../generator';
import {FEATURE, PoolConfigs} from '../types';

describe('feature: assetListing', () => {
  it('should return reasonable code', () => {
    const output = assetListing.build(MOCK_OPTIONS, 'AaveV3Ethereum', assetListingConfig);
    expect(output).toMatchSnapshot();
  });

  it('should properly generate files', async () => {
    const poolConfigs: PoolConfigs = {
      [MOCK_OPTIONS.pools[0]]: {
        pool: MOCK_OPTIONS.pools[0],
        features: [FEATURE.ASSET_LISTING],
        artifacts: [assetListing.build(MOCK_OPTIONS, 'AaveV3Ethereum', assetListingConfig)],
        configs: {[FEATURE.ASSET_LISTING]: assetListingConfig},
      },
    };
    const files = await generateFiles(MOCK_OPTIONS, poolConfigs);
    expect(files).toMatchSnapshot();
  });
});
