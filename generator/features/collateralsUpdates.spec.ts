import {expect, describe, it} from 'vitest';
import {collateralsUpdates} from './collateralsUpdates';
import {MOCK_OPTIONS, collateralUpdates as collateralUpdatesConfig} from './mocks/configs';

describe('feature: collateralsUpdates', () => {
  const output = collateralsUpdates.build({
    options: MOCK_OPTIONS,
    market: 'AaveV3Ethereum',
    cfg: collateralUpdatesConfig,
    cache: {blockNumber: 42},
    configs: {},
  });

  it('should return reasonable code', () => {
    expect(output).toMatchSnapshot();
  });

  it('encodes set fields as values and empty fields as KEEP_CURRENT on the payload struct', () => {
    const code = (output.code?.fn?.join('\n') ?? '').replace(/\s+/g, ' ');
    expect(code).toContain(
      'asset: AaveV3EthereumAssets.DAI_UNDERLYING, ltv: 0, liqThreshold: EngineFlags.KEEP_CURRENT, liqBonus: EngineFlags.KEEP_CURRENT, liqProtocolFee: EngineFlags.KEEP_CURRENT',
    );
    expect(code).toContain(
      'asset: AaveV3EthereumAssets.USDC_UNDERLYING, ltv: 77_00, liqThreshold: 80_00, liqBonus: 5_00, liqProtocolFee: 10_00',
    );
  });

  it('asserts changed collateral fields and preserves other reserve config values', () => {
    const test = output.test?.fn?.join('\n') ?? '';

    expect(test).toContain('function _expectedCollateralChanges()');
    expect(test).toContain('internal pure override');
    expect(test).toContain(
      'asset: AaveV3EthereumAssets.DAI_UNDERLYING,\n               ltv: 0,\n               liqThreshold: EngineFlags.KEEP_CURRENT,\n               liqBonus: EngineFlags.KEEP_CURRENT,\n               liqProtocolFee: EngineFlags.KEEP_CURRENT',
    );
    expect(test).toContain(
      'asset: AaveV3EthereumAssets.USDC_UNDERLYING,\n               ltv: 77_00,\n               liqThreshold: 80_00,\n               liqBonus: 5_00,\n               liqProtocolFee: 10_00',
    );
  });

  // The v3 CollateralEngine skips the ltv/lt/lb update entirely when liqThreshold == 0,
  // so a payload configured this way leaves the collateral params untouched on-chain.
  // The generated test must still encode the configured intent (lt = 0, collateral
  // disabled) so it fails against such a payload instead of green-lighting a no-op.
  it('encodes configured intent for liqThreshold 0 even though the engine ignores it', () => {
    const ltZeroOutput = collateralsUpdates.build({
      options: MOCK_OPTIONS,
      market: 'AaveV3Ethereum',
      cfg: [{asset: 'WETH', ltv: '0', liqThreshold: '0', liqBonus: '', liqProtocolFee: ''}],
      cache: {blockNumber: 42},
      configs: {},
    });
    const test = ltZeroOutput.test?.fn?.join('\n') ?? '';

    expect(test).toContain('ltv: 0');
    expect(test).toContain('liqThreshold: 0');
    expect(test).toContain('liqBonus: EngineFlags.KEEP_CURRENT');
    expect(test).toContain('liqProtocolFee: EngineFlags.KEEP_CURRENT');
  });
});
