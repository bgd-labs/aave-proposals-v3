import {
  CHAIN_TO_CHAIN_ID,
  generateContractName,
  generateFolderName,
  getChainAlias,
  getPoolChain,
} from '../common';
import {Options} from '../types';
import {prefixWithImports} from '../utils/importsResolver';
import {prefixWithPragma} from '../utils/constants';

export function generateZkSyncScript(options: Options) {
  const folderName = generateFolderName(options);
  const fileName = generateContractName(options);
  const zkSyncPools = options.pools.filter((c) => c == 'AaveV3ZkSync');

  const chain = 'ZkSync';
  let template = '';

  // generate imports
  template += `import {ZkSyncScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';\n`;

  template += zkSyncPools
    .map((pool) => {
      const name = generateContractName(options, pool);
      return `import {${name}} from './${name}.sol';`;
    })
    .join('\n');
  template += '\n\n';

  const poolsToChainsMap = zkSyncPools.reduce((acc, pool) => {
    const chain = getPoolChain(pool);
    const contractName = generateContractName(options, pool);
    if (!acc[chain]) acc[chain] = [];
    acc[chain].push({contractName, pool});
    return acc;
  }, {});

  // generate zksync wrapper contract for deploying payloads
  template += `
  ${poolsToChainsMap[chain]
    .map(
      ({contractName}) =>
        `
        // @dev wrapper factory contract for deploying the payload
        contract Deploy_${contractName} {
          address public immutable PAYLOAD;

          constructor() {
            PAYLOAD = GovV3Helpers.deployDeterministicZkSync(
              type(${contractName}).creationCode
            );
          }
        }`,
    )
    .join('\n')}
  `;
  template += '\n\n';

  // generate chain scripts
  template += `/**
    * @dev Deploy ${chain}
    * deploy-command: FOUNDRY_PROFILE=zksync make deploy-pk contract=zksync/src/${folderName}/${fileName}.s.sol:Deploy${chain} chain=${getChainAlias(
      chain,
    )}
    */
   contract Deploy${chain} is ${chain}Script {
     function run() external broadcast {
       // deploy payloads
       ${poolsToChainsMap[chain]
         .map(
           ({contractName, pool}, ix) =>
             `address payload${ix} = new Deploy_${contractName}().PAYLOAD();`,
         )
         .join('\n')}

       // compose action
       IPayloadsControllerCore.ExecutionAction[] memory actions = new IPayloadsControllerCore.ExecutionAction[](${
         poolsToChainsMap[chain].length
       });
       ${poolsToChainsMap[chain]
         .map(
           ({contractName, pool}, ix) => `actions[${ix}] = GovV3Helpers.buildAction(payload${ix});`,
         )
         .join('\n')}

       // register action at payloadsController
       GovV3Helpers.createPayload(actions);
     }
   }`;
  template += '\n\n';

  return prefixWithPragma(prefixWithImports(template));
}
