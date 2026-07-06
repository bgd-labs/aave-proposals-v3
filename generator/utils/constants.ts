import {getMarketChain, isWhitelabelMarket} from '../common';
import {CodeArtifact, MarketIdentifier} from '../types';

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

const zksyncReserveConfigChangesWarning = `/**
   * @dev WARNING: generated reserve-config change assertions are skipped on ZkSync.
   * The pinned aave-helpers/zksync path currently references ReserveConfig fields
   * that are not available in the pinned aave-v3-origin-tests dependency, so
   * test_defaultProposalExecution() is the supported generated coverage for now.
   */`;

export function reserveConfigChangeTest(
  market: MarketIdentifier,
  reserveConfigFns: string[],
  existingFns: string[] = [],
): NonNullable<CodeArtifact['test']> {
  if (getMarketChain(market) === 'ZkSync') {
    return {
      fn: [...existingFns, zksyncReserveConfigChangesWarning],
    };
  }
  return {
    fn: [...existingFns, ...reserveConfigFns],
    reserveConfigChanges: true,
  };
}
