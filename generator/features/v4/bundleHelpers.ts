import {CodeArtifact, MarketConfig, V4GetterEntry} from '../../types';

export function finalizeV4Artifacts(marketConfig: MarketConfig): void {
  const merged: Record<string, V4GetterEntry> = {};
  for (const artifact of marketConfig.artifacts) {
    const getters = artifact.code?.v4Getters;
    if (!getters) continue;
    for (const [name, value] of Object.entries(getters)) {
      if (!merged[name]) {
        merged[name] = {returnType: value.returnType, entries: []};
      }
      merged[name].entries.push(...value.entries);
    }
    delete artifact.code!.v4Getters;
  }
  const names = Object.keys(merged);
  if (names.length === 0) return;
  const fn = names.map((name) => {
    const value = merged[name];
    const lines = value.entries
      .map((entry, ix) => entry.replace(/__INDEX__/g, ix.toString()))
      .join('\n');
    return `function ${name}() public pure override returns (${value.returnType}[] memory) {
        ${value.returnType}[] memory items = new ${value.returnType}[](${value.entries.length});
        ${lines}
        return items;
      }`;
  });
  marketConfig.artifacts.push({code: {fn}});
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
