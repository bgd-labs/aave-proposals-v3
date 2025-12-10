import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave-chan Initiative',
    pools: ['AaveV3Avalanche'],
    title: 'Onboard rsETH to Aave V3 Avalanche Instance',
    shortName: 'OnboardRsETHToAaveV3AvalancheInstance',
    date: '20251117',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-onboard-rseth-to-aave-v3-avalanche-instance/23313',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Avalanche: {
      configs: {
        EMODES_CREATION: [
          {
            ltv: '93',
            liqThreshold: '95',
            liqBonus: '1',
            label: 'wrsETH/ETH',
            collateralAssets: ['wrsETH'],
            borrowableAssets: ['WETHe'],
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'wrsETH',
            decimals: 18,
            priceFeed: '0xe5Af98d1c62c7D9C1378AF187eEFB0BEe112ff64',
            ltv: '0.05',
            liqThreshold: '0.1',
            liqBonus: '7',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '45',
            supplyCap: '5000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0x7bFd4CA2a6Cf3A3fDDd645D10B323031afe47FF0',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 72125217},
    },
  },
};
