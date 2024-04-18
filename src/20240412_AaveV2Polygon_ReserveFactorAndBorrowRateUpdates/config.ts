import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV2Polygon'],
    title: 'Polygon V2 Reserve Factor Updates & Interest Rate Increases',
    shortName: 'ReserveFactor&BorrowRateUpdates',
    date: '20240412',
    author: 'TokenLogic & Karpatkey',
    discussion: 'https://governance.aave.com/t/arfc-polygon-v2-borrow-rate-adjustments/17252',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x95643085ee16eb0eaa4110a9f0ea8223009f9521e596e1a958303705a5001363',
  },
  poolOptions: {AaveV2Polygon: {configs: {}, cache: {blockNumber: 55966507}}},
};
