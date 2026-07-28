import {expect, describe, it} from 'vitest';
import {testTemplate} from './test.template';
import {MarketConfig, Options} from '../types';

const OPTS: Options = {
  markets: ['AaveV4Ethereum'],
  title: 'test',
  shortName: 'Test',
  date: '20260521',
  author: 'test',
  discussion: 'test',
  snapshot: 'test',
};

const withTestFns = (fns: string[][]): MarketConfig => ({
  configs: {},
  artifacts: fns.map((fn) => ({test: {fn}})),
  cache: {blockNumber: 0},
});

describe('testTemplate', () => {
  it('emits a test requested by two features once', () => {
    const fn = "function test_a() public {\n  assertEq(1, 1, 'x');\n}";
    const out = testTemplate(OPTS, withTestFns([[fn], [fn]]), 'AaveV4Ethereum');
    expect(out.match(/function test_a\(\)/g)).toHaveLength(1);
  });

  it('rejects two features defining the same test differently', () => {
    expect(() =>
      testTemplate(
        OPTS,
        withTestFns([
          ['function test_a() public {\n  assertEq(1, 1);\n}'],
          ['function test_a() public {\n  assertEq(1, 2);\n}'],
        ]),
        'AaveV4Ethereum',
      ),
    ).toThrow('conflicting definitions of test_a');
  });
});
