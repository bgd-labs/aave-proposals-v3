import {expect, describe, it} from 'vitest';
import {freezeUpdates} from './freeze';
import {MOCK_OPTIONS} from './mocks/configs';
import {FreezeUpdate} from './types';
import {generateFiles} from '../generator';
import {FEATURE, MarketConfigs} from '../types';
import {compileGeneratedFiles} from '../utils/compileGeneratedFiles';

describe('feature: freezeUpdates', () => {
  it('declares expected reserve config changes', () => {
    const output = freezeUpdates.build({
      options: MOCK_OPTIONS,
      market: 'AaveV3Ethereum',
      cfg: [{asset: 'DAI', shouldBeFrozen: true}],
      cache: {blockNumber: 42},
      configs: {},
    });
    const test = output.test?.fn?.join('\n') ?? '';

    expect(test).toContain('function _expectedFreezeChanges()');
    expect(test).toContain('assets[0] = AaveV3EthereumAssets.DAI_UNDERLYING');
    expect(test).toContain('frozen[0] = true');
  });

  it('generates compilable Solidity', async () => {
    const cfg: FreezeUpdate[] = [{asset: 'DAI', shouldBeFrozen: true}];
    const configs = {[FEATURE.FREEZE]: cfg};
    const marketConfigs: MarketConfigs = {
      AaveV3Ethereum: {
        market: 'AaveV3Ethereum',
        artifacts: [
          freezeUpdates.build({
            options: MOCK_OPTIONS,
            market: 'AaveV3Ethereum',
            cfg,
            cache: {blockNumber: 42},
            configs,
          }),
        ],
        configs,
        cache: {blockNumber: 42},
      },
    };

    compileGeneratedFiles(await generateFiles(MOCK_OPTIONS, marketConfigs));
  }, 60_000);
});
