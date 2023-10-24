import {generateContractName, generateFolderName} from '../common';
import {Options, PoolConfigs} from '../types';

export function generateAIP(options: Options, configs: PoolConfigs) {
  return `---
title: ${`"${options.title}"` || 'TODO'}
author: ${`"${options.author}"` || 'TODO'}
discussions: ${`"${options.discussion}"` || 'TODO'}
---

## Simple Summary

## Motivation

## Specification

${Object.keys(configs).map((pool) => {
  let template = `On ${pool} the following steps are performed:\n`;
  template += configs[pool].artifacts
    .filter((artifact) => artifact.aip)
    .map((artifact) => artifact.aip);
})}

## References

- Implementation: ${options.pools
    .map(
      (pool) =>
        `[${pool}](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/${generateFolderName(
          options
        )}/${generateContractName(options, pool)}.sol)`
    )
    .join(', ')}
- Tests: ${options.pools
    .map(
      (pool) =>
        `[${pool}](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/${generateFolderName(
          options
        )}/${generateContractName(options, pool)}.t.sol)`
    )
    .join(', ')}
- [Snapshot](${options.snapshot || 'TODO'})
- [Discussion](${options.discussion || 'TODO'})

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).\n`;
}
