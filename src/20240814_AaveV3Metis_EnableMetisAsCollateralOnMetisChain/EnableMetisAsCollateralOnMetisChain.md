---
title: "Enable Metis as Collateral on Metis Chain"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-enable-metis-as-collateral-on-metis-chain/16658"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x2e15c7011a6696de1be8fb3476db30395225eb533f849b63bdbff2b33a605ffd"
---

## Simple Summary

This proposal recommends enabling Metis token as collateral on Aave V3 within the Metis Chain

## Motivation

Integrating Metis as collateral positions Aave as a key player in the Metis ecosystem, alongside upcoming incentives for builders and new projects. This move is anticipated to bolster Aave’s prominence as the leading lending platform on Metis Chain.

## Specification

The proposed risk parameters for incorporating Metis as collateral are outlined below following @ChaosLabs TEMP CHECK recommendation:

| Parameter                  | Value  |
| -------------------------- | ------ |
| Isolation Mode             | Yes    |
| Borrowable                 | Yes    |
| Collateral Enabled         | Yes    |
| Debt Ceiling               | $1M    |
| Loan to Value (LTV)        | 30.00% |
| Liquidation Threshold (LT) | 40.00% |
| Liquidation Bonus          | 10.00% |
| Liquidation Protocol Fee   | 10.00% |

## References

- Implementation: [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/7e9aaa019afed78f36b3f87c3c8c1bbc069053a5/src/20240814_AaveV3Metis_EnableMetisAsCollateralOnMetisChain/AaveV3Metis_EnableMetisAsCollateralOnMetisChain_20240814.sol)
- Tests: [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/7e9aaa019afed78f36b3f87c3c8c1bbc069053a5/src/20240814_AaveV3Metis_EnableMetisAsCollateralOnMetisChain/AaveV3Metis_EnableMetisAsCollateralOnMetisChain_20240814.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x2e15c7011a6696de1be8fb3476db30395225eb533f849b63bdbff2b33a605ffd)
- [Discussion](https://governance.aave.com/t/arfc-enable-metis-as-collateral-on-metis-chain/16658)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
