import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3EthereumLido'],
    title: 'Onboard ezETH to Lido Instance',
    shortName: 'OnboardEzETHToLidoInstance',
    date: '20241021',
    author: 'BGD Labs (@bgdlabs)',
    discussion:
      'https://governance.aave.com/t/arfc-onboard-ezeth-to-aave-v3-lido-instance/18504/11',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x7ef22a28cb6729ea4a978b02332ff1af8ed924a726915f9a6debf835d8bf8048',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3EthereumLido: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'ezETH',
            decimals: 18,
            priceFeed: '0x68C9c7Bf43DBd0EBab102116bc7C3C9f7d9297Ee',
            ltv: '0.05',
            liqThreshold: '0.100',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '15000',
            borrowCap: '100',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '7',
              variableRateSlope2: '300',
            },
            asset: '0xbf5495efe5db9ce00f80364c8b423567e58d2110',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 21011916},
    },
  },
};
