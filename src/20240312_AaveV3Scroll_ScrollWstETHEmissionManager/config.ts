import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aave Chan Initiative',
    pools: ['AaveV3Scroll'],
    title: 'Scroll wstETH Emission Manager',
    shortName: 'ScrollWstETHEmissionManager',
    date: '20240312',
    discussion:
      'https://governance.aave.com/t/arfc-set-liquidity-observation-labs-as-emission-manager-for-wsteth-on-scroll/16813',
    snapshot:
      'https://snapshot.org/#/aave.eth/proposal/0xb70490f6b0623631686d34f4ca99a7d45394ad29fdd504df3cd6e68790b22b9c',
  },
  poolOptions: {
    AaveV3Scroll: {
      configs: {
        EMISSION_MANAGER: [{asset: 'wstETH', admin: '0xC18F11735C6a1941431cCC5BcF13AF0a052A5022'}],
      },
      cache: {blockNumber: 4077518},
    },
  },
};
