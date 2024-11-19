---
title: "GHO listing on Lido pool"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-mint-deploy-10m-gho-into-aave-v3-lido-instance/19700/3"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **GHO**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (GHO)          |                                  2,000,000 |
| Borrow Cap (GHO)          |                                  2,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       20 % |
| Reserve Factor            |                                        0 % |
| Base Variable Borrow Rate |                                        4 % |
| Variable Slope 1          |                                        0 % |
| Variable Slope 2          |                                        0 % |
| Uoptimal                  |                                      100 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xD110cac5d8682A3b045D5524a9903E031d70FCCd |

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241119_AaveV3EthereumLido_GHOListingOnLidoPool/AaveV3EthereumLido_GHOListingOnLidoPool_20241119.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241119_AaveV3EthereumLido_GHOListingOnLidoPool/AaveV3EthereumLido_GHOListingOnLidoPool_20241119.t.sol)
- [Snapshot](TODO)
- [Discussion](https://governance.aave.com/t/arfc-mint-deploy-10m-gho-into-aave-v3-lido-instance/19700/3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
