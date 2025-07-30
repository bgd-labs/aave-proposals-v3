---
title: "Interest Rate Update - WETH and wstETH Ethereum"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/risk-stewards-interest-rate-update-weth-and-wsteth-ethereum/22625"
---

## Simple Summary

This publication proposes updating the WETH and wstETH Interest Rate configuration on both Core and Prime instances of Aave v3 on Ethereum.

## Motivation

With significant demand for ETH across both Core and Prime, and wstETH on Prime instances of Aave v3 on Ethereum, this publication proposes several parameter adjustments with the goal on improving capital efficiency and revenue generation.

### Prime Instance

#### wstETH

Increasing the Uoptimal from 90% to 93% enables a greater portion of the liquidity in the Reserve to be borrowed at more stable borrow rates. Increasing the Uoptimal, improves overall capital efficiency resulting in a higher deposit rate and more revenue generation for the DAO. With significant demand for wstETH on Prime, any additional liquidity is expected to be quickly consumed.

With a Uoptimal of 93% and utilisation at 92%, ETH deposits into the wstETH reserve earn 3.18% APY, comprised of 0.48% from Aave Protocol and 2.70% from the Lido wstETH Index Rate

#### wETH

Earlier this week we requested the Risk Oracle be increased to reflect the continued higher wstETH deposit rate since listing tETH.

The Prime instance consistently offers a higher wETH deposit yield relative to Core instance. By increasing the WETH Slope1 and Uoptimal, the Reserve Factor can be increased from 10% to 15%, enabling the DAO to benefit from $0.47M/year in new revenue whilst users benefit from a slightly higher wETH deposit rate.

The result, the wstETH/wETH yield strategy generates superior returns to other liquidity protocols, wETH deposits earn a slightly higher deposit yield and the Aave DAO earns an additional $0.47M/year ($3,500/ETH) in revenue.

### Core Instances

#### wETH

Similarly, on the Core, WETH utilisation is consistently high and a 2% increase in the Uoptimal allows for $184M of WETH to be borrowed at the time of writing. Whilst temporary adjustments (93% Uoptimal) have been implemented, this publication proposes reverting to 92% instead of 90%.

With the wETH RF configured to 15%, the resulting revenue increase from increasing the RF from 90% to 92% on Core instance is estimated to be $0.50M per year ($3,500/ETH).

#### wstETH

With the wstETH deposit yield higher on Prime, yet users are not migrating from Prime to Core, or other liquidity protocols, to Prime. To encourage further growth on Core instance, we propose reducing the wstETH borrow rate and increasing the RF from 5% to 35%.

Reducing Slope1 from 1.60% to 1.00%, enables an additional 143.4k of wstETH to be borrowed before the borrow rate returns to its current level. Using the newly proposed parameters, at 31% utilisation, the deposit rate and borrow rate will be the same as currently shown on Core.

This is expected to result in some migrations from Prime to Core which then enables tETH to continue growing, and also potentially, some new demand emerging Core. If the market adjust such that the borrow rate reverts back to the current borrow rate on Core and Prime, the Aave DAO is expected to generate an additional $2.29M in annual revenue from Core.

### General wETH and wstETH Slope2 Updates

The wstETH and WETH borrow rate volatility directly impacts borrowers and strategies sensitive to rate changes, especially LSTs, LRTs and tETH. These yield generating strategies represent a significant portion of collateral currently backing WETH and wstETH borrow positions.

To reduce the prospect of volatility, the Slope2 parameter for WETH and wstETH on both Core and Prime instances is to be reduced to 40% on Ethereum.

## Specification

This AIP will only update the parameters that couldn't be handled (in a timely manners) by the Risk Steward.

**Core Instance - wstETH Reserve**

The below details the initial adjustment to the wstETH reserve on Core instance.

| Parameter        | CurrentValue | Proposed Value |
| ---------------- | ------------ | -------------- |
| Variable Slope 1 | 1.60%        | 1.00%          |
| Variable Slope 2 | 85.00%       | 40.00%         |
| Reserve Factor   | 5.00%        | 35.00%         |

**Prime Instance - wstETH Reserve**

The below details the initial adjustment to the wstETH reserve on Prime instance.

| Parameter        | CurrentValue | Proposed Value |
| ---------------- | ------------ | -------------- |
| Variable Slope 2 | 85.00%       | 40.00%         |

**Prime Instance - wETH Reserve**

| Parameter      | CurrentValue | Proposed Value |
| -------------- | ------------ | -------------- |
| Reserve Factor | 10.00%       | 15.00%         |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250721_Multi_InterestRateUpdateWETHAndWstETHEthereum/AaveV3Ethereum_InterestRateUpdateWETHAndWstETHEthereum_20250721.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250721_Multi_InterestRateUpdateWETHAndWstETHEthereum/AaveV3EthereumLido_InterestRateUpdateWETHAndWstETHEthereum_20250721.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250721_Multi_InterestRateUpdateWETHAndWstETHEthereum/AaveV3Ethereum_InterestRateUpdateWETHAndWstETHEthereum_20250721.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250721_Multi_InterestRateUpdateWETHAndWstETHEthereum/AaveV3EthereumLido_InterestRateUpdateWETHAndWstETHEthereum_20250721.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/risk-stewards-interest-rate-update-weth-and-wsteth-ethereum/22625)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
