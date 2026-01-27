import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'MKR and USDtb oracle adjustments',
    shortName: 'MKRAndUSDtbOracleAdjustments',
    date: '20260127',
    author: 'BGD Labs @bgdlabs',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-mkr-and-usdtb-oracle-adjustments/23911',
    snapshot: '',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {AaveV3Ethereum: {configs: {}, cache: {blockNumber: 24324715}}},
};
