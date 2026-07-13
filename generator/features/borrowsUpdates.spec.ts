import {expect, describe, it} from 'vitest';
import {borrowsUpdates} from './borrowsUpdates';
import {MOCK_OPTIONS} from './mocks/configs';

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
});
