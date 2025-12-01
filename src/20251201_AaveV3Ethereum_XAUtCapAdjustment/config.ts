import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'XAUt cap adjustment',
    shortName: 'XAUtCapAdjustment',
    date: '20251201',
    author: 'Chaos Labs (implemented by ACI via Skyward)',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-xaut-supply-cap-and-debt-ceiling-adjustment-on-aave-v3-core-instance/23466',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        CAPS_UPDATE: [{asset: 'XAUt', supplyCap: '10000', borrowCap: ''}],
        COLLATERALS_UPDATE: [
          {
            asset: 'XAUt',
            ltv: '',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '25000000',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 23921415},
    },
  },
};
