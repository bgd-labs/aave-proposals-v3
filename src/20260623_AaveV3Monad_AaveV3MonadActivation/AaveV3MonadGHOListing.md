---
title: "Aave V3 Monad GHO Listing"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-protocol-on-monad/24943"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6"
---

## Simple Summary

This proposal lists GHO on the Aave V3 Monad pool and adds it as a borrowable asset to the Maple_syrupUSDC and Liquid_Leverage eModes, following the parameters recommended by the Risk Service Providers engaged with the DAO on the governance forum. It is a follow-up to the Aave V3 Monad Activation proposal and must be executed after it.

## Motivation

GHO is listed on its own governance track, decoupled from the main Monad activation, so it goes live once the market and its eModes already exist. The Maple_syrupUSDC and Liquid_Leverage eModes are created by the Aave V3 Monad Activation proposal; this proposal adds GHO to them as a borrowable.

## Specification

The proposal will do the following:

- List GHO on Aave V3 Monad.
- Add GHO as a borrowable asset to the Maple_syrupUSDC and Liquid_Leverage eModes.

The table below illustrates the configured risk parameters for **GHO**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (GHO)          |                                 20,000,000 |
| Borrow Cap (GHO)          |                                 18,000,000 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                        5 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        4 % |
| Variable Slope 2          |                                       40 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Oracle                    | 0x26cBccD96502D2EfDb612737bD6aECe19f65109c |

## References

- Implementation: [AaveV3Monad GHO Listing](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3Monad_AaveV3MonadGHOListing_20260623.sol)
- Discussion: [Governance forum](https://governance.aave.com/t/arfc-deploy-aave-protocol-on-monad/24943)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
