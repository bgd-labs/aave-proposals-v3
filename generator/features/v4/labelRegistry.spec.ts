import {expect, describe, it, beforeEach} from 'vitest';
import {
  registerEntity,
  lookupByAddress,
  newEntities,
  snapshot,
  hydrate,
  resetRegistry,
  toConstantName,
} from './labelRegistry';

const MARKET = 'AaveV4Ethereum';
const ADDR = '0x774b9655413c34809c1f1b16b654465A89EBE989';

describe('labelRegistry', () => {
  beforeEach(() => resetRegistry());

  it('sanitizes labels into constant names', () => {
    expect(toConstantName('Maple Spoke')).toBe('MAPLE_SPOKE');
    expect(toConstantName('waPaxosUSDG')).toBe('WAPAXOSUSDG');
    expect(toConstantName('3pool')).toBe('_3POOL');
  });

  it('registers and looks up entities case-insensitively', () => {
    const e = registerEntity(MARKET, ADDR, 'Maple Spoke', 'spoke');
    expect(e.label).toBe('MAPLE_SPOKE');
    expect(e.address).toBe('0x774b9655413c34809c1f1b16b654465A89EBE989');
    expect(lookupByAddress(MARKET, ADDR.toLowerCase())?.label).toBe('MAPLE_SPOKE');
  });

  it('lists new entities and round-trips through snapshot/hydrate', () => {
    registerEntity(MARKET, ADDR, 'Maple Spoke', 'spoke');
    const snap = snapshot(MARKET);
    resetRegistry();
    expect(newEntities(MARKET)).toEqual([]);
    hydrate(MARKET, snap);
    expect(newEntities(MARKET).map((e) => e.label)).toEqual(['MAPLE_SPOKE']);
  });
});
