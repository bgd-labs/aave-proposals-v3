import {ConfigFile, VOTING_NETWORK} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum'],
    title: 'Risk Parameter Updates - Increase USDe Debt Ceiling on V3 Ethereum',
    shortName: 'RiskParameterUpdatesIncreaseUSDeDebtCeilingOnV3Ethereum',
    date: '20240801',
    author: 'Chaos Labs',
    discussion:
      'https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-increase-usde-debt-ceiling-on-v3-ethereum-07-22-2024/18325',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xea1012aaf1fe660148cfe6265cbadf23b19bb44af609caaa51ab8d7194259c28',
    votingNetwork: VOTING_NETWORK.POLYGON,
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'USDe',
            ltv: '',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '50000000',
            liqProtocolFee: '',
          },
        ],
      },
      cache: {blockNumber: 20432284},
    },
  },
};
