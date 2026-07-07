import {
  generateContractName,
  generateFolderName,
  getChainAlias,
  getMarketChain,
  getTestBase,
  isV2Market,
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
  const testBaseImport = isV2Market(market)
    ? `import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV2TestBase.sol';`
    : isV3Market(market)
      ? `import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';`
      : `import {ProtocolV4TestBase} from 'aave-helpers/src/ProtocolV4TestBase.sol';`;
  const reserveConfigValidation = isV3Market(market);
  const functions = marketConfig.artifacts
    .map((artifact) => artifact.test?.fn)
    .flat()
    .filter((f) => f !== undefined)
    .join('\n');
  const updatedAssets = Array.from(
    new Set(
      marketConfig.artifacts
        .map((artifact) => artifact.test?.updatedAssets)
        .flat()
        .filter((asset) => asset !== undefined),
    ),
  );

  const defaultTestArgs = v4
    ? [`'${contractName}'`, 'address(proposal)']
    : [
        `'${contractName}'`,
        `${market}.POOL`,
        'address(proposal)',
        ...(isWhitelabelMarket(market) ? ['true', 'true'] : []),
      ];
  const reserveConfigChangesTest = reserveConfigValidation
    ? `
  /**
   * @dev checks whether reserve configurations changed or stayed unchanged as expected
   */
  function test_reserveConfigChanges() public {
    address[] memory updatedAssets = new address[](${updatedAssets.length});
    ${updatedAssets.map((asset, ix) => `updatedAssets[${ix}] = ${asset};`).join('\n    ')}
    reserveConfigChangesTest(${market}.POOL, address(proposal), updatedAssets);
  }
`
    : '';

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

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('${getChainAlias(chain)}'), ${marketConfig.cache.blockNumber});
    proposal = new ${contractName}();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(${defaultTestArgs.join(', ')});
  }

  ${reserveConfigChangesTest}
  ${functions}
}`;
  return prefixWithPragma(prefixWithImports(template));
};
