import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Add ezETH to Aave v3 Core Instance',
    shortName: 'AddEzETHToAaveV3CoreInstance',
    date: '20250801',
    author: '@TokenLogic',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-add-ezeth-to-aave-v3-core-instance/22732',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_CREATION: [
          {
            ltv: '93',
            liqThreshold: '95',
            liqBonus: '1',
            label: 'ezETH/wstETH',
            collateralAssets: [],
            borrowableAssets: ['wstETH'],
          },
          {
            ltv: '75',
            liqThreshold: '78',
            liqBonus: '7.50',
            label: 'ezETH/stablecoin',
            collateralAssets: [],
            borrowableAssets: ['USDC', 'USDT'],
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'ezETH',
            decimals: 18,
            priceFeed: '0xF3d49021fF3bbBFDfC1992A4b09E5D1d141D044C',
            ltv: '.05',
            liqThreshold: '.1',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '15',
            supplyCap: '50000',
            borrowCap: '0',
            rateStrategyParams: {
              optimalUtilizationRate: '0',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '0',
              variableRateSlope2: '0',
            },
            asset: '0xbf5495efe5db9ce00f80364c8b423567e58d2110',
            admin: '',
          },
        ],
      },
      cache: {blockNumber: 23089977},
    },
  },
};
