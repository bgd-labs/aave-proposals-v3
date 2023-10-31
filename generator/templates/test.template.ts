import {createPublicClient, http} from 'viem';
import {
  CHAIN_TO_CHAIN_OBJECT,
  generateContractName,
  getChainAlias,
  getPoolChain,
  isV2Pool,
} from '../common';
import {Options, PoolConfig} from '../types';
import {prefixWithPragma} from '../utils/constants';
import {prefixWithImports} from '../utils/importsResolver';

export const getBlock = async (chain) => {
  return await createPublicClient({
    chain: CHAIN_TO_CHAIN_OBJECT[chain],
    transport: http(),
  }).getBlockNumber();
};

export const testTemplate = async (options: Options, poolConfig: PoolConfig) => {
  const chain = getPoolChain(poolConfig.pool);
  const contractName = generateContractName(options, poolConfig.pool);

  const testBase = isV2Pool(poolConfig.pool) ? 'ProtocolV2TestBase' : 'ProtocolV3TestBase';

  const functions = poolConfig.artifacts
    .map((artifact) => artifact.test?.fn)
    .flat()
    .filter((f) => f !== undefined)
    .join('\n');

  let template = `
import 'forge-std/Test.sol';
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

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('${contractName}', ${poolConfig.pool}.POOL, address(proposal));
  }

  ${functions}
}`;
  return prefixWithPragma(prefixWithImports(template));
};
