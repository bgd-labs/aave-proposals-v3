---
title: "Increase Borrow caps for wstETH on the Lido Market"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-increase-borrow-caps-for-wsteth-on-the-lido-market-10-20-24/19539"
snapshot: "Direct-to-AIP"
---

## Simple Summary

In this proposal, Chaos Labs recommends increasing the borrow cap for wstETH in the Aave V3 Lido market deployment.

## Motivation

[quote="ChaosLabs, post:1, topic:19539"]
With the upcoming [listing of ezETH ](https://governance.aave.com/t/arfc-onboard-ezeth-to-aave-v3-lido-instance/18504/11) in the Aave V3 Ethereum Lido market and the introduction of an ezETH/wstETH E-Mode, Chaos Labs anticipates that ezETH’s primary use case will be as collateral for borrowing wstETH to leverage ezETH’s yield.

Though wstETH is a yield-bearing asset and typically not heavily borrowed, the current implied Pendle yield of 5.2% and underlying yield of 4.3% for ezETH make borrowing wstETH an attractive option. When the combined yield of wstETH and its borrowing cost is lower than ezETH’s overall implied yield, wstETH becomes a favorable asset to borrow for those seeking to effectively leverage ezETH’s yields.

_The chart shows the ezETH implied yield in blue and the ezETH underlying yield in green._
_Source: ezETH Ethereum on pendle.finance_

### Looping

The current low borrow cap for wstETH in the Lido market deployment is largely utilized by users looping wstETH to farm supply incentives. This strategy is only viable if wstETH borrow demand remains low enough to keep the borrow rate below the incentive APY of 0.46%.

With the listing of ezETH and anticipated increased demand for wstETH borrowing, it’s unlikely that the borrow APY for wstETH will remain low enough to make looping viable. Hence, we do not expect looping to represent a significant portion of the market.

### Recommendation

While a larger borrowing buffer is beneficial in a looping market, the current wstETH supply of 120,000 provides ample available supply for borrowing without risking illiquidity.

Therefore, Chaos Labs recommends setting the borrow cap for wstETH at 14,000 to align with the LTV of ezETH, based on its [recommendation ](https://governance.aave.com/t/arfc-onboard-ezeth-to-aave-v3-lido-instance/18504/11) for an initial supply cap. This value is derived from the proposed ezETH supply cap of 15,000 and its 93% LTV.

This borrow cap update should be implemented alongside the [ezETH listing ](https://governance.aave.com/t/arfc-onboard-ezeth-to-aave-v3-lido-instance/18504/11) and its new liquid E-mode categories.

## Specification

| Chain                | Asset  | Current Supply Cap | Recommended Supply Cap | Current Borrow Cap | Recommended Borrow Cap |
| -------------------- | ------ | ------------------ | ---------------------- | ------------------ | ---------------------- |
| Ethereum Lido Market | wstETH | 650,000            | -                      | 100                | 14,000                 |

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241021_AaveV3EthereumLido_IncreaseBorrowCapsForWstETHOnTheLidoMarket/AaveV3EthereumLido_IncreaseBorrowCapsForWstETHOnTheLidoMarket_20241021.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241021_AaveV3EthereumLido_IncreaseBorrowCapsForWstETHOnTheLidoMarket/AaveV3EthereumLido_IncreaseBorrowCapsForWstETHOnTheLidoMarket_20241021.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-increase-borrow-caps-for-wsteth-on-the-lido-market-10-20-24/19539)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
