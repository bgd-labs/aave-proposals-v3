import {
  CHAIN_TO_CHAIN_ID,
  generateContractName,
  generateFolderName,
  getChainAlias,
  getMarketChain,
  getVotingPortal,
  isWhitelabelMarket,
} from '../common';
import {Options} from '../types';
import {prefixWithImports} from '../utils/importsResolver';
import {prefixWithPragma} from '../utils/constants';

export function generateScript(options: Options) {
  const folderName = generateFolderName(options);
  const fileName = generateContractName(options);
  const votingPortal = getVotingPortal(options.votingNetwork);
  let template = '';
  const chains = [...new Set(options.markets.map((market) => getMarketChain(market)!))];
  const hasWhitelabelMarket = options.markets.some((market) => isWhitelabelMarket(market));

  // generate imports
  template += `import {${['Ethereum', ...chains.filter((c) => c !== 'Ethereum' && c !== 'ZkSync')]
    .map((chain) => `${chain}Script`)
    .join(', ')}} from 'solidity-utils/contracts/utils/ScriptUtils.sol';\n`;
  template += options.markets
    .filter((c) => c !== 'AaveV3ZkSync')
    .map((market) => {
      const name = generateContractName(options, market);
      return `import {${name}} from './${name}.sol';`;
    })
    .join('\n');
  template += '\n\n';

  const marketsToChainsMap = options.markets.reduce((acc, market) => {
    const chain = getMarketChain(market);
    const contractName = generateContractName(options, market);
    if (!acc[chain]) acc[chain] = [];
    acc[chain].push({contractName, market});
    return acc;
  }, {});

  // generate chain scripts
  template += Object.keys(marketsToChainsMap)
    .filter((c) => c !== 'ZkSync')
    .map((chain) => {
      return `/**
    * @dev Deploy ${chain}
    * deploy-command: make deploy-ledger contract=src/${folderName}/${fileName}.s.sol:Deploy${chain} chain=${getChainAlias(
      chain,
    )}
    * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/${fileName}.s.sol/${
      CHAIN_TO_CHAIN_ID[chain]
    }/run-latest.json
    */
   contract Deploy${chain} is ${chain}Script {
     function run() external broadcast {
       // deploy payloads
       ${marketsToChainsMap[chain]
         .map(
           ({contractName, market}, ix) =>
             `address payload${ix} = GovV3Helpers.deployDeterministic(type(${contractName}).creationCode);`,
         )
         .join('\n')}

       // compose action
       IPayloadsControllerCore.ExecutionAction[] memory actions = new IPayloadsControllerCore.ExecutionAction[](${
         marketsToChainsMap[chain].length
       });
       ${marketsToChainsMap[chain]
         .map(
           ({contractName, market}, ix) =>
             `actions[${ix}] = GovV3Helpers.buildAction(payload${ix});`,
         )
         .join('\n')}

       // register action at payloadsController
       ${
         hasWhitelabelMarket
           ? `GovV3Helpers.createPermissionedPayloadCalldata(GovernanceV3${marketsToChainsMap[chain][0].market.replace('AaveV3', '')}.PERMISSIONED_PAYLOADS_CONTROLLER, actions);`
           : 'GovV3Helpers.createPayload(actions);'
       }
     }
   }`;
    })
    .join('\n\n');
  template += '\n\n';

  // generate proposal creation script
  if (!hasWhitelabelMarket) {
    template += `/**
      * @dev Create Proposal
      * command: make deploy-ledger contract=src/${folderName}/${fileName}.s.sol:CreateProposal chain=mainnet
      */
      contract CreateProposal is EthereumScript {
        function run() external {
          // create payloads
          PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](${
            Object.keys(marketsToChainsMap).length
          });

          // compose actions for validation
          ${Object.keys(marketsToChainsMap)
            .map((chain, ix) => {
              let template = `{\nIPayloadsControllerCore.ExecutionAction[] memory actions${chain} = new IPayloadsControllerCore.ExecutionAction[](${marketsToChainsMap[chain].length});\n`;
              template += marketsToChainsMap[chain]
                .map(({contractName, market}, ix) => {
                  return market == 'AaveV3ZkSync'
                    ? `actions${chain}[${ix}] = GovV3Helpers.buildActionZkSync(vm, '${contractName}');`
                    : `actions${chain}[${ix}] = GovV3Helpers.buildAction(type(${contractName}).creationCode);`;
                })
                .join('\n');
              template += `payloads[${ix}] = GovV3Helpers.build${
                chain == 'Ethereum' ? 'Mainnet' : chain
              }Payload(vm, actions${chain});\n}\n`;
              return template;
            })
            .join('\n')}

          // create proposal
          vm.startBroadcast();
          GovV3Helpers.createProposal(vm, payloads, ${votingPortal}, GovV3Helpers.ipfsHashFile(vm, 'src/${folderName}/${
            options.shortName
          }.md'));
        }
    }`;
  }
  return prefixWithPragma(prefixWithImports(template));
}
