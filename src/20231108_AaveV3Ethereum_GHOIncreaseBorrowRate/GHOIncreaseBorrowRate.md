---
title: "GHO - Increase Borrow Rate"
author: "@Marczeller - ACI"
discussions: "https://governance.aave.com/t/arfc-gho-increase-borrow-rate/15271"
---

## Simple Summary

This publication proposes increasing the GHO Borrow Rate from 3.00% to 4.72%, slightly below the proposed sDAI rate.

## Motivation

By increasing the borrow rate to 4.72%, the goal is to improve the peg by reducing the incentive to mint GHO relative to other stable coins. As a result, GHO's growth is expected to slow. This publication prioritises returning GHO to peg over growth.

After implementing this proposal, the community can continue with the current plan, direct-to-AIP process for 50 bps increments every 30 days, as long as the GHO peg is outside 0,995<>1,005 monthly average price range, up to 5.5% borrow rate.

## Specification

Asset: GHO
Contract Address: 0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f
Current Borrow Rate: 3.00%
Proposed Borrow Rate: 4.72%
New discounted Borrow Rate: ~3.31%

The discount for stkAave holders remains unchanged at 30%.
The Aave Facilitator Bucket Level is to remain at 35.00M units

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/72cad7a3c51b067f567c73524f73e8d0dbf22cb6/src/20231108_AaveV3Ethereum_GHOIncreaseBorrowRate/AaveV3Ethereum_GHOIncreaseBorrowRate_20231108.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/72cad7a3c51b067f567c73524f73e8d0dbf22cb6/src/20231108_AaveV3Ethereum_GHOIncreaseBorrowRate/AaveV3Ethereum_GHOIncreaseBorrowRate_20231108.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x9789e054e29f63da5713368be2dd0b4006f4564ef5e48c9d5e994ec20e932e35)
- [Discussion](https://governance.aave.com/t/arfc-gho-increase-borrow-rate/15271)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
