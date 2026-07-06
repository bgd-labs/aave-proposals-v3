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

    expect(test).toContain(
      'ReserveConfig memory expected_DAI = _findReserveConfig(allConfigsBefore, AaveV3EthereumAssets.DAI_UNDERLYING);',
    );
    expect(test).toContain('expected_DAI.ltv = 0;');
    expect(test).toContain(
      'expected_DAI.usageAsCollateralEnabled = expected_DAI.liquidationThreshold != 0;',
    );
    expect(test).toContain('_validateReserveConfig(expected_DAI, allConfigsAfter);');
    expect(test).not.toContain('expected_DAI.liquidationThreshold =');
    expect(test).not.toContain('expected_DAI.liquidationBonus =');
    expect(test).not.toContain('expected_DAI.liquidationProtocolFee =');

    expect(test).toContain(
      'ReserveConfig memory expected_USDC = _findReserveConfig(allConfigsBefore, AaveV3EthereumAssets.USDC_UNDERLYING);',
    );
    expect(test).toContain('expected_USDC.ltv = 77_00;');
    expect(test).toContain('expected_USDC.liquidationThreshold = 80_00;');
    expect(test).toContain('expected_USDC.liquidationBonus = 100_00 + 5_00;');
    expect(test).toContain('expected_USDC.liquidationProtocolFee = 10_00;');
    expect(test).toContain('_validateReserveConfig(expected_USDC, allConfigsAfter);');
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

    expect(test).toContain('expected_WETH.ltv = 0;');
    expect(test).toContain('expected_WETH.liquidationThreshold = 0;');
    expect(test).toContain(
      'expected_WETH.usageAsCollateralEnabled = expected_WETH.liquidationThreshold != 0;',
    );
    expect(test).not.toContain('expected_WETH.liquidationBonus =');
    expect(test).not.toContain('expected_WETH.liquidationProtocolFee =');
  });
});
