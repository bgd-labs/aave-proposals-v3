import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile:
      'src/20250623_AaveV3Ethereum_AdditionOfUSDeToEthenaPrincipalTokenStablecoinEModes/config.ts',
    force: true,
    update: true,
    author: 'Aave-Chan Initiative',
    pools: ['AaveV3Ethereum'],
    title: 'Addition of USDe to Ethena Principal Token Stablecoin E-Modes',
    shortName: 'AdditionOfUSDeToEthenaPrincipalTokenStablecoinEModes',
    date: '20250623',
    discussion:
      'https://governance.aave.com/t/arfc-addition-of-usde-to-ethena-principal-token-stablecoin-e-modes/22355',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x92235fc2feaa585d700789395bb69374d4de1a7a2735a7565815f8423009f160',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_ASSETS: [
          {
            asset: 'USDe',
            eModeCategory: 'AaveV3EthereumEModes.PT_EUSDE_STABLECOINS_AUGUST_2025',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
          {
            asset: 'USDe',
            eModeCategory: 'AaveV3EthereumEModes.PT_USDE_STABLECOINS_JULY_2025',
            collateral: 'DISABLED',
            borrowable: 'ENABLED',
          },
        ],
      },
      cache: {blockNumber: 22769623},
    },
  },
};
