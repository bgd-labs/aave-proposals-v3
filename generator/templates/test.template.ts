import {createPublicClient, http} from 'viem';
import {
  CHAIN_TO_CHAIN_OBJECT,
  generateContractName,
  getChainAlias,
  getPoolChain,
  isV2Pool,
} from '../common';
import {CodeArtifact, Options, PoolIdentifier} from '../types';

export const getBlock = async (chain) => {
  return await createPublicClient({
    chain: CHAIN_TO_CHAIN_OBJECT[chain],
    transport: http(),
  }).getBlockNumber();
};

export const testTemplate = async (
  options: Options,
  pool: PoolIdentifier,
  artifacts: CodeArtifact[] = []
) => {
  const chain = getPoolChain(pool);
  const contractName = generateContractName(options, pool);

  const testBase = isV2Pool(pool) ? 'ProtocolV2TestBase' : 'ProtocolV3TestBase';

  const functions = artifacts
    .map((artifact) => artifact.test?.fn)
    .flat()
    .filter((f) => f !== undefined)
    .join('\n');
  let template = `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {${pool}, ${pool}Assets} from 'aave-address-book/${pool}.sol';
import {${testBase}, ReserveConfig} from 'aave-helpers/${testBase}.sol';
import {${contractName}} from './${contractName}.sol';

/**
 * @dev Test for ${contractName}
 * command: make test-contract filter=${contractName}
 */
contract ${contractName}_Test is ${testBase} {
  ${contractName} internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('${getChainAlias(chain)}'), ${await getBlock(chain)});
    proposal = new ${contractName}();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'pre${contractName}',
      ${pool}.POOL
    );

    GovV3Helpers.executePayload(
      vm,
      address(proposal)
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'post${contractName}',
      ${pool}.POOL
    );

    diffReports('pre${contractName}', 'post${contractName}');
  }

  ${functions}
}`;
  return template;
};
