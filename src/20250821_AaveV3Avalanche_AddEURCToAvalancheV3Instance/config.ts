import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Avalanche'],
    title: 'Add EURC to Avalanche V3 Instance',
    shortName: 'AddEURCToAvalancheV3Instance',
    date: '20250821',
    discussion: 'https://governance.aave.com/t/arfc-add-eurc-to-avalanche-v3-instance/21734',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Avalanche: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'EURC',
            decimals: 6,
            priceFeed: '0x3368310bC4AeE5D96486A73bae8E6b49FcDE62D3',
            ltv: '75',
            liqThreshold: '78',
            liqBonus: '5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '10',
            supplyCap: '3000000',
            borrowCap: '2800000',
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '6',
              variableRateSlope2: '50',
            },
            asset: '0xC891EB4cbdEFf6e073e859e987815Ed1505c2ACD',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 67423170},
    },
  },
};
