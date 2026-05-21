import {confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifier} from '../types';
import {getContract} from 'viem';
import {CHAIN_TO_CHAIN_ID, getMarketChain, getExplorerLink} from '../common';
import {testExecuteProposal} from '../utils/constants';
import {EmissionUpdate} from './types';
import {addressPrompt, translateJsAddressToSol} from '../prompts/addressPrompt';
import {getClient} from '@bgd-labs/toolbox';

async function fetchEmission(market: MarketIdentifier): Promise<EmissionUpdate> {
  const asset = await addressPrompt({
    message: 'Address of the reward asset for which emission admin will be set',
    required: true,
  });

  const chain = getMarketChain(market);
  const erc20 = getContract({
    abi: [
      {
        constant: true,
        inputs: [],
        name: 'symbol',
        outputs: [{internalType: 'string', name: '', type: 'string'}],
        payable: false,
        stateMutability: 'view',
        type: 'function',
      },
    ],
    client: getClient(CHAIN_TO_CHAIN_ID[chain], {}),
    address: asset,
  });
  let symbol = '';
  try {
    symbol = await erc20.read.symbol();
  } catch (e) {
    console.log('could not fetch the symbol - this is likely an error');
    console.log(e);
  }

  const admin = await addressPrompt({
    message: `Address of the emission admin for the selected reward asset (${symbol})`,
    required: true,
  });
  return {
    asset: asset,
    symbol: symbol,
    admin: admin,
  };
}

export const emissionUpdates: FeatureModule<EmissionUpdate[]> = {
  value: FEATURE.EMISSION,
  description: 'Set the emission admin for an asset',
  async cli({market}) {
    const response: EmissionUpdate[] = [];
    let more: boolean = true;
    while (more) {
      response.push(await fetchEmission(market));
      more = await confirm({
        message: 'Do you want to assign an emission admin to another asset?',
        default: false,
      });
    }
    return response;
  },
  build({market, cfg}) {
    const response: CodeArtifact = {
      code: {
        constants: cfg
          .map((cfg) => {
            const chainId = CHAIN_TO_CHAIN_ID[getMarketChain(market)];
            return [
              `// ${getExplorerLink(chainId, cfg.asset)}\naddress public constant ${cfg.symbol} = ${translateJsAddressToSol(cfg.asset)};`,
              `// ${getExplorerLink(chainId, cfg.admin)}\naddress public constant ${cfg.symbol}_ADMIN = ${translateJsAddressToSol(cfg.admin)};`,
            ];
          })
          .flat(),
        execute: cfg.map(
          (cfg) =>
            `IEmissionManager(${market}.EMISSION_MANAGER).setEmissionAdmin(${cfg.symbol}, ${cfg.symbol}_ADMIN);`,
        ),
      },
      test: {
        fn: cfg.map(
          (cfg) => `function test_${cfg.symbol}Admin() public {
            ${testExecuteProposal(market)}
            assertEq(IEmissionManager(${market}.EMISSION_MANAGER).getEmissionAdmin(${translateJsAddressToSol(cfg.asset)}), ${translateJsAddressToSol(cfg.admin)});
          }`,
        ),
      },
      aip: {
        specification: cfg.map(
          (cfg) =>
            `The emission admin role for [${cfg.symbol}](${getExplorerLink(CHAIN_TO_CHAIN_ID[getMarketChain(market)], cfg.asset)}) is granted to [${cfg.admin}](${getExplorerLink(CHAIN_TO_CHAIN_ID[getMarketChain(market)], cfg.admin)}).\n`,
        ),
      },
    };
    return response;
  },
};
