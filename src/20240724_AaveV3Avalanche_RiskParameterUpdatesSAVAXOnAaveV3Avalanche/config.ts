import {ConfigFile, VOTING_NETWORK} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Avalanche'],
    title: 'Risk Parameter Updates - sAVAX on Aave V3 Avalanche',
    shortName: 'RiskParameterUpdatesSAVAXOnAaveV3Avalanche',
    date: '20240724',
    author: 'Chaos Labs',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-savax-on-aave-v3-avalanche-07-16-2024/18277',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x471ab55b0091043963c744f228befd842aeb354b0d04c76da3c9eb2b401934a4',
    votingNetwork: VOTING_NETWORK.POLYGON,
  },
  poolOptions: {
    AaveV3Avalanche: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'sAVAX',
            ltv: '40',
            liqThreshold: '45',
            liqBonus: '',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 48390154},
    },
  },
};
