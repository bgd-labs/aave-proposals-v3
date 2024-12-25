import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'PYUSD Reserve Configuration Update & Incentive Campaign',
    shortName: 'PYUSDReserveConfigurationUpdateIncentiveCampaign',
    date: '20241031',
    author: 'karpatkey_TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-pyusd-reserve-configuration-update-incentive-campaign/19573',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xcd73f17361c7757cd94ec758b4d9f160b7cecefa7f4cb23b0b4ee49b5eb1b8b2',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        CAPS_UPDATE: [{asset: 'PYUSD', supplyCap: '', borrowCap: '15000000'}],
        COLLATERALS_UPDATE: [
          {
            asset: 'PYUSD',
            ltv: '75',
            liqThreshold: '78',
            liqBonus: '7.5',
            debtCeiling: '',
            liqProtocolFee: '10',
          },
        ],
      },
      cache: {blockNumber: 21085967},
    },
  },
};
