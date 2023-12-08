// sum.test.js
import {expect, describe, it} from 'vitest';
import {MOCK_OPTIONS, priceFeedsUpdateConfig} from './mocks/configs';
import {generateFiles} from '../generator';
import {FEATURE, PoolConfigs} from '../types';
import {priceFeedsUpdates} from './priceFeedsUpdates';

describe('feature: priceFeedsUpdates', () => {
  it('should return reasonable code', () => {
    const output = priceFeedsUpdates.build({
      options: MOCK_OPTIONS,
      pool: 'AaveV3Ethereum',
      cfg: priceFeedsUpdateConfig,
      cache: {blockNumber: 42},
    });
    expect(output).toMatchSnapshot();
  });

  it('should properly generate files', async () => {
    const poolConfigs: PoolConfigs = {
      [MOCK_OPTIONS.pools[0]]: {
        pool: MOCK_OPTIONS.pools[0],
        artifacts: [
          priceFeedsUpdates.build({
            options: MOCK_OPTIONS,
            pool: 'AaveV3Ethereum',
            cfg: priceFeedsUpdateConfig,
            cache: {blockNumber: 42},
          }),
        ],
        configs: {[FEATURE.PRICE_FEEDS_UPDATE]: priceFeedsUpdateConfig},
        cache: {blockNumber: 42},
      },
    };
    const files = await generateFiles(MOCK_OPTIONS, poolConfigs);
    expect(files).toMatchSnapshot();
  });
});
