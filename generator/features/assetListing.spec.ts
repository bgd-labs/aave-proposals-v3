// sum.test.js
import {expect, describe, it} from 'vitest';
import {assetListing} from './assetListing';
import {MOCK_OPTIONS, assetListingConfig} from './mocks/configs';
import {generateFiles} from '../generator';
import {FEATURE, MarketConfigs} from '../types';

describe('feature: assetListing', () => {
  it('should return reasonable code', () => {
    const output = assetListing.build({
      options: MOCK_OPTIONS,
      market: 'AaveV3Ethereum',
      cfg: assetListingConfig,
      cache: {blockNumber: 42},
      configs: {},
    });
    expect(output).toMatchSnapshot();
  });

  it('should properly generate files', async () => {
    const marketConfigs: MarketConfigs = {
      [MOCK_OPTIONS.markets[0]]: {
        market: MOCK_OPTIONS.markets[0],
        artifacts: [
          assetListing.build({
            options: MOCK_OPTIONS,
            market: 'AaveV3Ethereum',
            cfg: assetListingConfig,
            cache: {blockNumber: 42},
            configs: {[FEATURE.ASSET_LISTING]: assetListingConfig},
          }),
        ],
        configs: {[FEATURE.ASSET_LISTING]: assetListingConfig},
        cache: {blockNumber: 42},
      },
    };
    const files = await generateFiles(MOCK_OPTIONS, marketConfigs);
    expect(files).toMatchSnapshot();
  });
});
