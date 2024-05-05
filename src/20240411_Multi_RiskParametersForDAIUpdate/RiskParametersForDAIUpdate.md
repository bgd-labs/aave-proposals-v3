---
title: "Risk Parameters for DAI Update"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-risk-parameters-for-dai-update/17211"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x9f024edf6b8ebe1177503fbed3ceb6b5847cc0cae0e9269132c39b223db30023"
---

## Simple Summary

This proposal aims to update the risk parameters for the DAI stablecoin across all Aave deployments.

## Motivation

MakerDAO’s recent aggressive actions with their D3M program have resulted in a significant increase in the “D3M” credit line for DAI, growing from 0 to predicted 600 million DAI within less than a month. With the potential extension of this credit line to 1 billion DAI in the near term, the unpredictability of future governance decisions by MakerDAO raises concerns regarding the inherent risk nature of DAI as collateral.

These liquidity injections are done in a non-battle-tested protocol with a “hands off” risk management ethos and no safety module risk mitigation feature.

The Aave protocol had previous experience of the consequences of reckless minting policies at a much smaller scale, with Angle’s AgEUR (now EURA) mint into EULER a week before their hack and jEUR minting into Midas leading to the asset long-term depeg.

Given that only a fraction of DAI deposits are currently utilized as collateral on Aave, and users have ample liquidity to switch to USDC or USDT as alternative collateral options, this proposal aims to mitigate potential risks without significantly negatively impacting our user base.

## Specification

**Decrease DAI and sDAI LTV by 12 Percentage Points, LT 1 Percentage Point Per 100M Deployed:**

Based on the details outlined in this [post ](https://governance.aave.com/t/generalized-lt-ltv-reduction-on-aave/16766), there is a planned gradual reduction in the LTV ratios for DAI and sDAI on Aave V3, transitioning from 77% to 75%, accompanied by a decrease in the LT from 80% to 78% across most chains. Considering these anticipated adjustments and the maximum implied percentage of total DAI backing by (s)USDe at 12%, we conservatively recommend a linear reduction of an additional 12 percentage points in LTV. Regarding the LT, we suggest a conditional decrease of 1 percentage point for every 100M in D3M exposure, with a maximum reduction of 6 percentage points, assuming the full 600M is deployed. LT reductions naturally come with potentially induced liquidations, thus if the amount liquidated due to LT changes is deemed too large, we will modify accordingly. This process will begin with a 1% reduction from the current value to account for the initial 100M, once the initial expected decrease has been completed.

**Given current inconsistencies in DAI LTs across the different chains, we will aim to align the LTs and LTVs in the first stage of this proposal. This means that in instances where the LT is currently set higher, the initial reduction would be more than the 1% suggested above. This standardization will be carefully planned to minimize the impact of LT reductions on the likelihood of liquidations.**

### Implemented changes

| Chain        | Asset | Current Expected LTV | Recommended LTV | Current Expected LT | Recommended LT (1st stage) | Recommended LT (Last Stage) |
| ------------ | ----- | -------------------- | --------------- | ------------------- | -------------------------- | --------------------------- |
| V3 Ethereum  | DAI   | 76%                  | 63%             | 79%                 | 77%                        | 72%                         |
| V3 Arbitrum  | DAI   | 76%                  | 63%             | 79%                 | 77%                        | 72%                         |
| V3 Optimism  | DAI   | 75%                  | 63%             | 80%                 | 77%                        | 72%                         |
| V3 Polygon   | DAI   | 76%                  | 63%             | 79%                 | 77%                        | 72%                         |
| V3 Gnosis    | WXDAI | 76%                  | 63%             | 79%                 | 77%                        | 72%                         |
| V3 Avalanche | DAI.e | 75%                  | 63%             | 80%                 | 77%                        | 72%                         |
| V3 Metis     | m.DAI | 75%                  | 63%             | 80%                 | 77%                        | 72%                         |
| V3 Ethereum  | sDAI  | 76%                  | 63%             | 79%                 | 77%                        | 72%                         |
| V3 Gnosis    | sDAI  | 76%                  | 63%             | 79%                 | 77%                        | 72%                         |
| V2 Ethereum  | DAI   | 75%                  | 63%             | 87%                 | 77%                        | 72%                         |
| V2 Polygon   | DAI   | 75%                  | 63%             | 80%                 | 77%                        | 72%                         |
| V2 Avalanche | DAI   | 75%                  | 63%             | 80%                 | 77%                        | 72%                         |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV2Ethereum_RiskParametersForDAIUpdate_20240411.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV2Polygon_RiskParametersForDAIUpdate_20240411.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV2Avalanche_RiskParametersForDAIUpdate_20240411.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV3Ethereum_RiskParametersForDAIUpdate_20240411.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV3Polygon_RiskParametersForDAIUpdate_20240411.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV3Avalanche_RiskParametersForDAIUpdate_20240411.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV3Optimism_RiskParametersForDAIUpdate_20240411.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV3Arbitrum_RiskParametersForDAIUpdate_20240411.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV3Metis_RiskParametersForDAIUpdate_20240411.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV3Gnosis_RiskParametersForDAIUpdate_20240411.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV2Ethereum_RiskParametersForDAIUpdate_20240411.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV2Polygon_RiskParametersForDAIUpdate_20240411.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV2Avalanche_RiskParametersForDAIUpdate_20240411.t.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV3Ethereum_RiskParametersForDAIUpdate_20240411.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV3Polygon_RiskParametersForDAIUpdate_20240411.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV3Avalanche_RiskParametersForDAIUpdate_20240411.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV3Optimism_RiskParametersForDAIUpdate_20240411.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV3Arbitrum_RiskParametersForDAIUpdate_20240411.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV3Metis_RiskParametersForDAIUpdate_20240411.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/f41d6806803535a87d7020c311ee7670e638e9de/src/20240411_Multi_RiskParametersForDAIUpdate/AaveV3Gnosis_RiskParametersForDAIUpdate_20240411.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x9f024edf6b8ebe1177503fbed3ceb6b5847cc0cae0e9269132c39b223db30023)
- [Discussion](https://governance.aave.com/t/arfc-risk-parameters-for-dai-update/17211)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
