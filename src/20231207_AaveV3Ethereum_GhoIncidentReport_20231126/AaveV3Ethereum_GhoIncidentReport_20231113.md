---
title: "GHO update on Aave V3 Ethereum Pool for 13/11/2023 Report"
author: "Aave Labs @aave"
discussions: "https://governance.aave.com/t/arfc-gho-technical-incident-13-11-2023/15642"
---

## Simple Summary

This proposal patches the GHO integration with the Aave V3 Pool, fixing an issue reported by Immunefi on November 13, 2023. The patch, developed by Aave Labs in collaboration with Certora, upholds the highest safety standards.

## Motivation

The proposed patch guarantees a permanent solution for the technical issue that was identified and reported by Immunefi with the GHO integration with the Aave V3 Ethereum Pool. The fix will be implemented without altering any of the existing GHO features within the Aave V3 Pool.

## Specification

The proposal payload upgrades the implementation of GhoVariableDebtToken.

## References

- GhoVariableDebtToken implementation: [GhoVariableDebtToken](https://etherscan.io/address/0x20cb2f303ede313e2cc44549ad8653a5e8c0050e#code)
- Implementation: [Payload]()
- [Discussion](https://governance.aave.com/t/arfc-gho-technical-incident-13-11-2023/15642)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
