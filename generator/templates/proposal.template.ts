import {generateContractName, getPoolChain, getVersion} from '../common';
import {FEATURE, Options, PoolConfig} from '../types';
import {prefixWithImports} from '../utils/importsResolver';
import {prefixWithPragma} from './utils';

export const proposalTemplate = (options: Options, poolConfig: PoolConfig) => {
  const {title, author, snapshot, discussion} = options;
  const chain = getPoolChain(poolConfig.pool);
  const version = getVersion(poolConfig.pool);
  const contractName = generateContractName(options, poolConfig.pool);

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
  const usesConfigEngine = poolConfig.features.some(
    (f) => ![FEATURE.OTHERS, FEATURE.FLASH_BORROWER].includes(f)
  );
  if (innerExecute) {
    if (usesConfigEngine) {
      optionalExecute = `function _preExecute() internal override {
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
   ${constants}
 
   ${optionalExecute}
 
   ${functions}
 }`;

  return prefixWithPragma(prefixWithImports(contract));
};
