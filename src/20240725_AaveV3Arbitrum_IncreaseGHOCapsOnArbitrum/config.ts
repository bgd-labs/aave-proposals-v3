import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Arbitrum'],
    title: 'Increase GHO Caps On Arbitrum',
    shortName: 'IncreaseGHOCapsOnArbitrum',
    date: '20240725',
    author: 'Karpatkey_Tokenlogic',
    discussion: '',
    snapshot: '',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {AaveV3Arbitrum: {configs: {CAPS_UPDATE: []}, cache: {blockNumber: 235969452}}},
};
