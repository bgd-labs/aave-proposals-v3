import {CodeArtifact} from '../../types';

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
}
