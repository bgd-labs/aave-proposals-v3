// sum.test.js
import {expect, describe, it} from 'vitest';
import {MOCK_OPTIONS, rateUpdateV2} from './mocks/configs';
import {generateFiles} from '../generator';
import {FEATURE, PoolConfigs} from '../types';
import {rateUpdatesV2} from './rateUpdates';

describe('feature: rateUpdatesV2', () => {
  it('should return reasonable code', () => {
    const output = rateUpdatesV2.build({
      options: MOCK_OPTIONS,
      pool: 'AaveV2EthereumAMM',
      cfg: rateUpdateV2,
      cache: {blockNumber: 42},
    });
    expect(output).toMatchSnapshot();
  });

  it('should properly generate files', async () => {
    const poolConfigs: PoolConfigs = {
      [MOCK_OPTIONS.pools[0]]: {
        pool: MOCK_OPTIONS.pools[0],
        artifacts: [
          rateUpdatesV2.build({
            options: MOCK_OPTIONS,
            pool: 'AaveV2EthereumAMM',
            cfg: rateUpdateV2,
            cache: {blockNumber: 42},
          }),
        ],
        configs: {[FEATURE.PRICE_FEEDS_UPDATE]: rateUpdateV2},
        cache: {blockNumber: 42},
      },
    };
    const files = await generateFiles(MOCK_OPTIONS, poolConfigs);
    expect(files).toMatchSnapshot();
  });
});
