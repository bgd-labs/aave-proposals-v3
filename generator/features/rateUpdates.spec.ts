// sum.test.js
import {expect, describe, it} from 'vitest';
import {MOCK_OPTIONS, rateUpdateV2} from './mocks/configs';
import {generateFiles} from '../generator';
import {FEATURE, MarketConfigs} from '../types';
import {rateUpdatesV2} from './rateUpdates';

describe('feature: rateUpdatesV2', () => {
  it('should return reasonable code', () => {
    const output = rateUpdatesV2.build({
      options: MOCK_OPTIONS,
      market: 'AaveV2EthereumAMM',
      cfg: rateUpdateV2,
      cache: {blockNumber: 42},
      configs: {},
    });
    expect(output).toMatchSnapshot();
  });

  it('should properly generate files', async () => {
    const marketConfigs: MarketConfigs = {
      ['AaveV2EthereumAMM']: {
        artifacts: [
          rateUpdatesV2.build({
            options: {...MOCK_OPTIONS, markets: ['AaveV2EthereumAMM']},
            market: 'AaveV2EthereumAMM',
            cfg: rateUpdateV2,
            cache: {blockNumber: 42},
            configs: {[FEATURE.RATE_UPDATE_V2]: rateUpdateV2},
          }),
        ],
        configs: {[FEATURE.RATE_UPDATE_V2]: rateUpdateV2},
        cache: {blockNumber: 42},
      },
    };
    const files = await generateFiles(
      {...MOCK_OPTIONS, markets: ['AaveV2EthereumAMM']},
      marketConfigs,
    );
    expect(files).toMatchSnapshot();
  });
});
