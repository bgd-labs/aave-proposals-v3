import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'TestContractVerification',
    shortName: 'TestContractVerification',
    date: '20251224',
    author: 'ACI',
    discussion: '',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_UPDATES: [
          {
            eModeCategory: 'AaveV3EthereumEModes.USDe_sUSDe__USDC_USDT_USDS',
            ltv: '',
            liqThreshold: '',
            liqBonus: '',
            label: '',
          },
        ],
      },
      cache: {blockNumber: 24084608},
    },
  },
};
