import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Allow PyUSD as collateral',
    shortName: 'AllowPyUSDAsCollateral',
    date: '20251009',
    discussion: '',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'PYUSD',
            ltv: '75',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 23541379},
    },
  },
};
