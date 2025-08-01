import {isWhitelabelPool} from '../common';
import {PoolIdentifier} from '../types';

export function prefixWithPragma(code: string) {
  return (
    `// SPDX-License-Identifier: MIT
  pragma solidity ^0.8.0;\n\n` + code
  );
}

export function testExecuteProposal(pool: PoolIdentifier) {
  if (!isWhitelabelPool(pool)) {
    return `GovV3Helpers.executePayload(vm,address(proposal));`;
  }
  return `executePayload(vm,address(proposal),${pool}.POOL);`;
}
