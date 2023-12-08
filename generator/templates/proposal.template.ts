import {generateContractName, getPoolChain, getVersion} from '../common';
import {FEATURE, Options, PoolConfig, PoolIdentifier} from '../types';
import {prefixWithImports} from '../utils/importsResolver';
import {prefixWithPragma} from '../utils/constants';

export const proposalTemplate = (
  options: Options,
  poolConfig: PoolConfig,
  pool: PoolIdentifier
) => {
  const {title, author, snapshot, discussion} = options;
  const chain = getPoolChain(pool);
  const version = getVersion(pool);
  const contractName = generateContractName(options, pool);

  const constants = poolConfig.artifacts
    .map((artifact) => artifact.code?.constants)
    .flat()
    .filter((f) => f !== undefined)
    .join('\n');
  const functions = poolConfig.artifacts
    .map((artifact) => artifact.code?.fn)
    .flat()
    .filter((f) => f !== undefined)
    .join('\n');
  const innerExecute = poolConfig.artifacts
    .map((artifact) => artifact.code?.execute)
    .flat()
    .filter((f) => f !== undefined)
    .join('\n');

  let optionalExecute = '';
  const usesConfigEngine = Object.keys(poolConfig.configs).some(
    (f) => ![FEATURE.OTHERS, FEATURE.FLASH_BORROWER].includes(f)
  );
  const isAssetListing = Object.keys(poolConfig.configs).some((f) =>
    [FEATURE.ASSET_LISTING, FEATURE.ASSET_LISTING_CUSTOM].includes(f)
  );
  if (innerExecute) {
    if (usesConfigEngine) {
      optionalExecute = `function _postExecute() internal override {
        ${innerExecute}
       }`;
    } else {
      optionalExecute = `function execute() external {
        ${innerExecute}
       }`;
    }
  }

  const contract = `/**
  * @title ${title || 'TODO'}
  * @author ${author || 'TODO'}
  * - Snapshot: ${snapshot || 'TODO'}
  * - Discussion: ${discussion || 'TODO'}
  */
 contract ${contractName} is ${
    usesConfigEngine ? `Aave${version}Payload${chain}` : 'IProposalGenericExecutor'
  } {
   ${isAssetListing ? 'using SafeERC20 for IERC20;' : ''}

   ${constants}

   ${optionalExecute}

   ${functions}
 }`;

  return prefixWithPragma(prefixWithImports(contract));
};
