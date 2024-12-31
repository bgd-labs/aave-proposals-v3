import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20241224_AaveV3Gnosis_AaveV3GnosisInstanceUpdates/config.ts',
    force: true,
    author: 'Aave-chan Initiative',
    pools: ['AaveV3Gnosis'],
    title: 'Aave v3 Gnosis Instance Updates',
    shortName: 'AaveV3GnosisInstanceUpdates',
    date: '20241224',
    discussion: 'https://governance.aave.com/t/arfc-aave-v3-gnosis-instance-updates/20334',
    snapshot:
      'https://snapshot.box/#/s:aave.eth/proposal/0x2e93ddd01ba5ec415b0962907b7c65def947d1ed94f1e5b402c5578560b1dddb',
    votingNetwork: 'POLYGON',
  },
  poolOptions: {
    AaveV3Gnosis: {
      configs: {
        COLLATERALS_UPDATE: [
          {
            asset: 'GNO',
            ltv: '',
            liqThreshold: '',
            liqBonus: '',
            debtCeiling: '0',
            liqProtocolFee: '',
          },
        ],
        BORROWS_UPDATE: [
          {
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '10',
            asset: 'EURe',
          },
        ],
        EMODES_UPDATES: [
          {
            eModeCategory: 2,
            ltv: '90',
            liqThreshold: '92.5',
            liqBonus: '2.5',
            label: 'osGNO / GNO',
          },
          {eModeCategory: 3, ltv: '85', liqThreshold: '87.5', liqBonus: '5', label: 'sDAI / EURe'},
        ],
        EMODES_ASSETS: [
          {asset: 'osGNO', eModeCategory: '2', collateral: 'ENABLED', borrowable: 'DISABLED'},
          {asset: 'GNO', eModeCategory: '2', collateral: 'DISABLED', borrowable: 'ENABLED'},
          {asset: 'EURe', eModeCategory: '3', collateral: 'DISABLED', borrowable: 'ENABLED'},
          {asset: 'sDAI', eModeCategory: '3', collateral: 'ENABLED', borrowable: 'DISABLED'},
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'osGNO',
            decimals: 18,
            priceFeed: '0xbE26c8b354208E898EBd88B1576C4df2e216ed30',
            ltv: '0.05',
            liqThreshold: '0.1',
            liqBonus: '7.5',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'DISABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '10',
            supplyCap: '4750',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '50',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '0',
              variableRateSlope2: '0',
            },
            asset: '0xF490c80aAE5f2616d3e3BDa2483E30C4CB21d1A0',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 37692844},
    },
  },
};
