import {
  CHAIN_TO_CHAIN_ID,
  generateContractName,
  generateFolderName,
  getChainAlias,
  getMarketChain,
} from '../common';
import {Options} from '../types';
import {prefixWithImports} from '../utils/importsResolver';
import {prefixWithPragma} from '../utils/constants';

export function generateZkSyncScript(options: Options) {
  const folderName = generateFolderName(options);
  const fileName = generateContractName(options);
  const zkSyncMarkets = options.markets.filter((c) => c == 'AaveV3ZkSync');

  const chain = 'ZkSync';
  let template = '';

  // generate imports
  template += `import {ZkSyncScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';\n`;

  template += zkSyncMarkets
    .map((market) => {
      const name = generateContractName(options, market);
      return `import {${name}} from './${name}.sol';`;
    })
    .join('\n');
  template += '\n\n';

  const marketsToChainsMap = zkSyncMarkets.reduce((acc, market) => {
    const chain = getMarketChain(market);
    const contractName = generateContractName(options, market);
    if (!acc[chain]) acc[chain] = [];
    acc[chain].push({contractName, market});
    return acc;
  }, {});

  // generate chain scripts
  template += `/**
    * @dev Deploy ${chain}
    * deploy-command: make deploy-ledger-zk contract=zksync/src/${folderName}/${fileName}.s.sol:Deploy${chain} chain=${getChainAlias(
      chain,
    )}
    */
   contract Deploy${chain} is ${chain}Script {
     function run() external broadcast {
       // deploy payloads
       ${marketsToChainsMap[chain]
         .map(
           ({contractName, market}, ix) =>
             `address payload${ix} = address(new ${contractName}{salt: 'aave'}());`,
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
       GovV3Helpers.createPayload(actions);
     }
   }`;
  template += '\n\n';

  return prefixWithPragma(prefixWithImports(template));
}
