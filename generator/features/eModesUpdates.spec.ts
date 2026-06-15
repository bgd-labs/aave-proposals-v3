import {expect, describe, it} from 'vitest';
import {eModeUpdates} from './eModesUpdates';
import {MOCK_OPTIONS, emodeUpdates} from './mocks/configs';

describe('feature: eModesUpdates', () => {
  const output = eModeUpdates.build({
    options: MOCK_OPTIONS,
    market: 'AaveV3Ethereum',
    cfg: emodeUpdates,
    cache: {blockNumber: 42},
    configs: {},
  });

  it('emits the v3.7 isolated flag on the update struct', () => {
    const fns = output.code?.fn?.join('\n') ?? '';
    expect(fns).toContain('isolated: EngineFlags.ENABLED');
    expect(fns).toContain('isolated: EngineFlags.KEEP_CURRENT');
  });

  it('asserts only the explicitly-set fields, skipping KEEP_CURRENT', () => {
    const test = output.test?.fn?.join('\n') ?? '';
    expect(test).toContain('function test_eModeUpdatesConfiguration()');
    // first category: all fields set + isolated enabled
    expect(test).toContain('assertEq(cfg_0.ltv, 20_00);');
    expect(test).toContain('assertEq(cfg_0.liquidationThreshold, 30_00);');
    expect(test).toContain('assertEq(cfg_0.liquidationBonus, 100_00 + 5_00);');
    expect(test).toContain('assertTrue(AaveV3Ethereum.POOL.getIsEModeCategoryIsolated(2));');
    // second category: ltv/liqBonus/isolated are KEEP_CURRENT -> not asserted
    expect(test).toContain('assertEq(cfg_1.liquidationThreshold, 50_00);');
    expect(test).not.toContain('cfg_1.ltv');
    expect(test).not.toContain('cfg_1.liquidationBonus');
    expect(test).not.toContain('getIsEModeCategoryIsolated(AaveV3EthereumEModes.ETH_CORRELATED)');
  });
});
