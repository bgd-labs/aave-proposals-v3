import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Ethereum', 'AaveV2Avalanche'],
    title: 'Reserve Factor Upgrades',
    shortName: 'ReserveFactorUpgrades',
    date: '20240506',
    author: 'karpatkey_TokenLogic',
    discussion: 'https://governance.aave.com/t/arfc-avalanche-v2-reserve-factor-adjustment/17040/4',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x770ff4e02634c77aaa09952345551168920f7878b32ab03fcef92763a5fb70ab',
  },
  poolOptions: {
    AaveV2Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19812001}},
    AaveV2Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 45105736}},
  },
};
