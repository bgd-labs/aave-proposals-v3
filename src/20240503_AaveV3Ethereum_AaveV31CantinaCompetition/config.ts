import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Aave v3.1 Cantina competition',
    shortName: 'AaveV31CantinaCompetition',
    date: '20240503',
    author: 'BGD Labs @bgdlabs',
    discussion: 'https://governance.aave.com/t/arfc-bgd-aave-3-1-cantina-competition/17485',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x79de5212e90a562918f72d47809bba5af1221cce4a8cd6dd38b89f38984e90ee',
  },
  poolOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 19788187}}},
};
