import {Hex} from 'viem';
import {CodeArtifact, MarketConfig, MarketIdentifier, V4GetterEntry} from '../../types';
import {newEntities} from './labelRegistry';
import {buildAddressConstant} from './constants';

/// Emits one named `address public constant` for every custom (non-address-book)
/// hub/spoke/asset/account labeled this session, so new entities are declared once
/// and referenced by name throughout the payload. Prepended so they lead the
/// contract body, ahead of per-listing constants (IR strategies, price feeds).
export function finalizeV4EntityConstants(
  marketConfig: MarketConfig,
  market: MarketIdentifier,
): void {
  const entities = newEntities(market as any);
  if (entities.length === 0) return;
  const constants = entities.map((e) => buildAddressConstant(market, e.label, e.address as Hex));
  marketConfig.artifacts.unshift({code: {constants}});
}

const resolveIndices = (blocks: string[]) =>
  blocks.map((block, ix) => block.replace(/__INDEX__/g, ix.toString()));

/// Fold array expressions into nested `arrayMerge` calls, as the helpers library
/// concatenates two arrays at a time.
const foldArrays = (parts: string[], arrayMerge: string) =>
  parts.reduce((acc, part) => `${arrayMerge}(${acc}, ${part})`);

/// Body of a merged getter: the entries it collected, then any library-built arrays
/// appended after them, so the entry indices the input assertions use hold.
function getterBody(value: V4GetterEntry): string {
  const arrays = value.arrayExprs ?? [];
  if (value.entries.length === 0) return `return ${foldArrays(arrays, value.arrayMerge!)};`;
  const items = `${value.returnType}[] memory items = new ${value.returnType}[](${value.entries.length});
        ${resolveIndices(value.entries).join('\n')}`;
  if (arrays.length === 0) return `${items}\n        return items;`;
  return `${items}\n        return ${foldArrays(['items', ...arrays], value.arrayMerge!)};`;
}

export function finalizeV4Artifacts(marketConfig: MarketConfig): void {
  const merged: Record<string, V4GetterEntry> = {};
  for (const artifact of marketConfig.artifacts) {
    const getters = artifact.code?.v4Getters;
    if (!getters) continue;
    for (const [name, value] of Object.entries(getters)) {
      if (!merged[name]) {
        merged[name] = {
          returnType: value.returnType,
          entries: [],
          inputAsserts: [],
          arrayExprs: [],
        };
      }
      merged[name].entries.push(...value.entries);
      merged[name].inputAsserts!.push(...(value.inputAsserts ?? []));
      merged[name].arrayExprs!.push(...(value.arrayExprs ?? []));
      merged[name].arrayMerge = merged[name].arrayMerge ?? value.arrayMerge;
    }
    delete artifact.code!.v4Getters;
  }
  const names = Object.keys(merged);
  if (names.length === 0) return;
  const fn = names.map(
    (
      name,
    ) => `function ${name}() public pure override returns (${merged[name].returnType}[] memory) {
        ${getterBody(merged[name])}
      }`,
  );
  const testFn = names
    .filter((name) => merged[name].inputAsserts!.length > 0)
    .map((name) => {
      const value = merged[name];
      // a library-built array appends an amount only the library knows, so the payload's
      // own entries are a lower bound rather than the full length
      const lengthAssert =
        value.arrayExprs!.length > 0
          ? `assertGe(items.length, ${value.entries.length}, 'length');`
          : `assertEq(items.length, ${value.entries.length}, 'length');`;
      return `function test_${name}Input() public view {
        ${value.returnType}[] memory items = proposal.${name}();
        ${lengthAssert}
        ${resolveIndices(value.inputAsserts!).join('\n        ')}
      }`;
    });
  marketConfig.artifacts.push({code: {fn}, test: {fn: testFn}});
}

export function mergeArtifact(target: CodeArtifact, source: CodeArtifact) {
  target.code = target.code ?? {};
  if (source.code?.constants) {
    target.code.constants = [...(target.code.constants ?? []), ...source.code.constants];
  }
  if (source.code?.fn) {
    target.code.fn = [...(target.code.fn ?? []), ...source.code.fn];
  }
  if (source.code?.execute) {
    target.code.execute = [...(target.code.execute ?? []), ...source.code.execute];
  }
  if (source.code?.v4Getters) {
    target.code.v4Getters = target.code.v4Getters ?? {};
    for (const [name, entry] of Object.entries(source.code.v4Getters)) {
      const existing = target.code.v4Getters[name];
      target.code.v4Getters[name] = {
        returnType: entry.returnType,
        entries: existing ? [...existing.entries, ...entry.entries] : [...entry.entries],
        inputAsserts: [...(existing?.inputAsserts ?? []), ...(entry.inputAsserts ?? [])],
        arrayExprs: [...(existing?.arrayExprs ?? []), ...(entry.arrayExprs ?? [])],
        arrayMerge: existing?.arrayMerge ?? entry.arrayMerge,
      };
    }
  }
  if (source.test?.fn) {
    target.test = target.test ?? {};
    target.test.fn = [...(target.test.fn ?? []), ...source.test.fn];
  }
  if (source.aip?.specification) {
    target.aip = target.aip ?? {specification: []};
    target.aip.specification = [...(target.aip.specification ?? []), ...source.aip.specification];
  }
}
