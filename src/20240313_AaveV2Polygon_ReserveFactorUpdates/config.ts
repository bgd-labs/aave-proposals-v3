import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Polygon'],
    title: 'ReserveFactorUpdates',
    shortName: 'ReserveFactorUpdates',
    date: '20240313',
    author: 'TokenLogic',
    discussion:
      'https://vote.onaave.com/proposal/?proposalId=1&ipfsHash=0x552721cffc5278357af7de0861cbf8a493488c64ec112cf573b9a33623602b90',
    snapshot: 'https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937',
  },
  poolOptions: {AaveV2Polygon: {configs: {}, cache: {blockNumber: 54615660}}},
};
