---
title: "July Funding Update"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-july-funding-update/18447"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This publication proposes swapping assets held in the Treasury for GHO and funding Phase III of the Merit and Ahab programs.

## Motivation

With Phase III of the Merit and Ahab program about to start, August 9th, this publication proposes creating two new Allowances to fund the @ACI led growth programs.

The budget for these programs is the same as the Phase II, 645 ETH, and 3M GHO. The ETH is expected to be claimed and deposited into the Lido's instance of Aave v3 and the GHO claimed periodically ahead of each subsequent Merit rewards round.

In addition, this proposal also swaps approximately 640k of Stablecoin assets held in the Treasury to GHO. In combination with the May Funding Part A and Part B, these swaps are enough to offset the GHO spend of the Merit program.

## Specification

### Merit + Ahab Programs

Create allowances to the Merit and Ahab, 3M GHO and 645 ETH from Aave v3 Ethereum:

SAFE: `0xdeadD8aB03075b7FBA81864202a2f59EE25B312b`

### Runway Updates

Swap the following asset for GHO via the Aave Swapper.

| Withdraw & Swap to GHO |
| :--------------------: |
|    aEthUSDe (All-1)    |
|      aUSDT (0.5M)      |
|     aFRAX (All-1)      |
|    aEthFRAX (All-1)    |
|      aDPI (All-1)      |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240729_AaveV3Ethereum_JulyFundingUpdate/AaveV3Ethereum_JulyFundingUpdate_20240729.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240729_AaveV3Ethereum_JulyFundingUpdate/AaveV3Ethereum_JulyFundingUpdate_20240729.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-july-funding-update/18447)

# Disclosure

TokenLogic and karpatkey receive no payment for this proposal. TokenLogic and karpatkey are both delegates within the Aave community.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
