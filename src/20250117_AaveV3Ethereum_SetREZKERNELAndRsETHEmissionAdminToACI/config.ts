import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20250117_AaveV3Ethereum_SetREZKERNELAndRsETHEmissionAdminToACI/config.ts',
    force: true,
    author: 'Aave-chan Initiative',
    title: 'Set REZ, KERNEL and rsETH Emission Admin to ACI',
    discussion:
      'https://governance.aave.com/t/arfc-set-rez-kernel-and-rseth-emission-admin-to-aci/20599',
    snapshot: 'Direct-to-AIP',
    pools: ['AaveV3Ethereum'],
    shortName: 'SetREZKERNELAndRsETHEmissionAdminToACI',
    date: '20250117',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMISSION: [
          {
            asset: '0x3B50805453023a91a8bf641e279401a0b23FA6F9',
            symbol: 'REZ',
            admin: '0xdef1FA4CEfe67365ba046a7C630D6B885298E210',
          },
          {
            asset: '0x3f80b1c54ae920be41a77f8b902259d48cf24ccf',
            symbol: 'KERNEL',
            admin: '0xdef1FA4CEfe67365ba046a7C630D6B885298E210',
          },
          {
            asset: '0xa1290d69c65a6fe4df752f95823fae25cb99e5a7',
            symbol: 'rsETH',
            admin: '0xdef1FA4CEfe67365ba046a7C630D6B885298E210',
          },
        ],
      },
      cache: {blockNumber: 21644687},
    },
  },
};
