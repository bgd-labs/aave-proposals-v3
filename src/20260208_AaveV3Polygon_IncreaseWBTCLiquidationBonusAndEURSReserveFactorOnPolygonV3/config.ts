import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Chaos Labs (implemented by Aavechan Initiative @aci via Skyward)',
    pools: ['AaveV3Polygon'],
    title: 'Increase WBTC Liquidation Bonus and EURS Reserve Factor on Polygon V3 ',
    shortName: 'IncreaseWBTCLiquidationBonusAndEURSReserveFactorOnPolygonV3',
    date: '20260208',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-increase-wbtc-liquidation-bonus-and-eurs-reserve-factor-on-polygon-v3/24029',
    snapshot: 'direct-to-aip',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Polygon: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'WBTC',
            ltv: '',
            liqThreshold: '',
            liqBonus: '8.5',
            debtCeiling: '',
            liqProtocolFee: '',
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '99',
            asset: 'EURS',
          },
        ],
      },
      cache: {blockNumber: 82718598},
    },
  },
};
