import {expect, describe, it} from 'vitest';
import {mergeArtifact, mergeV4Getters} from './bundleHelpers';
import {CodeArtifact} from '../../types';

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

describe('mergeV4Getters', () => {
  it('combines entries for a shared getter and indexes them', () => {
    const out = mergeV4Getters([
      {code: {v4Getters: {getList: {returnType: 'T', entries: ['items[__INDEX__] = a;']}}}},
      {code: {v4Getters: {getList: {returnType: 'T', entries: ['items[__INDEX__] = b;']}}}},
    ]);
    expect(out).toContain('function getList() public pure override returns (T[] memory)');
    expect(out).toContain('new T[](2)');
    expect(out).toContain('items[0] = a;');
    expect(out).toContain('items[1] = b;');
  });
});
