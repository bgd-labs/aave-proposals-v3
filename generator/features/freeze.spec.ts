import {expect, describe, it} from 'vitest';
import {freezeUpdates} from './freeze';
import {MOCK_OPTIONS} from './mocks/configs';

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
});
