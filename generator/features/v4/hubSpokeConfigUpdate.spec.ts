import {expect, describe, it} from 'vitest';
import {generateFiles} from '../../generator';
import {FEATURE, MarketConfigs, Options} from '../../types';
import {hubSpokeConfigUpdate} from './hub/hubSpokeConfigUpdate';
import {V4HubSpokeConfigUpdate} from '../types';
import {keepCurrent, literal, enabled} from './sentinels';

const MOCK_V4_OPTIONS: Options = {
  markets: ['AaveV4Ethereum'],
  title: 'V4 hub spoke config update test',
  shortName: 'V4HubSpokeConfigUpdateTest',
  date: '20260521',
  author: 'test',
  discussion: 'test',
  snapshot: 'test',
};

const cfg: V4HubSpokeConfigUpdate[] = [
  {
    hubLib: 'AaveV4EthereumHubs.CORE_HUB',
    hub: 'AaveV4EthereumHubs.CORE_HUB',
    underlying: 'AaveV4EthereumAssets.WETH_UNDERLYING',
    spoke: 'AaveV4EthereumSpokes.MAIN_SPOKE',
    addCap: literal('1_000_000'),
    drawCap: literal('500_000'),
    riskPremiumThreshold: keepCurrent(),
    active: enabled(),
    halted: keepCurrent(),
  },
];

describe('feature: v4 hubSpokeConfigUpdate', () => {
  it('should return reasonable code', () => {
    const output = hubSpokeConfigUpdate.build({
      options: MOCK_V4_OPTIONS,
      market: 'AaveV4Ethereum',
      cfg,
      cache: {blockNumber: 42},
      configs: {},
    });
    expect(output).toMatchSnapshot();
  });

  it('should properly generate files', async () => {
    const marketConfigs: MarketConfigs = {
      ['AaveV4Ethereum']: {
        artifacts: [
          hubSpokeConfigUpdate.build({
            options: MOCK_V4_OPTIONS,
            market: 'AaveV4Ethereum',
            cfg,
            cache: {blockNumber: 42},
            configs: {[FEATURE.V4_HUB_SPOKE_CONFIG_UPDATE]: cfg},
          }),
        ],
        configs: {[FEATURE.V4_HUB_SPOKE_CONFIG_UPDATE]: cfg},
        cache: {blockNumber: 42},
      },
    };
    const files = await generateFiles(MOCK_V4_OPTIONS, marketConfigs);
    expect(files).toMatchSnapshot();
  });
});
