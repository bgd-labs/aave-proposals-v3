---
title: "Gho Borrow Rate Update September 2024"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-gho-stewards-gho-parameter-adjustments/17289/32"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This AIP aims to decrease the GHO borrow rate from its current level to 4.25% to enhance its competitiveness in the current market conditions.

## Motivation

The DeFi landscape is constantly evolving, and stablecoin protocols must adapt to remain competitive. Recent market analysis indicates:

- A general decrease in borrowing demand for stablecoins across DeFi platforms.
- Competing stablecoins offering more attractive rates, potentially drawing users away from GHO.
- An opportunity to increase GHO's market share by offering more competitive rates.

By reducing the borrow rate, we aim to:

- Increase the attractiveness of GHO for borrowers
- Stimulate the growth of GHO's total supply
- Enhance GHO's position in the stablecoin market

## Specification

The GHO borrow rate is to be revised as follows:

| Description | Current | Proposed | Reduction |
| ----------- | ------- | -------- | --------- |
| Borrow Rate | 5.00%   | 4.25%    | 0.75%     |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/0a6aaa91659019ea1b6b025bbf1b4315fdd65d45/src/20240912_AaveV3Ethereum_GhoBorrowRateUpdateSeptember2024/AaveV3Ethereum_GhoBorrowRateUpdateSeptember2024_20240912.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/0a6aaa91659019ea1b6b025bbf1b4315fdd65d45/src/20240912_AaveV3Ethereum_GhoBorrowRateUpdateSeptember2024/AaveV3Ethereum_GhoBorrowRateUpdateSeptember2024_20240912.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-gho-stewards-gho-parameter-adjustments/17289/32)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
