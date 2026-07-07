import {expect, describe, it} from 'vitest';
import {capsUpdates} from './capsUpdates';
import {MOCK_OPTIONS, capsUpdates as capsUpdatesConfig} from './mocks/configs';

describe('feature: capsUpdates', () => {
  const output = capsUpdates.build({
    options: MOCK_OPTIONS,
    market: 'AaveV3Ethereum',
    cfg: capsUpdatesConfig,
    cache: {blockNumber: 42},
    configs: {},
  });

  it('should return reasonable code', () => {
    expect(output).toMatchSnapshot();
  });

  it('declares updated assets for reserve config validation', () => {
    expect(output.test?.updatedAssets).toEqual([
      'AaveV3EthereumAssets.DAI_UNDERLYING',
      'AaveV3EthereumAssets.USDC_UNDERLYING',
    ]);
  });

  it('encodes set fields as values and empty fields as KEEP_CURRENT on the payload struct', () => {
    const code = (output.code?.fn?.join('\n') ?? '').replace(/\s+/g, ' ');
    expect(code).toContain(
      'asset: AaveV3EthereumAssets.DAI_UNDERLYING, supplyCap: 1_000_000, borrowCap: EngineFlags.KEEP_CURRENT',
    );
    expect(code).toContain(
      'asset: AaveV3EthereumAssets.USDC_UNDERLYING, supplyCap: 2_000_000, borrowCap: 900_000',
    );
  });

  it('asserts changed cap fields and preserves other reserve config values', () => {
    const test = output.test?.fn?.join('\n') ?? '';

    expect(test).toContain('function _expectedCapsChanges()');
    expect(test).toContain('internal pure override');
    expect(test).toContain(
      'asset: AaveV3EthereumAssets.DAI_UNDERLYING,\n               supplyCap: 1_000_000,\n               borrowCap: EngineFlags.KEEP_CURRENT',
    );
    expect(test).toContain(
      'asset: AaveV3EthereumAssets.USDC_UNDERLYING,\n               supplyCap: 2_000_000,\n               borrowCap: 900_000',
    );
  });

  it('emits zero cap assignments instead of treating them as KEEP_CURRENT', () => {
    const zeroOutput = capsUpdates.build({
      options: MOCK_OPTIONS,
      market: 'AaveV3Ethereum',
      cfg: [{asset: 'WETH', supplyCap: '0', borrowCap: '0'}],
      cache: {blockNumber: 42},
      configs: {},
    });
    const test = zeroOutput.test?.fn?.join('\n') ?? '';

    expect(test).toContain('supplyCap: 0');
    expect(test).toContain('borrowCap: 0');
  });
});
