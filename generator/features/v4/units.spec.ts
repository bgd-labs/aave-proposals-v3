import {expect, describe, it} from 'vitest';
import {
  percentToBps,
  decimalToWad,
  groupThousands,
  renderBpsSentinel,
  renderWadSentinel,
} from './units';
import {literal, keepCurrent} from './sentinels';

describe('percentToBps', () => {
  it('converts whole percentages to grouped bps', () => {
    expect(percentToBps('90')).toBe('90_00');
    expect(percentToBps('92')).toBe('92_00');
    expect(percentToBps('104')).toBe('104_00');
    expect(percentToBps('20')).toBe('20_00');
  });

  it('converts fractional percentages', () => {
    expect(percentToBps('7.5')).toBe('7_50');
    expect(percentToBps('0.5')).toBe('50');
  });

  it('renders zero and empty as 0', () => {
    expect(percentToBps('0')).toBe('0');
    expect(percentToBps('')).toBe('0');
  });
});

describe('decimalToWad', () => {
  it('converts decimals to WAD literals', () => {
    expect(decimalToWad('1.0277')).toBe('1_027_700_000_000_000_000');
    expect(decimalToWad('0.99')).toBe('990_000_000_000_000_000');
    expect(decimalToWad('1')).toBe('1_000_000_000_000_000_000');
  });
});

describe('groupThousands', () => {
  it('groups by three digits', () => {
    expect(groupThousands('10000000')).toBe('10_000_000');
    expect(groupThousands('0')).toBe('0');
  });
});

describe('renderBpsSentinel', () => {
  it('converts literals to bps and passes through keepCurrent', () => {
    expect(renderBpsSentinel(literal('90'))).toBe('90_00');
    expect(renderBpsSentinel(keepCurrent())).toBe('EngineFlags.KEEP_CURRENT');
  });
});

describe('renderWadSentinel', () => {
  it('converts literals to WAD and passes through keepCurrent', () => {
    expect(renderWadSentinel(literal('1.0277'))).toBe('1_027_700_000_000_000_000');
    expect(renderWadSentinel(keepCurrent())).toBe('EngineFlags.KEEP_CURRENT');
  });
});
