---
title: "Aave V3.6 MegaETH Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-v3-to-megaeth/23517"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0xab1d9c42264c89e1b8f0d807c9ff971f8c3f9f5cc0323072d9e970c110d1e39b"
---

## Simple Summary

## Motivation

## Specification

| Parameter                 |     WETH |     BTCb |      USDT0 |       USDm |   wstETH |   wrsETH |    ezETH |
| ------------------------- | -------: | -------: | ---------: | ---------: | -------: | -------: | -------: |
| Supply Cap                |   50,000 |      120 | 50,000,000 | 50,000,000 |   12,000 |   10,000 |   10,000 |
| Borrow Cap                |   46,000 |        1 | 46,000,000 | 46,000,000 |        1 |        1 |        1 |
| Borrowable                | DISABLED | DISABLED |    ENABLED |    ENABLED | DISABLED | DISABLED | DISABLED |
| Collateral Enabled        |     true |     true |       true |       true |     true |     true |     true |
| LTV                       |      0 % |      0 % |        0 % |        0 % |      0 % |      0 % |      0 % |
| LT                        |      0 % |      0 % |        0 % |        0 % |      0 % |      0 % |      0 % |
| Liquidation Bonus         |      0 % |      0 % |        0 % |        0 % |      0 % |      0 % |      0 % |
| Liquidation Protocol Fee  |     10 % |     10 % |       10 % |       10 % |     10 % |     10 % |     10 % |
| Debt Ceiling              |    USD 0 |    USD 0 |      USD 0 |      USD 0 |    USD 0 |    USD 0 |    USD 0 |
| Isolation Mode            |    false |    false |      false |      false |    false |    false |    false |
| Reserve Factor            |     15 % |     20 % |       10 % |       10 % |     20 % |     20 % |     20 % |
| Uoptimal                  |     90 % |     90 % |       90 % |       90 % |     90 % |     90 % |     90 % |
| Base Variable Borrow Rate |      0 % |      0 % |        0 % |        0 % |      0 % |      0 % |      0 % |
| Variable Slope 1          |    2.5 % |      5 % |        5 % |        5 % |      5 % |      5 % |      5 % |
| Variable Slope 2          |      8 % |     20 % |       10 % |       10 % |     20 % |     20 % |     20 % |
| Flashloanable             |  ENABLED |  ENABLED |    ENABLED |    ENABLED |  ENABLED |  ENABLED |  ENABLED |
| Siloed Borrowing          | DISABLED | DISABLED |   DISABLED |   DISABLED | DISABLED | DISABLED | DISABLED |
| Borrowable in Isolation   | DISABLED | DISABLED |    ENABLED |    ENABLED | DISABLED | DISABLED | DISABLED |

## References

- Implementation: [AaveV3MegaEth](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260128_AaveV3MegaEth_AaveV36MegaETHActivation/AaveV3MegaEth_AaveV36MegaETHActivation_20260128.sol)
- Tests: [AaveV3MegaEth](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260128_AaveV3MegaEth_AaveV36MegaETHActivation/AaveV3MegaEth_AaveV36MegaETHActivation_20260128.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0xab1d9c42264c89e1b8f0d807c9ff971f8c3f9f5cc0323072d9e970c110d1e39b)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-v3-to-megaeth/23517)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
