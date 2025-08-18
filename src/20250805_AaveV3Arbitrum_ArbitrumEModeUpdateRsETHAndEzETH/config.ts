import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Arbitrum'],
    title: 'Arbitrum eMode Update - rsETH and ezETH',
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
          {
            eModeCategory: 'AaveV3ArbitrumEModes.WSTETH_WETH',
            ltv: '94',
            liqThreshold: '96',
            liqBonus: '1',
            label: 'wstETH/WETH',
          },
          {
            eModeCategory: 'AaveV3ArbitrumEModes.WEETH_WSTETH',
            ltv: '93',
            liqThreshold: '95',
            liqBonus: '1',
            label: 'weETH/wstETH',
          },
        ],
      },
      cache: {blockNumber: 365273678},
    },
  },
};
