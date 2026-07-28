import {expect, describe, it} from 'vitest';
import {
  percentToBps,
  decimalToWad,
  groupThousands,
  renderBpsSentinel,
  renderWadSentinel,
  renderWholeSentinel,
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
  it('converts decimals to scientific WAD literals', () => {
    expect(decimalToWad('1.0277')).toBe('1.0277e18');
    expect(decimalToWad('0.99')).toBe('0.99e18');
    expect(decimalToWad('1')).toBe('1e18');
  });

  it('trims trailing fractional zeros and renders zero as 0', () => {
    expect(decimalToWad('1.50')).toBe('1.5e18');
    expect(decimalToWad('0')).toBe('0');
  });
});

describe('groupThousands', () => {
  it('groups by three digits', () => {
    expect(groupThousands('10000000')).toBe('10_000_000');
    expect(groupThousands('0')).toBe('0');
  });

  it('re-groups already grouped values', () => {
    expect(groupThousands('1_000_000')).toBe('1_000_000');
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
    expect(renderWadSentinel(literal('1.0277'))).toBe('1.0277e18');
    expect(renderWadSentinel(keepCurrent())).toBe('EngineFlags.KEEP_CURRENT');
  });
});

describe('renderWholeSentinel', () => {
  it('groups literals and passes through keepCurrent', () => {
    expect(renderWholeSentinel(literal('10000000'))).toBe('10_000_000');
    expect(renderWholeSentinel(keepCurrent())).toBe('EngineFlags.KEEP_CURRENT');
  });
});
