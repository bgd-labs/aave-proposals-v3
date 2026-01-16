import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Maple Finance (implemented by Aavechan Initiative @aci via Skyward)',
    pools: ['AaveV3Base'],
    title: 'Onboard syrupUSDC on Base',
    shortName: 'OnboardSyrupUSDCOnBase',
    date: '20260114',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-onboard-syrupusdc-to-aave-v3-base-instance/23234',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Base: {
      configs: {
        EMODES_CREATION: [
          {
            ltv: '90',
            liqThreshold: '92',
            liqBonus: '4',
            label: 'SyrupUSDC__USDC_GHO',
            collateralAssets: ['WETH'],
            borrowableAssets: ['USDC', 'GHO'],
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'syrupUSDC',
            decimals: 6,
            priceFeed: '0xa61f10Bb2f05A94728734A8a95673ADbCA9B8397',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '4',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '50',
            supplyCap: '50000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '3000',
            },
            asset: '0x660975730059246A68521a3e2FBD4740173100f5',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 40786531},
    },
  },
};
