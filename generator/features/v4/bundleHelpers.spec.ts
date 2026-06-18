import {expect, describe, it} from 'vitest';
import {mergeArtifact, finalizeV4Artifacts} from './bundleHelpers';
import {CodeArtifact, MarketConfig} from '../../types';

describe('mergeArtifact', () => {
  it('merges code, test and aip artifacts from a source into a target', () => {
    const target: CodeArtifact = {};
    mergeArtifact(target, {
      code: {
        constants: ['a'],
        fn: ['f1'],
        execute: ['e1'],
        v4Getters: {g: {returnType: 'X', entries: ['x0']}},
      },
      test: {fn: ['t1']},
      aip: {specification: ['s1']},
    });
    mergeArtifact(target, {
      code: {constants: ['b'], v4Getters: {g: {returnType: 'X', entries: ['x1']}}},
      aip: {specification: ['s2']},
    });

    expect(target.code!.constants).toEqual(['a', 'b']);
    expect(target.code!.fn).toEqual(['f1']);
    expect(target.code!.execute).toEqual(['e1']);
    expect(target.code!.v4Getters!.g.entries).toEqual(['x0', 'x1']);
    expect(target.test!.fn).toEqual(['t1']);
    expect(target.aip!.specification).toEqual(['s1', 's2']);
  });
});

describe('finalizeV4Artifacts', () => {
  it('combines entries for a shared getter, indexes them, and emits a single fn artifact', () => {
    const marketConfig: MarketConfig = {
      configs: {},
      artifacts: [
        {code: {v4Getters: {getList: {returnType: 'T', entries: ['items[__INDEX__] = a;']}}}},
        {code: {v4Getters: {getList: {returnType: 'T', entries: ['items[__INDEX__] = b;']}}}},
      ],
      cache: {blockNumber: 0},
    };
    finalizeV4Artifacts(marketConfig);
    expect(marketConfig.artifacts[0].code!.v4Getters).toBeUndefined();
    expect(marketConfig.artifacts[1].code!.v4Getters).toBeUndefined();
    const appended = marketConfig.artifacts[2];
    expect(appended.code!.fn).toHaveLength(1);
    const out = appended.code!.fn![0];
    expect(out).toContain('function getList() public pure override returns (T[] memory)');
    expect(out).toContain('new T[](2)');
    expect(out).toContain('items[0] = a;');
    expect(out).toContain('items[1] = b;');
  });

  it('is a no-op when no artifact has v4Getters', () => {
    const marketConfig: MarketConfig = {
      configs: {},
      artifacts: [{code: {fn: ['function f() {}']}}],
      cache: {blockNumber: 0},
    };
    finalizeV4Artifacts(marketConfig);
    expect(marketConfig.artifacts).toHaveLength(1);
  });
});
