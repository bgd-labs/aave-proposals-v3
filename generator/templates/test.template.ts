import {
  generateContractName,
  generateFolderName,
  getChainAlias,
  getMarketChain,
  getTestBase,
  isV3Market,
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
  const hasExpectedReserveConfigChanges = marketConfig.artifacts.some(
    (artifact) => artifact.test?.reserveConfigChanges,
  );
  if (chain === 'ZkSync' && hasExpectedReserveConfigChanges) {
    throw new Error(
      'Reserve config change tests are currently unsupported on ZkSync: the pinned aave-helpers/zksync path references ReserveConfig fields that are not available in the pinned aave-v3-origin-tests dependency.',
    );
  }
  const usesReserveConfigChangesBase = isV3Market(market) && chain !== 'ZkSync';
  const inheritedTestBase = usesReserveConfigChangesBase ? 'ProtocolV3ProposalTestBase' : testBase;
  const functions = marketConfig.artifacts
    .map((artifact) => artifact.test?.fn)
    .flat()
    .filter((f) => f !== undefined)
    .join('\n');

  const testBaseImport = usesReserveConfigChangesBase
    ? `import {ProtocolV3ProposalTestBase} from '../ProtocolV3ProposalTestBase.sol';
import {ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';`
    : v4
      ? `import {${testBase}} from 'aave-helpers/src/${testBase}.sol';`
      : `import {${testBase}, ReserveConfig} from 'aave-helpers/${chain === 'ZkSync' ? 'zksync/src/' : 'src/'}${testBase}.sol';`;

  const defaultTestArgs = v4
    ? [`'${contractName}'`, 'address(proposal)']
    : [
        `'${contractName}'`,
        `${market}.POOL`,
        'address(proposal)',
        ...(isWhitelabelMarket(market) ? ['true', 'true'] : []),
      ];
  const defaultTestCall = usesReserveConfigChangesBase
    ? `(ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(${defaultTestArgs.join(', ')});
    _validateReserveConfigChanges(allConfigsBefore, allConfigsAfter);`
    : `defaultTest(${defaultTestArgs.join(', ')});`;
  const reserveConfigChangesTestDescription = usesReserveConfigChangesBase
    ? ', and reserve configuration validation'
    : '';

  let template = `
import 'forge-std/Test.sol';
${testBaseImport}
import {${contractName}} from './${contractName}.sol';

/**
 * @dev Test for ${contractName}
 * command: FOUNDRY_PROFILE=${chain === 'ZkSync' ? 'zksync' : 'test'} forge test ${chain === 'ZkSync' ? '--zksync --match-path=zksync/src/' : '--match-path=src/'}${folderName}/${contractName}.t.sol -vv
 */
contract ${contractName}_Test is ${inheritedTestBase} {
  ${contractName} internal proposal;

  function setUp() public ${chain === 'ZkSync' ? 'override' : ''} {
    vm.createSelectFork(vm.rpcUrl('${getChainAlias(chain)}'), ${marketConfig.cache.blockNumber});
    proposal = new ${contractName}();

    ${chain === 'ZkSync' ? 'super.setUp();' : ''}
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots${reserveConfigChangesTestDescription}
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    ${defaultTestCall}
  }

  ${functions}
}`;
  return prefixWithPragma(prefixWithImports(template));
};
