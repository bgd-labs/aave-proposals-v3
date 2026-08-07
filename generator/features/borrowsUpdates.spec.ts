import {expect, describe, it} from 'vitest';
import {borrowsUpdates} from './borrowsUpdates';
import {MOCK_OPTIONS} from './mocks/configs';
import {BorrowUpdate} from './types';
import {generateFiles} from '../generator';
import {FEATURE, MarketConfigs} from '../types';
import {compileGeneratedFiles} from '../utils/compileGeneratedFiles';

describe('feature: borrowsUpdates', () => {
  it('declares expected reserve config changes', () => {
    const output = borrowsUpdates.build({
      options: MOCK_OPTIONS,
      market: 'AaveV3Ethereum',
      cfg: [
        {
          asset: 'DAI',
          enabledToBorrow: 'DISABLED',
          flashloanable: 'KEEP_CURRENT',
          reserveFactor: '25',
        },
      ],
      cache: {blockNumber: 42},
      configs: {},
    });
    const test = output.test?.fn?.join('\n') ?? '';

    expect(test).toContain('function _expectedBorrowChanges()');
    expect(test).toContain('asset: AaveV3EthereumAssets.DAI_UNDERLYING');
    expect(test).toContain('enabledToBorrow: EngineFlags.DISABLED');
    expect(test).toContain('flashloanable: EngineFlags.KEEP_CURRENT');
    expect(test).toContain('reserveFactor: 25_00');
  });

  it('generates compilable Solidity', async () => {
    const cfg: BorrowUpdate[] = [
      {
        asset: 'DAI',
        enabledToBorrow: 'DISABLED',
        flashloanable: 'KEEP_CURRENT',
        reserveFactor: '25',
      },
    ];
    const configs = {[FEATURE.BORROWS_UPDATE]: cfg};
    const marketConfigs: MarketConfigs = {
      AaveV3Ethereum: {
        market: 'AaveV3Ethereum',
        artifacts: [
          borrowsUpdates.build({
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
