---
title: "Update GNO Risk Parameters on Aave V3 Gnosis Pool"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-update-gno-risk-parameters-on-aave-v3-gnosis-pool/15613"
---

## Simple Summary

This AIP proposes to update GNO risk parameters on the Aave V3 Gnosis Pool to enable borrowing, fostering Gnosischain decentralization and use-cases for passive income and staking.

## Motivation

The goal is to enhance GNO utility by allowing it to be a borrowable asset, thereby supporting Gnosischain’s decentralization. This adjustment also prepares for future GNO LSTs and a possible GNO-correlated e-mode, expanding utility and passive income opportunities for GNO holders.

## Specification

The proposed changes aim to make GNO a borrowable asset outside of isolation mode with adjusted risk parameters to accommodate this new functionality:

| Risk Parameter           | Current Value | Proposed Value |
| ------------------------ | ------------- | -------------- |
| Isolation Mode           | Yes           | YES            |
| Borrowable in Isolation  | No            | No             |
| Stable Borrow            | No            | No             |
| Enable Borrow            | No            | Yes            |
| Enable Collateral        | Yes           | Yes            |
| Loan To Value (LTV)      | 31%           | 31%            |
| Liquidation Threshold    | 36%           | 36%            |
| Liquidation Bonus        | 10%           | 10%            |
| Reserve Factor           | N/A           | 20%            |
| Liquidation Protocol Fee | 10%           | 10%            |
| Supply Cap               | 30000 GNO     | 30000 GNO      |
| Borrow Cap               | N/A           | 1100 GNO       |
| Debt Ceiling             | 1M$           | 1M$            |
| uOptimal                 | N/A           | 80%            |
| Base                     | N/A           | 0%             |
| Slope1                   | N/A           | 15%            |
| Slope2                   | N/A           | 80%            |

## References

- Implementation: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/be398376cb2766e09a404142988a4f6d08019b4b/src/20231213_AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool/AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool_20231213.sol)
- Tests: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/be398376cb2766e09a404142988a4f6d08019b4b/src/20231213_AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool/AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool_20231213.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xe35faf498e25ff6a0620b8395c4653b05fe98cb0ccaacb62da140e53097f9ac0)
- [Discussion](https://governance.aave.com/t/arfc-update-gno-risk-parameters-on-aave-v3-gnosis-pool/15613)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
