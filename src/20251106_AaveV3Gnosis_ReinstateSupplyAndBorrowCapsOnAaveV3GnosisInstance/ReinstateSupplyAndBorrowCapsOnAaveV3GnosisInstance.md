---
title: "Reinstate Supply and Borrow Caps on Aave V3 Gnosis Instance"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-reinstate-supply-and-borrow-caps-on-aave-v3-gnosis-instance/23373"
---

## Simple Summary

The Gnosis protocol team has communicated its intention to reopen the canonical bridge, prompting us to initiate the governance process to restore the decreased caps. Specifically, we propose to reverse the previously implemented [freeze](https://governance.aave.com/t/chaos-labs-risk-stewards-decrease-supply-caps-on-aave-v3-11-03-25/23349#p-59595-overview-1) of all assets on the Gnosis Chain, restoring the supply and borrow caps to levels that marginally exceed the current supply and borrow balances.

## Motivation

Earlier reductions of the supply and borrow caps on the Gnosis instance were [proposed](https://governance.aave.com/t/chaos-labs-risk-stewards-decrease-supply-caps-on-aave-v3-11-03-25/23349#p-59595-overview-1) as a precautionary measure in response to the Balancer exploit. The pause of the bridge initiated by the Gnosis team aimed to maximize the chances of asset recovery but created a short-lived risk of mispricing.

As the assets effectively became locked within the chain, the efficiency of pricing was at stake, as arbitrageurs were unable to maintain alignment between disjoined markets. This increased the likelihood of out-of-sync DEX prices relative to the oracle feeds used by the Aave instance.

As previously [mentioned](https://governance.aave.com/t/chaos-labs-risk-stewards-decrease-supply-caps-on-aave-v3-11-03-25/23349/2), price deviations between DEX prices on the chain and the oracle feeds could cause some liquidatable positions to be unprofitable for the liquidator, potentially leading to the accrual of bad debt if the price changes were not to revert before the prices converge.

With the Gnosis canonical bridge expected to reopen shortly, arbitrage activity is expected to resume, which should restore price alignment and market efficiency of the network. This proposal is therefore made in advance of the reopening, to ensure that once standard market operations resume, Aave can promptly restore lending activity on the Gnosis network without unnecessary restrictions.

### Proposed Changes

At the time of writing, the supply and borrow caps on a broad list of assets on the Gnosis instance are configured to one. Aiming to restore market dynamics to their pre-bridge-freeze state, we recommend increasing the caps to levels that align with both the risk profile of the instance, lending demand, and available on-chain liquidity.

## Specification

| Instance | Asset  | Initial Supply Cap | Current Supply Cap | Recommended Supply Cap | Initial Borrow Cap | Current Borrow Cap | Recommended Borrow Cap |
| -------- | ------ | ------------------ | ------------------ | ---------------------- | ------------------ | ------------------ | ---------------------- |
| Gnosis   | wstETH | 12,201             | 1                  | 15,000                 | 94                 | 1                  | 150                    |
| Gnosis   | sDAI   | 17,500,552         | 1                  | 24,000,000             | -                  | 0                  | 1                      |
| Gnosis   | GNO    | 94,532             | 1                  | 140,000                | 15,252             | 1                  | 20,000                 |
| Gnosis   | WETH   | 2,762              | 1                  | 3,600                  | 1,811              | 1                  | 2,400                  |
| Gnosis   | EURe   | 13,537,147         | 27,000,000         | -                      | 12,194,512         | 1                  | 22,500,000             |
| Gnosis   | USDC.e | 7,805,609          | 1                  | 12,000,000             | 6,246,190          | 1                  | 11,000,000             |
| Gnosis   | xDAI   | 3,038,106          | 1                  | 4,000,000              | 2,524,773          | 1                  | 3,700,000              |
| Gnosis   | GHO    | 799,613            | 1                  | 1,500,000              | 689,379            | 1                  | 1,400,000              |

## References

- Implementation: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251106_AaveV3Gnosis_ReinstateSupplyAndBorrowCapsOnAaveV3GnosisInstance/AaveV3Gnosis_ReinstateSupplyAndBorrowCapsOnAaveV3GnosisInstance_20251106.sol)
- Tests: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251106_AaveV3Gnosis_ReinstateSupplyAndBorrowCapsOnAaveV3GnosisInstance/AaveV3Gnosis_ReinstateSupplyAndBorrowCapsOnAaveV3GnosisInstance_20251106.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-reinstate-supply-and-borrow-caps-on-aave-v3-gnosis-instance/23373)
- Snapshot: Direct to AIP

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
