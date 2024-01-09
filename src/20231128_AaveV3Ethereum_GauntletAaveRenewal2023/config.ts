import {ConfigFile} from '../../generator/types';

export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Gauntlet <> Aave Renewal 2023',
    shortName: 'GauntletAaveRenewal2023',
    date: '20231128',
    author: 'Gauntlet',
    discussion: 'https://governance.aave.com/t/arfc-gauntlet-aave-renewal-2023/15380',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x8771479c821f55fe5fd16f939047de573203ac540282810a94ccf1bce2e2c021',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        OTHERS: {},
      },
      cache: {
        blockNumber: 18672689,
      },
    },
  },
};
