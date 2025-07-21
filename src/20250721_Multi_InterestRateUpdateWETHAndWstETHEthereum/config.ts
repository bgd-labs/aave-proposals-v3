import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20250721_Multi_InterestRateUpdateWETHAndWstETHEthereum/config.ts',
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Ethereum', 'AaveV3EthereumLido'],
    title: 'Interest Rate Update - wstETH Ethereum',
    shortName: 'InterestRateUpdateWETHAndWstETHEthereum',
    date: '20250721',
    discussion:
      'https://governance.aave.com/t/risk-stewards-interest-rate-update-weth-and-wsteth-ethereum/22625',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'wstETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '40',
            },
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '35',
            asset: 'wstETH',
          },
        ],
      },
      cache: {blockNumber: 22967219},
    },
    AaveV3EthereumLido: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'wstETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '',
              variableRateSlope1: '',
              variableRateSlope2: '40',
            },
          },
        ],
      },
      cache: {blockNumber: 22967227},
    },
  },
};
