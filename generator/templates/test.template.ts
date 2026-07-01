import {
  generateContractName,
  generateFolderName,
  getChainAlias,
  getMarketChain,
  getTestBase,
  isWhitelabelMarket,
} from '../common';
import {Options, MarketConfig, MarketIdentifier} from '../types';
import {prefixWithPragma} from '../utils/constants';
import {prefixWithImports} from '../utils/importsResolver';

export const testTemplate = (
  options: Options,
  marketConfig: MarketConfig,
  market: MarketIdentifier,
) => {
  const folderName = generateFolderName(options);
  const chain = getMarketChain(market);
  const contractName = generateContractName(options, market);
  const {v4, testBase} = getTestBase(market);

  const functions = marketConfig.artifacts
    .map((artifact) => artifact.test?.fn)
    .flat()
    .filter((f) => f !== undefined)
    .join('\n');

  const testBaseImport = v4
    ? `import {${testBase}} from 'aave-helpers/src/${testBase}.sol';`
    : `import {${testBase}, ReserveConfig} from 'aave-helpers/${chain === 'ZkSync' ? 'zksync/src/' : 'src/'}${testBase}.sol';`;

  const defaultTestCall = v4
    ? `defaultTest('${contractName}', address(proposal));`
    : `defaultTest('${contractName}', ${market}.POOL, address(proposal) ${isWhitelabelMarket(market) ? ', true, true' : ''});`;

  let template = `
import 'forge-std/Test.sol';
${testBaseImport}
import {${contractName}} from './${contractName}.sol';

/**
 * @dev Test for ${contractName}
 * command: FOUNDRY_PROFILE=${chain === 'ZkSync' ? 'zksync' : 'test'} forge test ${chain === 'ZkSync' ? '--zksync --match-path=zksync/src/' : '--match-path=src/'}${folderName}/${contractName}.t.sol -vv
 */
contract ${contractName}_Test is ${testBase} {
  ${contractName} internal proposal;

  function setUp() public ${chain === 'ZkSync' ? 'override' : ''} {
    vm.createSelectFork(vm.rpcUrl('${getChainAlias(chain)}'), ${marketConfig.cache.blockNumber});
    proposal = new ${contractName}();

    ${chain === 'ZkSync' ? 'super.setUp();' : ''}
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    ${defaultTestCall}
  }

  ${functions}
}`;
  return prefixWithPragma(prefixWithImports(template));
};
