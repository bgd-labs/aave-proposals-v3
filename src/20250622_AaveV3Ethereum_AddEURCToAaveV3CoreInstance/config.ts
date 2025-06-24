import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Add EURC to Aave V3 Core Instance',
    shortName: 'AddEURCToAaveV3CoreInstance',
    date: '20250622',
    discussion: 'https://governance.aave.com/t/arfc-add-eurc-to-aave-v3-core-instance/21837',
    snapshot: 'Direct-to-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'EURC',
            decimals: 6,
            priceFeed: '0xa6aB031A4d189B24628EC9Eb155F0a0f1A0E55a3',
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
            supplyCap: '7000000',
            borrowCap: '6500000',
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '6',
              variableRateSlope2: '50',
            },
            asset: '0x1aBaEA1f7C830bD89Acc67eC4af516284b1bC33c',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 22762012},
    },
  },
};
