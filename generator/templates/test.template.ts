import {generateContractName, getChainAlias, getPoolChain, isV2Pool} from '../common';
import {Options, PoolConfig, PoolIdentifier} from '../types';
import {prefixWithPragma} from '../utils/constants';
import {prefixWithImports} from '../utils/importsResolver';

export const testTemplate = (options: Options, poolConfig: PoolConfig, pool: PoolIdentifier) => {
  const chain = getPoolChain(pool);
  const contractName = generateContractName(options, pool);

  const testBase = isV2Pool(pool) ? 'ProtocolV2TestBase' : 'ProtocolV3TestBase';

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
    vm.createSelectFork(vm.rpcUrl('${getChainAlias(chain)}'), ${poolConfig.cache.blockNumber});
    proposal = new ${contractName}();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('${contractName}', ${pool}.POOL, address(proposal));
  }

  ${functions}
}`;
  return prefixWithPragma(prefixWithImports(template));
};
