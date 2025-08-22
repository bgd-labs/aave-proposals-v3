import {
  generateContractName,
  generateFolderName,
  getChainAlias,
  getPoolChain,
  isV2Pool,
  isWhitelabelPool,
} from '../common';
import {Options, PoolConfig, PoolIdentifier} from '../types';
import {prefixWithPragma} from '../utils/constants';
import {prefixWithImports} from '../utils/importsResolver';

export const testTemplate = (options: Options, poolConfig: PoolConfig, pool: PoolIdentifier) => {
  const folderName = generateFolderName(options);
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
import {${testBase}, ReserveConfig} from 'aave-helpers/${chain === 'ZkSync' ? 'zksync/src/' : 'src/'}${testBase}.sol';
import {${contractName}} from './${contractName}.sol';

/**
 * @dev Test for ${contractName}
 * command: FOUNDRY_PROFILE=${chain === 'ZkSync' ? 'zksync' : 'test'} forge test ${chain === 'ZkSync' ? '--zksync --match-path=zksync/src/' : '--match-path=src/'}${folderName}/${contractName}.t.sol -vv
 */
contract ${contractName}_Test is ${testBase} {
  ${contractName} internal proposal;

  function setUp() public ${chain === 'ZkSync' ? 'override' : ''} {
    vm.createSelectFork(vm.rpcUrl('${getChainAlias(chain)}'), ${poolConfig.cache.blockNumber});
    proposal = new ${contractName}();

    ${chain === 'ZkSync' ? 'super.setUp();' : ''}
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('${contractName}', ${pool}.POOL, address(proposal) ${isWhitelabelPool(pool) ? ', true, true' : ''});
  }

  ${functions}
}`;
  return prefixWithPragma(prefixWithImports(template));
};
