import {isWhitelabelMarket} from '../common';
import {MarketIdentifier} from '../types';

export function prefixWithPragma(code: string) {
  return (
    `// SPDX-License-Identifier: MIT
  pragma solidity ^0.8.0;\n\n` + code
  );
}

export function testExecuteProposal(market: MarketIdentifier) {
  if (!isWhitelabelMarket(market)) {
    return `GovV3Helpers.executePayload(vm,address(proposal));`;
  }
  return `executePayload(vm,address(proposal),${market}.POOL);`;
}
