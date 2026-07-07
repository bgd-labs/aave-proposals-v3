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
    expect(test).toContain('asset: AaveV3EthereumAssets.DAI_UNDERLYING');
    expect(test).toContain('frozen: true');
  });

  it('warns instead of generating reserve config change tests on zksync', () => {
    const zksyncOutput = freezeUpdates.build({
      options: MOCK_OPTIONS,
      market: 'AaveV3ZkSync',
      cfg: [{asset: 'ZK', shouldBeFrozen: true}],
      cache: {blockNumber: 42},
      configs: {},
    });
    const code = zksyncOutput.code?.execute?.join('\n') ?? '';
    const test = zksyncOutput.test?.fn?.join('\n') ?? '';

    expect(code).toContain('setReserveFreeze');
    expect(test).toContain('function _expectedFreezeChanges()');
    expect(test).toContain('asset: AaveV3ZkSyncAssets.ZK_UNDERLYING');
  });
});
