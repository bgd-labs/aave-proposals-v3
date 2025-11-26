import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Onboard syrupUSDT to Aave V3 Core Instance',
    shortName: 'OnboardSyrupUSDTToAaveV3CoreInstance',
    date: '20251126',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-onboard-syrupusdt-to-aave-v3-core-instance/23291',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_CREATION: [
          {
            ltv: '90',
            liqThreshold: '92',
            liqBonus: '4',
            label: 'syrupUSDT Stablecoins',
            collateralAssets: ['syrupUSDT'],
            borrowableAssets: ['USDT', 'GHO'],
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'syrupUSDT',
            decimals: 6,
            priceFeed: '0x982aC260B5a4e5bCAb6A437e79168390cFbDe70D',
            ltv: '0.05',
            liqThreshold: '.1',
            liqBonus: '6',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '50',
            supplyCap: '50000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0x356B8d89c1e1239Cbbb9dE4815c39A1474d5BA7D',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 23883346},
    },
  },
};
