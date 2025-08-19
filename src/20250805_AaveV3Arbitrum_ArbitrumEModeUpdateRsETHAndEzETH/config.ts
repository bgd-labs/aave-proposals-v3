import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Arbitrum', 'AaveV3Ethereum'],
    title: 'Multi eMode Update - rsETH and ezETH',
    shortName: 'ArbitrumEModeUpdateRsETHAndEzETH',
    date: '20250805',
    author: '@TokenLogic',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-arbitrum-emode-update-rseth-and-ezeth/22731/3',
    snapshot: 'Direct-To-AIP',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Arbitrum: {
      configs: {
        EMODES_CREATION: [
          {
            ltv: '94',
            liqThreshold: '96',
            liqBonus: '1',
            label: 'wstETH/wETH ETH Correlated',
            collateralAssets: ['wstETH'],
            borrowableAssets: ['wETH'],
          },
        ],
        EMODES_UPDATES: [
          {
            eModeCategory: 'AaveV3ArbitrumEModes.EZETH_WSTETH',
            ltv: '93',
            liqThreshold: '95',
            liqBonus: '1',
            label: 'ETH correlated',
          },
          {
            eModeCategory: 'AaveV3ArbitrumEModes.RSETH_WSTETH',
            ltv: '93',
            liqThreshold: '95',
            liqBonus: '1',
            label: 'ETH correlated',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'WETH',
            eModeCategory: 'AaveV3ArbitrumEModes.EZETH_WSTETH',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
          {
            asset: 'WETH',
            eModeCategory: 'AaveV3ArbitrumEModes.RSETH_WSTETH',
            collateral: 'ENABLED',
            borrowable: 'DISABLED',
          },
        ],
      },
      cache: {blockNumber: 370166375},
    },
    AaveV3Ethereum: {
      configs: {
        EMODES_CREATION: [
          {
            ltv: '93',
            liqThreshold: '95',
            liqBonus: '1',
            label: 'weETH/wstETH',
            collateralAssets: ['weETH'],
            borrowableAssets: ['wstETH'],
          },
        ],
      },
      cache: {blockNumber: 23177170},
    },
  },
};
