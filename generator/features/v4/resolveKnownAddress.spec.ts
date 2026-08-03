import {expect, describe, it} from 'vitest';
import {resolveKnownAddress} from './resolveKnownAddress';

const MARKET = 'AaveV4Ethereum';

describe('resolveKnownAddress', () => {
  it('resolves the top-level TreasurySpoke scalar', () => {
    expect(resolveKnownAddress(MARKET, '0xB9B0b8616f6Bf6841972a52058132BE08d723155')).toEqual({
      expr: 'AaveV4Ethereum.TREASURY_SPOKE',
      label: 'TREASURY_SPOKE',
    });
  });

  it('resolves an asset underlying (case-insensitive)', () => {
    expect(resolveKnownAddress(MARKET, '0xe343167631d89b6ffc58b88d6b7fb0228795491d')).toEqual({
      expr: 'AaveV4EthereumAssets.USDG_UNDERLYING',
      label: 'USDG',
    });
  });

  it('resolves a position manager', () => {
    expect(resolveKnownAddress(MARKET, '0x17A54b8d6D9C68e7fa1C7112AC998EA1BA51d11e')).toEqual({
      expr: 'AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER',
      label: 'GIVER_POSITION_MANAGER',
    });
  });

  it('resolves a governance address', () => {
    expect(resolveKnownAddress(MARKET, '0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A')).toEqual({
      expr: 'GovernanceV3Ethereum.EXECUTOR_LVL_1',
      label: 'EXECUTOR_LVL_1',
    });
  });

  it('returns undefined for an unknown address', () => {
    expect(
      resolveKnownAddress(MARKET, '0x000000000000000000000000000000000000dEaD'),
    ).toBeUndefined();
  });
});
