---
title: "[AIP] Arbitrum - GHO Stewards & Parameter Adjustments"
author: "@karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-gho-arbitrum-parameter-adjustments/18386"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This AIP will activate the GHO Steward and adjust several GHO related parameters on Arbitrum.

## Motivation

After increasing the CCIP Facilitator Capacity from 1.0M to 2.5M, the new capacity was filled within 90 minutes.

With better than anticipated liquidity conditions and ARB liquidity mining on Aave Protocol expected to start soon, this publication proposes several parameter increases that are supportive of enabling GHO to grow more freely.

The parameter adjustments presented below are endorsed by Chaos Labs as an Aave DAO Risk Service Provider.

This AIP will also active the GHO Stewards on Arbitrum to facilitate further streamlining GHO's growth.

## Specification

This proposal will implement the following parameter adjustments.

| Parameter                    | Current | Proposed |
| ---------------------------- | :-----: | :------: |
| Eth GHO Bucket Capacity      |  2.5M   |  20.0M   |
| Arb GHO Facilitator Capacity |  2.5M   |  20.0M   |
| Arb GHO Supply Cap           |  1.0M   |   5.0M   |
| Arb GHO Borrow Cap           |  0.9M   |   4.5M   |

The GHO Steward admin role has the permission to adjust the following parameters.

**Bridge Facilitator and CCIP Rates**
On Ethereum:

1. `CCIP BridgeLimitAdmin` role to adjust the bridge limit up to 100% both ways
2. `CCIP RateLimitAdmin` role to adjust the `TokenPool Rate Limit` by 100% both ways, and the `TokenPool Rate Limit Refill Rate` by 100% both ways
3. `Facilitator Borrow Capacity` can be updated by up to 100% both ways
4. `Facilitator Bucket Capacity` can be updated by up to 100% both ways

On Arbitrum:

1. `CCIP BucketCapacityManager` role to adjust the facilitator bucket capacity by 100% both ways
2. `CCIP RateLimitAdmin` role to adjust the `TokenPool Rate Limit` by 100% both ways, and the `TokenPool Rate Limit Refill Rate` by 100% both ways

GHO Steward Arbitrum SAFE: `0x8513e6F37dBc52De87b166980Fa3F50639694B60`

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240722_Multi_IncreaseGHOFacilitatorCapacity/AaveV3Ethereum_IncreaseGHOFacilitatorCapacity_20240722.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240722_Multi_IncreaseGHOFacilitatorCapacity/AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240722_Multi_IncreaseGHOFacilitatorCapacity/AaveV3Ethereum_IncreaseGHOFacilitatorCapacity_20240722.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240722_Multi_IncreaseGHOFacilitatorCapacity/AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722.t.sol), [E2E](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240722_Multi_IncreaseGHOFacilitatorCapacity/AaveV3E2e_IncreaseGHOFacilitatorCapacity_20240722.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-gho-arbitrum-parameter-adjustments/18386)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
