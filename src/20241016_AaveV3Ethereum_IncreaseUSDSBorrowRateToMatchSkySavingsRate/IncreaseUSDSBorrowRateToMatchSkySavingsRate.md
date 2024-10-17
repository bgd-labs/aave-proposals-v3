---
title: "Increase USDS Borrow Rate to Match Sky Savings Rate"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-increase-usds-borrow-rate-to-match-sky-savings-rate/19494"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This ARFC proposes a Direct-To-AIP adjustment to the USDS borrow rate on the Aave protocol, increasing it to align with the Sky Savings Rate.

## Motivation

The Sky Savings Rate has recently outpaced the USDS borrow rate on Aave. To correct this and ensure the protocol is directing incentives to true depositors instead of USDS loopers, we propose raising the USDS borrow rate to match the Sky Savings Rate.

## Specification

USDS Borrow Rate will be adjusted as follows on the main market on Ethereum

- Base Variable Rate: 6.25%

All other parameters remain unchanged.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/22dd4067af320e6cdce9b6fcaad937bb41e98472/src/20241016_AaveV3Ethereum_IncreaseUSDSBorrowRateToMatchSkySavingsRate/AaveV3Ethereum_IncreaseUSDSBorrowRateToMatchSkySavingsRate_20241016.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/22dd4067af320e6cdce9b6fcaad937bb41e98472/src/20241016_AaveV3Ethereum_IncreaseUSDSBorrowRateToMatchSkySavingsRate/AaveV3Ethereum_IncreaseUSDSBorrowRateToMatchSkySavingsRate_20241016.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-increase-usds-borrow-rate-to-match-sky-savings-rate/19494)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
