import {generateContractName, generateFolderName} from '../common';
import {Options, PoolConfigs, PoolIdentifier} from '../types';

export function generateAIP(options: Options, configs: PoolConfigs) {
  return `---
title: ${`"${options.title}"` || 'TODO'}
author: ${`"${options.author}"` || 'TODO'}
discussions: ${`"${options.discussion}"` || 'TODO'}${
    options.snapshot ? `\nsnapshot: "${options.snapshot}"\n` : ''
  }
---

## Simple Summary

## Motivation

## Specification

${Object.keys(configs)
  .map((pool) => {
    return configs[pool as keyof typeof configs]!.artifacts.filter(
      (artifact) => artifact.aip?.specification,
    ).map((artifact) => artifact.aip?.specification);
  })
  .filter((a) => a)
  .join('\n\n')}

## References

- Implementation: ${options.pools
    .map(
      (pool) =>
        `[${pool}](https://github.com/bgd-labs/aave-proposals-v3/blob/main/${pool === 'AaveV3ZkSync' ? 'zksync/src' : 'src'}/${generateFolderName(
          options,
        )}/${generateContractName(options, pool)}.sol)`,
    )
    .join(', ')}
- Tests: ${options.pools
    .map(
      (pool) =>
        `[${pool}](https://github.com/bgd-labs/aave-proposals-v3/blob/main/${pool === 'AaveV3ZkSync' ? 'zksync/src' : 'src'}/${generateFolderName(
          options,
        )}/${generateContractName(options, pool)}.t.sol)`,
    )
    .join(', ')}
- [Snapshot](${options.snapshot || 'TODO'})
- [Discussion](${options.discussion || 'TODO'})

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).\n`;
}
