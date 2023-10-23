export function prefixWithPragma(code: string) {
  return (
    `// SPDX-License-Identifier: MIT
  pragma solidity ^0.8.0;\n\n` + code
  );
}

export const TEST_EXECUTE_PROPOSAL = `GovV3Helpers.executePayload(vm,address(proposal));`;
