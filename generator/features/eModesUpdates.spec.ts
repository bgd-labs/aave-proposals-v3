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

  it('asserts set fields to their value and KEEP_CURRENT fields to the pre-payload value', () => {
    const test = output.test?.fn?.join('\n') ?? '';
    expect(test).toContain('function test_eModeUpdatesConfiguration()');
    // first category: all fields set + isolated enabled, no before snapshot needed
    expect(test).toContain('assertEq(cfg_0.ltv, 20_00);');
    expect(test).toContain('assertEq(cfg_0.liquidationThreshold, 30_00);');
    expect(test).toContain('assertEq(cfg_0.liquidationBonus, 100_00 + 5_00);');
    expect(test).toContain('assertTrue(AaveV3Ethereum.POOL.getIsEModeCategoryIsolated(2));');
    expect(test).not.toContain('before_0');
    // second category: ltv/liqBonus/isolated are KEEP_CURRENT -> asserted equal to the before snapshot
    expect(test).toContain(
      'DataTypes.CollateralConfig memory before_1 = AaveV3Ethereum.POOL.getEModeCategoryCollateralConfig(AaveV3EthereumEModes.ETH_CORRELATED);',
    );
    expect(test).toContain(
      'bool beforeIsolated_1 = AaveV3Ethereum.POOL.getIsEModeCategoryIsolated(AaveV3EthereumEModes.ETH_CORRELATED);',
    );
    expect(test).toContain('assertEq(cfg_1.ltv, before_1.ltv);');
    expect(test).toContain('assertEq(cfg_1.liquidationThreshold, 50_00);');
    expect(test).toContain('assertEq(cfg_1.liquidationBonus, before_1.liquidationBonus);');
    expect(test).toContain(
      'assertEq(AaveV3Ethereum.POOL.getIsEModeCategoryIsolated(AaveV3EthereumEModes.ETH_CORRELATED), beforeIsolated_1);',
    );
  });
});
