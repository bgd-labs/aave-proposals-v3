import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    author: 'Aavechan Initiative @aci',
    pools: ['AaveV3Ethereum'],
    title: 'Onboard syrupUSDC to Aave V3 Core Instance',
    shortName: 'OnboardSyrupUSDCToAaveV3CoreInstance',
    date: '20260421',
    discussion:
      'https://governance.aave.com/t/arfc-onboard-syrupusdc-to-aave-v3-core-instance/22456',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0xf5951af5d6d7d70be998a72c531708db3ff9c46b033e3e27bfd59fb87542d0ea',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {
      configs: {
        EMODES_CREATION: [
          {
            ltv: '90',
            liqThreshold: '92',
            liqBonus: '4',
            label: 'syrupUSDC__USDC__USDT',
            collateralAssets: ['XAUt'],
            borrowableAssets: ['USDC', 'USDT'],
          },
        ],
        ASSET_LISTING: [
          {
            assetSymbol: 'syrupUSDC',
            decimals: 6,
            priceFeed: '0xe4e9d021d3a44e8bc9949690e298c6b41c6ef354',
            ltv: '0',
            liqThreshold: '0',
            liqBonus: '0',
            debtCeiling: '0',
            liqProtocolFee: '10',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'ENABLED',
            borrowableInIsolation: 'DISABLED',
            withSiloedBorrowing: 'DISABLED',
            reserveFactor: '50',
            supplyCap: '200000000',
            borrowCap: '1',
            rateStrategyParams: {
              optimalUtilizationRate: '45',
              baseVariableBorrowRate: '0',
              variableRateSlope1: '10',
              variableRateSlope2: '300',
            },
            asset: '0x80ac24aA929eaF5013f6436cdA2a7ba190f5Cc0b',
            admin: '0xac140648435d03f784879cd789130F22Ef588Fcd',
          },
        ],
      },
      cache: {blockNumber: 24927435},
    },
  },
};
