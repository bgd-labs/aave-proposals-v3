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

  it('declares expected reserve config changes for new listings', () => {
    const output = assetListing.build({
      options: MOCK_OPTIONS,
      market: 'AaveV3Ethereum',
      cfg: assetListingConfig,
      cache: {blockNumber: 42},
      configs: {},
    });
    const test = output.test?.fn?.join('\n') ?? '';

    expect(test).toContain('function _expectedListings()');
    expect(test).toContain('ExpectedListing[] memory listings');
    expect(test).toContain('listing: IAaveV3ConfigEngine.Listing');
    expect(test).toContain('asset: 0xcAfE001067cDEF266AfB7Eb5A286dCFD277f3dE5');
    expect(test).toContain('assetSymbol: "PSP"');
    expect(test).toContain('decimals: 18');
    expect(test).toContain('supplyCap: 10_000');
    expect(test).toContain('borrowCap: 5_000');
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
