import {expect, describe, it} from 'vitest';
import {capsUpdates} from './capsUpdates';
import {MOCK_OPTIONS, capsUpdates as capsUpdatesConfig} from './mocks/configs';
import {generateFiles} from '../generator';
import {FEATURE, MarketConfigs} from '../types';

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

  it('generates reserve config change tests on zksync', () => {
    const zksyncOutput = capsUpdates.build({
      options: MOCK_OPTIONS,
      market: 'AaveV3ZkSync',
      cfg: [{asset: 'ZK', supplyCap: '1000', borrowCap: '500'}],
      cache: {blockNumber: 42},
      configs: {},
    });
    const code = zksyncOutput.code?.fn?.join('\n') ?? '';
    const test = zksyncOutput.test?.fn?.join('\n') ?? '';

    expect(code).toContain('function capsUpdates()');
    expect(test).toContain('function _expectedCapsChanges()');
    expect(test).toContain('asset: AaveV3ZkSyncAssets.ZK_UNDERLYING');
  });

  it('generates zksync payload files with reserve config validation', async () => {
    const zksyncConfig = [{asset: 'ZK', supplyCap: '1000', borrowCap: '500'}];
    const options = {...MOCK_OPTIONS, markets: ['AaveV3ZkSync' as const]};
    const marketConfigs: MarketConfigs = {
      AaveV3ZkSync: {
        market: 'AaveV3ZkSync',
        artifacts: [
          capsUpdates.build({
            options,
            market: 'AaveV3ZkSync',
            cfg: zksyncConfig,
            cache: {blockNumber: 42},
            configs: {[FEATURE.CAPS_UPDATE]: zksyncConfig},
          }),
        ],
        configs: {[FEATURE.CAPS_UPDATE]: zksyncConfig},
        cache: {blockNumber: 42},
      },
    };
    const files = await generateFiles(options, marketConfigs);
    const payload = files.payloads[0];

    expect(payload.payload).toContain('function capsUpdates()');
    expect(payload.test).toContain('ProtocolV3ProposalTestBase');
    expect(payload.test).toContain('function _expectedCapsChanges()');
    expect(payload.test).toContain('function test_reserveConfigChanges()');
    expect(payload.test).toContain(
      'reserveConfigChangesTest(AaveV3ZkSync.POOL, address(proposal));',
    );
    expect(payload.test).toContain(
      'checks whether reserve configurations changed or stayed unchanged as expected',
    );
    expect(payload.test).not.toContain(
      '_validateReserveConfigChanges(allConfigsBefore, allConfigsAfter);',
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
