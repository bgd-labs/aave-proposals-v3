import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Plasma'],
    title: 'Launch GHO on Plasma & Set ACI as Emissions Manager for Rewards',
    shortName: 'LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards',
    date: '20250930',
    author: '@TokenLogic',
    discussion:
      'https://governance.aave.com/t/arfc-launch-gho-on-plasma-set-aci-as-emissions-manager-for-rewards/22994/6',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0xeb3572580924976867073ad9c8012cb9e52093c76dafebd7d3aebf318f2576fb',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 23733737}},
    AaveV3Plasma: {
      configs: {
        ASSET_LISTING: [
          {
            assetSymbol: 'GHO',
            decimals: 18,
            priceFeed: '0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '0',
            enabledToBorrow: 'ENABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '10',
            supplyCap: '5000000',
            borrowCap: '4500000',
            rateStrategyParams: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '6.5',
              variableRateSlope2: '50',
            },
            asset: '0xb77E872A68C62CfC0dFb02C067Ecc3DA23B4bbf3',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 5352350},
    },
  },
};
