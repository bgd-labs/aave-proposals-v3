import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Chaos Labs',
    pools: ['AaveV3Ethereum', 'AaveV3Optimism', 'AaveV3BNB'],
    title: 'Chaos Labs Risk Parameter Updates - Decrease Supply and Borrow Caps on Aave V3 ',
    shortName: 'ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3',
    date: '20240906',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-decrease-supply-and-borrow-caps-on-aave-v3-08-28-2024/18793',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x1ea388307b70d30c040f63e8a09d49276c5c8c9ef2fd809809f253654e5f5f06',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        CAPS_UPDATE: [
          {asset: 'crvUSD', supplyCap: '5000000', borrowCap: '2500000'},
          {asset: 'sUSDe', supplyCap: '4000000', borrowCap: ''},
        ],
      },
      cache: {blockNumber: 20693024},
    },
    AaveV3Optimism: {
      configs: {
        CAPS_UPDATE: [
          {asset: 'DAI', supplyCap: '10000000', borrowCap: '7000000'},
          {asset: 'LUSD', supplyCap: '2000000', borrowCap: '500000'},
        ],
      },
      cache: {blockNumber: 125022388},
    },
    AaveV3BNB: {
      configs: {CAPS_UPDATE: [{asset: 'USDC', supplyCap: '15000000', borrowCap: '10000000'}]},
      cache: {blockNumber: 42022431},
    },
  },
};
