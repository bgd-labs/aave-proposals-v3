---
title: "GHO Arbitrum Parameter Adjustments"
author: "@karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-gho-arbitrum-parameter-adjustments/18386"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This AIP will adjust several GHO related parameters on Arbitrum.

## Motivation

After increasing the CCIP Facilitator Capacity from 1.0M to 2.5M, the new capacity was filled within 90 minutes.

With better than anticipated liquidity conditions and ARB liquidity mining on Aave Protocol expected to start soon, this publication proposes several parameter increases that are supportive of enabling GHO to grow more freely.

The parameter adjustments presented below are endorsed by Chaos Labs as an Aave DAO Risk Service Provider.

## Specification

This proposal will implement the following parameter adjustments.

| Parameter                    | Current | Proposed |
| ---------------------------- | :-----: | :------: |
| Eth GHO Bridge Limit         |  2.5M   |  20.0M   |
| Arb GHO Facilitator Capacity |  2.5M   |  20.0M   |
| Arb GHO Supply Cap           |  1.0M   |   5.0M   |
| Arb GHO Borrow Cap           |  0.9M   |   4.5M   |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/bcf71845e82572a0d98c1dcb214a7c6028a6a1fd/src/20240722_Multi_IncreaseGHOFacilitatorCapacity/AaveV3Ethereum_IncreaseGHOFacilitatorCapacity_20240722.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/bcf71845e82572a0d98c1dcb214a7c6028a6a1fd/src/20240722_Multi_IncreaseGHOFacilitatorCapacity/AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/bcf71845e82572a0d98c1dcb214a7c6028a6a1fd/src/20240722_Multi_IncreaseGHOFacilitatorCapacity/AaveV3Ethereum_IncreaseGHOFacilitatorCapacity_20240722.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/bcf71845e82572a0d98c1dcb214a7c6028a6a1fd/src/20240722_Multi_IncreaseGHOFacilitatorCapacity/AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722.t.sol), [E2E](https://github.com/bgd-labs/aave-proposals-v3/blob/bcf71845e82572a0d98c1dcb214a7c6028a6a1fd/src/20240722_Multi_IncreaseGHOFacilitatorCapacity/AaveV3E2e_IncreaseGHOFacilitatorCapacity_20240722.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-gho-arbitrum-parameter-adjustments/18386)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
