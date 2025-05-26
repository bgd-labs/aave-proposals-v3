import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Base'],
    title: 'Add AAVE token to Aave V3 Base Instance',
    shortName: 'AddAAVETokenToAaveV3BaseInstance',
    date: '20250507',
    discussion: 'https://governance.aave.com/t/arfc-add-aave-token-to-aave-v3-base-instance/21105',
    snapshot:
      'snapshot.box/#/s:aavedao.eth/proposal/0x54efdfaaccf429320071c7e56dd8f14759f2027c8f1c1fb4ef0596374c7558d8',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Base: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'AAVE',
            decimals: 18,
            priceFeed: '0x3d6774EF702A10b20FCa8Ed40FC022f7E4938e07',
            ltv: '60',
            liqThreshold: '65',
            liqBonus: '10',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '20',
            supplyCap: '30000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0x63706e401c06ac8513145b7687A14804d17f814b',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 29923469},
    },
  },
};
