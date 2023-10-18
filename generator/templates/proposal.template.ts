import {generateContractName, getPoolChain, getVersion, pragma} from '../common';
import {CodeArtifact, Options, PoolIdentifier} from '../types';
import {prefixWithImports} from '../utils/importsResolver';
import {prefixWithPragma} from './utils';

export const proposalTemplate = (
  options: Options,
  pool: PoolIdentifier,
  artifacts: CodeArtifact[] = []
) => {
  const {title, author, snapshot, discussion} = options;
  const chain = getPoolChain(pool);
  const version = getVersion(pool);
  const contractName = generateContractName(options, pool);

  const constants = artifacts
    .map((artifact) => artifact.code?.constants)
    .flat()
    .filter((f) => f !== undefined)
    .join('\n');
  const functions = artifacts
    .map((artifact) => artifact.code?.fn)
    .flat()
    .filter((f) => f !== undefined)
    .join('\n');
  const innerExecute = artifacts
    .map((artifact) => artifact.code?.execute)
    .flat()
    .filter((f) => f !== undefined)
    .join('\n');

  let optionalExecute = '';
  if (engineDependencies.length > 0) {
    optionalExecute = `function _preExecute() internal override {
        ${innerExecute}
       }`;
  } else {
    optionalExecute = `function execute() external {
        ${innerExecute}
       }`;
  }

  const contract = `/**
  * @title ${title || 'TODO'}
  * @author ${author || 'TODO'}
  * - Snapshot: ${snapshot || 'TODO'}
  * - Discussion: ${discussion || 'TODO'}
  */
 contract ${contractName} is ${
    engineDependencies.length > 0 ? `Aave${version}Payload${chain}` : 'IProposalGenericExecutor'
  } {
   ${constants}
 
   ${optionalExecute}
 
   ${functions}
 }`;

  return prefixWithPragma(prefixWithImports(contract));
};
