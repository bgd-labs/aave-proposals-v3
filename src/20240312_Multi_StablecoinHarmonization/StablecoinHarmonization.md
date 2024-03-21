---
title: "stablecoin harmonization"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-stablecoin-harmonization-and-asset-parameters-optimization/16802"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x22407c9362bc3294e3ddd5428fdd5c08312459595573a864ec8ebac61ad95b94"
---

## Simple Summary

This AIP proposes focusing stablecoin collateral usage on USDT and USDC while setting LTV to zero for less-trafficked stablecoins and long-tail assets. The objective is to minimize risk for the protocol, optimize revenue generation, and align with market demand trends.

## Motivation

Aave’s revenue primarily comes from wETH borrowing and stablecoins borrowing. Years of User behavior data in DeFi indicates a low demand for fluctuating assets as collateral except in use-case-specific scenarios (LST/LRT loops for Weth, RPL borrow to deploy mini pools). Based on @ChaosLabs [data ](https://community.chaoslabs.xyz/aave/risk/markets/Ethereum/listed-assets/), only 2.4%, 3.7%, and 5.8% of supplied DAI, USDT, and USDC on Ethereum are being utilized as collateral. We can also note that market demand for alternative stablecoins is less sensitive to borrow rates compared to blue-chip stablecoins like USDT and USDC.

The DAO governance has been lenient in onboarding some collaterals, such as KNC, which currently attracts nearly zero traction (currently used to generate 0.79$ of borrow volume) and generates minimal revenue. Additionally, the asymmetric risk presented by stablecoins, such as during the CRV event (collateral was USDC with very high LT and low LB), highlights the need for optimization considering Risk/reward.

## Specification

The ACI proposes the following strategy shift:

1. Focus on USDT and USDC as primary stablecoin collaterals.
2. Set LTV to zero for alternative stablecoins and long tail assets.
3. Enable a 3%/week LT reduction for these stablecoins assets, providing ample time for users to react and keep them as passive yield sources or borrowable assets that represent 99% of current user demand and most of protocol revenue.
4. Propose the following adjusted standardized ReserveFactor categories for Aave assets:

| Collateral Type                            | Reserve Factor % |
| ------------------------------------------ | ---------------- |
| wETH                                       | 15%              |
| USDC/USDT                                  | 10%              |
| Alternative stablecoins & long tail assets | 20%              |
| DAI                                        | 25%              |

note: except for MAI that is currently 95% RF

5. Fade out as collateral the following stablecoins:

- FRAX
- LUSD
- EURS (except Polygon)
- agEUR
- JEUR
- MAI

6. freeze (if not already), then slowly offboard the following alternative stablecoins and long-tail assets that failed to gain traction by gradually increasing RF to 99.9%, decreasing LT by 3% per week then applying incremental interestRateStrategies incentivizing users to switch to others collaterals or borrowed asset as the DAO implemented for BUSD and TUSD on Aave V2:

| Collateral Type | Network   |
| --------------- | --------- |
| agEUR           | All pools |
| JEUR            | All pools |
| MAI             | All pools |
| KNC             | Ethereum  |
| STG             | Ethereum  |
| FXS             | Ethereum  |
| WBTC.e          | Avalanche |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240312_Multi_StablecoinHarmonization/AaveV3Ethereum_StablecoinHarmonization_20240312.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240312_Multi_StablecoinHarmonization/AaveV3Polygon_StablecoinHarmonization_20240312.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240312_Multi_StablecoinHarmonization/AaveV3Avalanche_StablecoinHarmonization_20240312.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240312_Multi_StablecoinHarmonization/AaveV3Optimism_StablecoinHarmonization_20240312.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240312_Multi_StablecoinHarmonization/AaveV3Arbitrum_StablecoinHarmonization_20240312.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240312_Multi_StablecoinHarmonization/AaveV3Metis_StablecoinHarmonization_20240312.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240312_Multi_StablecoinHarmonization/AaveV3Gnosis_StablecoinHarmonization_20240312.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240312_Multi_StablecoinHarmonization/AaveV3Ethereum_StablecoinHarmonization_20240312.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240312_Multi_StablecoinHarmonization/AaveV3Polygon_StablecoinHarmonization_20240312.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240312_Multi_StablecoinHarmonization/AaveV3Avalanche_StablecoinHarmonization_20240312.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240312_Multi_StablecoinHarmonization/AaveV3Optimism_StablecoinHarmonization_20240312.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240312_Multi_StablecoinHarmonization/AaveV3Arbitrum_StablecoinHarmonization_20240312.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240312_Multi_StablecoinHarmonization/AaveV3Metis_StablecoinHarmonization_20240312.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240312_Multi_StablecoinHarmonization/AaveV3Gnosis_StablecoinHarmonization_20240312.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x22407c9362bc3294e3ddd5428fdd5c08312459595573a864ec8ebac61ad95b94)
- [Discussion](https://governance.aave.com/t/arfc-stablecoin-harmonization-and-asset-parameters-optimization/16802)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
