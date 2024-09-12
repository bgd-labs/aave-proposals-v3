import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20240814_AaveV3Metis_EnableMetisAsCollateralOnMetisChain/config.ts',
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Metis'],
    title: 'Enable Metis as Collateral on Metis Chain',
    shortName: 'EnableMetisAsCollateralOnMetisChain',
    date: '20240814',
    discussion:
      'https://governance.aave.com/t/arfc-enable-metis-as-collateral-on-metis-chain/16658',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0x2e15c7011a6696de1be8fb3476db30395225eb533f849b63bdbff2b33a605ffd',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Metis: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'Metis',
            ltv: '30',
            liqThreshold: '40',
            liqBonus: '10',
            debtCeiling: '1000000',
            liqProtocolFee: '10',
          },
        ],
      },
      cache: {blockNumber: 18088801},
    },
  },
};
