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

export function generateScript(options: Options) {
  const folderName = generateFolderName(options);
  const fileName = generateContractName(options);
  let template = '';
  const chains = [...new Set(options.pools.map((pool) => getPoolChain(pool)!))];

  // generate imports
  template += `import {${['Ethereum', ...chains.filter((c) => c !== 'Ethereum')]
    .map((chain) => `${chain}Script`)
    .join(', ')}} from 'aave-helpers/ScriptUtils.sol';\n`;
  template += options.pools
    .map((pool) => {
      const name = generateContractName(options, pool);
      return `import {${name}} from './${name}.sol';`;
    })
    .join('\n');
  template += '\n\n';

  const poolsToChainsMap = options.pools.reduce((acc, pool) => {
    const chain = getPoolChain(pool);
    const contractName = generateContractName(options, pool);
    if (!acc[chain]) acc[chain] = [];
    acc[chain].push({contractName, pool});
    return acc;
  }, {});

  // generate chain scripts
  template += Object.keys(poolsToChainsMap)
    .map((chain) => {
      return `/**
    * @dev Deploy ${chain}
    * deploy-command: make deploy-ledger contract=src/${folderName}/${fileName}.s.sol:Deploy${chain} chain=${getChainAlias(
        chain
      )}
    * verify-command: npx catapulta-verify -b broadcast/${fileName}.s.sol/${
        CHAIN_TO_CHAIN_ID[chain]
      }/run-latest.json
    */
   contract Deploy${chain} is ${chain}Script {
     function run() external broadcast {
       // deploy payloads
       ${poolsToChainsMap[chain]
         .map(
           ({contractName, pool}, ix) =>
             `address payload${ix} = GovV3Helpers.deployDeterministic(type(${contractName}).creationCode);`
         )
         .join('\n')}

       // compose action
       IPayloadsControllerCore.ExecutionAction[] memory actions = new IPayloadsControllerCore.ExecutionAction[](${
         poolsToChainsMap[chain].length
       });
       ${poolsToChainsMap[chain]
         .map(
           ({contractName, pool}, ix) => `actions[${ix}] = GovV3Helpers.buildAction(payload${ix});`
         )
         .join('\n')}

       // register action at payloadsController
       GovV3Helpers.createPayload(actions);
     }
   }`;
    })
    .join('\n\n');
  template += '\n\n';

  // generate proposal creation script
  template += `/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/${folderName}/${fileName}.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](${
      Object.keys(poolsToChainsMap).length
    });

    // compose actions for validation
    ${Object.keys(poolsToChainsMap)
      .map((chain, ix) => {
        let template = `IPayloadsControllerCore.ExecutionAction[] memory actions${chain} = new IPayloadsControllerCore.ExecutionAction[](${poolsToChainsMap[chain].length});\n`;
        template += poolsToChainsMap[chain]
          .map(({contractName, pool}, ix) => {
            return `actions${chain}[${ix}] = GovV3Helpers.buildAction(type(${contractName}).creationCode);`;
          })
          .join('\n');
        template += `payloads[${ix}] = GovV3Helpers.build${
          chain == 'Ethereum' ? 'Mainnet' : chain
        }Payload(vm, actions${chain});\n`;
        return template;
      })
      .join('\n')}

    // create proposal
    GovV3Helpers.createProposal(vm, payloads, GovV3Helpers.ipfsHashFile(vm, 'src/${folderName}/${
    options.shortName
  }.md'));
  }
}`;
  return prefixWithPragma(prefixWithImports(template));
}
