import {generateContractName, getPoolChain, getVersion, pragma} from '../common';
import {CodeArtifact, Options, PoolIdentifier} from '../types';

enum EngineImports {
  IEngine = 'IEngine',
  EngineFlags = 'EngineFlags',
  Rates = 'Rates',
}

enum LibraryImports {
  Assets = 'Assets',
  EModes = 'EModes',
}

function getEngineDependencies(content: string) {
  return Object.keys(EngineImports).filter((engineFlag) =>
    RegExp(engineFlag + '\\.', 'g').test(content)
  );
}

function getPoolDependencies(pool: string, content: string) {
  return [pool, ...Object.keys(LibraryImports).map((flag) => `${pool}${flag}`)].filter((library) =>
    RegExp(library + '\\.', 'g').test(content)
  );
}

function getImports(
  pool: PoolIdentifier,
  engineDependencies: string[],
  poolDependencies: string[]
) {
  let template = '';
  const chain = getPoolChain(pool);
  const version = getVersion(pool);
  if (engineDependencies.length > 0) {
    template += `import {Aave${version}Payload${chain}, ${engineDependencies.join(
      ', '
    )}} from 'aave-helpers/${version.toLowerCase()}-config-engine/Aave${version}Payload${chain}.sol';`;
  } else {
    template += `import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';\n`;
  }
  if (poolDependencies.length > 0) {
    template += `import {${poolDependencies.join(', ')}} from 'aave-address-book/${pool}.sol';\n`;
  }
  return template;
}

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
  const engineDependencies = getEngineDependencies(functions + innerExecute);
  const poolDependencies = getPoolDependencies(pool, functions + innerExecute);

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

  return `${pragma}
  
  ${getImports(pool, engineDependencies, poolDependencies)}
  
  ${contract}`;
};
