import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Borrow Cap Reductions on Aave V3 Ethereum',
    shortName: 'BorrowCapReductionsOnAaveV3Ethereum',
    date: '20240324',
    author: 'Chaos Labs',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-borrow-cap-reductions-on-aave-ethereum-03-11-24/16918',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x9fb23244675bb07e1b5406fa4276aeeb712a80026721e2321ce41bd0e612de73',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        CAPS_UPDATE: [
          {asset: 'CRV', supplyCap: '', borrowCap: '2750000'},
          {asset: 'MKR', supplyCap: '', borrowCap: '1980'},
          {asset: 'SNX', supplyCap: '', borrowCap: '150000'},
          {asset: 'BAL', supplyCap: '244200', borrowCap: '244200'},
          {asset: 'UNI', supplyCap: '', borrowCap: '330000'},
          {asset: 'LDO', supplyCap: '', borrowCap: '1500000'},
          {asset: 'ONE_INCH', supplyCap: '', borrowCap: '475200'},
          {asset: 'RPL', supplyCap: '', borrowCap: '316800'},
          {asset: 'STG', supplyCap: '', borrowCap: '3200000'},
          {asset: 'KNC', supplyCap: '', borrowCap: '350000'},
          {asset: 'FXS', supplyCap: '', borrowCap: '330000'},
        ],
      },
      cache: {blockNumber: 19503431},
    },
  },
};
