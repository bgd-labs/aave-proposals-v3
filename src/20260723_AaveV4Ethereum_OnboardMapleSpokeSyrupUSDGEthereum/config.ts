import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV4Ethereum'],
    title: 'OnboardMapleSpokeSyrupUSDGEthereum',
    shortName: 'OnboardMapleSpokeSyrupUSDGEthereum',
    date: '20260723',
    author: 'Aave Labs',
    discussion:
      'https://governance.aave.com/t/direct-to-aip-onboard-syrupusdg-on-aave-v4-global-dollar-hub/25281',
    snapshot: 'direct-to-AIP',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {
    AaveV4Ethereum: {
      configs: {
        V4_USECASE_ONBOARD_RESERVE_TO_SPOKE: {
          hubAssetListings: [
            {
              hubLib: 'AaveV4EthereumHubs.PAXOS_HUB',
              hub: 'PAXOS_HUB',
              underlying: 'AaveV4EthereumAssets.USDG_UNDERLYING',
              feeReceiver: '0xB9B0b8616f6Bf6841972a52058132BE08d723155',
              liquidityFee: '2000',
              irStrategy: '0xD7eC225DC053151100A0ef47b94a77AAD9C413b7',
              irData: {
                optimalUsageRatio: {kind: 'literal', value: '9000'},
                baseDrawnRate: {kind: 'literal', value: '0'},
                rateGrowthBeforeOptimal: {kind: 'literal', value: '400'},
                rateGrowthAfterOptimal: {kind: 'literal', value: '3500'},
              },
              tokenization: {
                addCap: '1000000',
                proxyAdminOwner: '0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9',
                name: 'Wrapped Aave Paxos USDG',
                symbol: 'waPaxosUSDG',
              },
            },
            {
              hubLib: 'AaveV4EthereumHubs.PAXOS_HUB',
              hub: 'PAXOS_HUB',
              underlying: '0x87b65C4aAFFA76881f9E96F3e7ED945ddFC3Cd7A',
              feeReceiver: '0xB9B0b8616f6Bf6841972a52058132BE08d723155',
              liquidityFee: '0',
              irStrategy: '0xD7eC225DC053151100A0ef47b94a77AAD9C413b7',
              irData: {
                optimalUsageRatio: {kind: 'literal', value: '9900'},
                baseDrawnRate: {kind: 'literal', value: '0'},
                rateGrowthBeforeOptimal: {kind: 'literal', value: '0'},
                rateGrowthAfterOptimal: {kind: 'literal', value: '0'},
              },
            },
          ],
          listings: [
            {
              spokeLib: '0x774b9655413c34809c1f1b16b654465A89EBE989',
              spoke: '0x774b9655413c34809c1f1b16b654465A89EBE989',
              hub: 'AaveV4EthereumHubs.PAXOS_HUB',
              underlying: 'AaveV4EthereumAssets.USDG_UNDERLYING',
              priceSource: '0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4',
              config: {
                collateralRisk: '0',
                paused: false,
                frozen: false,
                borrowable: true,
                receiveSharesEnabled: true,
              },
              dynamicConfig: {
                collateralFactor: '0',
                maxLiquidationBonus: '10000',
                liquidationFee: '0',
              },
            },
            {
              spokeLib: '0x774b9655413c34809c1f1b16b654465A89EBE989',
              spoke: '0x774b9655413c34809c1f1b16b654465A89EBE989',
              hub: 'AaveV4EthereumHubs.PAXOS_HUB',
              underlying: '0x87b65C4aAFFA76881f9E96F3e7ED945ddFC3Cd7A',
              priceSource: '0x31745e344fc5986c900826940E5ac2C5DC97b4DE',
              config: {
                collateralRisk: '0',
                paused: false,
                frozen: false,
                borrowable: false,
                receiveSharesEnabled: true,
              },
              dynamicConfig: {
                collateralFactor: '9200',
                maxLiquidationBonus: '10400',
                liquidationFee: '1000',
              },
            },
          ],
          updates: [],
          liquidationUpdates: [
            {
              spokeLib: '0x774b9655413c34809c1f1b16b654465A89EBE989',
              spoke: '0x774b9655413c34809c1f1b16b654465A89EBE989',
              targetHealthFactor: {
                kind: 'literal',
                value: '1_027_700_000_000_000_000_000_000_000_000_000_000',
              },
              healthFactorForMaxBonus: {
                kind: 'literal',
                value: '990_000_000_000_000_000_000_000_000_000_000_000',
              },
              liquidationBonusFactor: {kind: 'literal', value: '10_000'},
            },
          ],
          hubSpokeAdditions: [
            {
              hubLib: 'AaveV4EthereumHubs.PAXOS_HUB',
              hub: 'PAXOS_HUB',
              spoke: '0x774b9655413c34809c1f1b16b654465A89EBE989',
              assets: [
                {
                  underlying: 'AaveV4EthereumAssets.USDG_UNDERLYING',
                  addCap: '10000000',
                  drawCap: '9500000',
                  riskPremiumThreshold: '0',
                  active: true,
                  halted: false,
                },
              ],
            },
            {
              hubLib: 'AaveV4EthereumHubs.PAXOS_HUB',
              hub: 'PAXOS_HUB',
              spoke: '0x774b9655413c34809c1f1b16b654465A89EBE989',
              assets: [
                {
                  underlying: '0x87b65C4aAFFA76881f9E96F3e7ED945ddFC3Cd7A',
                  addCap: '10000000',
                  drawCap: '0',
                  riskPremiumThreshold: '0',
                  active: true,
                  halted: false,
                },
              ],
            },
          ],
          pmUpdates: [
            {
              spokeLib: '0x774b9655413c34809c1f1b16b654465A89EBE989',
              spoke: '0x774b9655413c34809c1f1b16b654465A89EBE989',
              positionManager: 'AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER',
              active: true,
            },
            {
              spokeLib: '0x774b9655413c34809c1f1b16b654465A89EBE989',
              spoke: '0x774b9655413c34809c1f1b16b654465A89EBE989',
              positionManager: 'AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER',
              active: true,
            },
            {
              spokeLib: '0x774b9655413c34809c1f1b16b654465A89EBE989',
              spoke: '0x774b9655413c34809c1f1b16b654465A89EBE989',
              positionManager: 'AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER',
              active: true,
            },
            {
              spokeLib: '0x774b9655413c34809c1f1b16b654465A89EBE989',
              spoke: '0x774b9655413c34809c1f1b16b654465A89EBE989',
              positionManager: 'AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY',
              active: true,
            },
          ],
        },
      },
      cache: {blockNumber: 25595817},
    },
  },
};
