---
title: "Gho Steward Update"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-gho-stewards/16466/11"
---

## Simple Summary

This proposal seeks to update the GHO steward to an more efficient version, allowing more granular control over GHO to increase it’s efficiency

## Motivation

The GHO peg is strong, and supply is growing. As GHO matures, new strategies can now be implemented to make it more liquid, resilient and help it grow larger. For example, a strong GSM is expected to allow larger cap increases, allowing faster growth of the supply. Also, in dynamic markets, tighter control on borrow rates is expected to improve asset efficiency.

## Specification

The upgraded Gho Steward can be found on the [gho-core github](https://github.com/aave/gho-core/blob/main/src/contracts/misc/GhoStewardV2.sol)

Changes:

- GSM fee strategy can now be updated by 50 bps both ways
- GHO Borrow cap can now be updated both ways
- GHO exposure cap can now be updated both ways

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/a39a86866b72f8f8edb187b8ec453fc895faf9c3/src/20240602_AaveV3Ethereum_GhoStewardUpdate/AaveV3Ethereum_GhoStewardUpdate_20240602.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/a39a86866b72f8f8edb187b8ec453fc895faf9c3/src/20240602_AaveV3Ethereum_GhoStewardUpdate/AaveV3Ethereum_GhoStewardUpdate_20240602.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-gho-stewards/16466/11)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
