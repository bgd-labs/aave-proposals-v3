import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: [
      'AaveV3Ethereum',
      'AaveV3Polygon',
      'AaveV3Optimism',
      'AaveV3Arbitrum',
      'AaveV3Gnosis',
      'AaveV3Base',
    ],
    title: ' Set Liquidity Observation Labs as Emission manager for wstETH on V3 markets',
    shortName: 'SetLiquidityObservationLabsAsEmissionManagerForWstETHOnV3Markets',
    date: '20240206',
    author: 'Aave Chan Initiative (ACI)',
    discussion:
      'https://governance.aave.com/t/arfc-set-liquidity-observation-labs-as-emission-manager-for-wsteth-on-v3-markets/16479',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xf30c35c586e283bae81fe1c22bd4b3cfc7f6da37bde19ac9e633414f28dc9e74',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19171242}},
    AaveV3Polygon: {configs: {OTHERS: {}}, cache: {blockNumber: 53203999}},
    AaveV3Optimism: {configs: {OTHERS: {}}, cache: {blockNumber: 115824413}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 178103256}},
    AaveV3Gnosis: {configs: {OTHERS: {}}, cache: {blockNumber: 13144153}},
    AaveV3Base: {configs: {OTHERS: {}}, cache: {blockNumber: 10229131}},
  },
};
