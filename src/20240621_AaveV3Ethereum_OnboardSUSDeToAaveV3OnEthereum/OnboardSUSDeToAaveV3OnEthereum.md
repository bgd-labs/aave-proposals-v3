---
title: "Onboard sUSDe to Aave V3 on Ethereum"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-susde-to-aave-v3-on-ethereum/17191"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x9c6dcf2af7d79467f34e52b505c25d5e4c89af77f00396307d42fc4816797cd9"
---

## Simple Summary

This is an ARFC to seek approval for the addition of sUSDe to Aave V3 on Ethereum, following the consensus reached in the [TEMP CHECK](https://snapshot.org/#/aave.eth/proposal/0x3263dbee34f5afe513a1a6c5bcd5207684cee03473e1b3d7616993dbd87ab881) and [ARFC](https://snapshot.org/#/aave.eth/proposal/0x9c6dcf2af7d79467f34e52b505c25d5e4c89af77f00396307d42fc4816797cd9) stage.

## Motivation

As discussed in the TEMP CHECK, Ethena's synthetic dollar, USDe, provides a stable crypto-native solution for a cash and carry structured product. The staked version of USDe, sUSDe, earns yield from the protocol and has high potential for strong collateral demand.

## Specification

Amendment: opposed to the initial snapshot the aip enables flashloaning to stay consistent with other assets on the network.

The table below illustrates the configured risk parameters for **sUSDe**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                   DISABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (sUSDe)                 |                                 85,000,000 |
| Borrow Cap (sUSDe)                 |                                          0 |
| Debt Ceiling                       |                             USD 40,000,000 |
| LTV                                |                                       72 % |
| LT                                 |                                       75 % |
| Liquidation Bonus                  |                                      8.5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       20 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        0 % |
| Variable Slope 2                   |                                        0 % |
| Uoptimal                           |                                       90 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        0 % |
| Stable Slope2                      |                                        0 % |
| Base Stable Rate Offset            |                                        0 % |
| Stable Rate Excess Offset          |                                        0 % |
| Optimal Stable To Total Debt Ratio |                                        0 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0xb37aE8aBa6C0C1Bf2c509fc06E11aa4AF29B665A |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240621_AaveV3Ethereum_OnboardSUSDeToAaveV3OnEthereum/AaveV3Ethereum_OnboardSUSDeToAaveV3OnEthereum_20240621.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240621_AaveV3Ethereum_OnboardSUSDeToAaveV3OnEthereum/AaveV3Ethereum_OnboardSUSDeToAaveV3OnEthereum_20240621.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x9c6dcf2af7d79467f34e52b505c25d5e4c89af77f00396307d42fc4816797cd9)
- [Discussion](https://governance.aave.com/t/arfc-onboard-susde-to-aave-v3-on-ethereum/17191)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
