---
title: "Prime Instance - wstETH Borrow Rate + rsETH Supply Cap Update"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-prime-instance-wsteth-borrow-rate-rseth-supply-cap-update/20644"
snapshot: "https://snapshot.org/#/s:aave.eth/proposal/0xfc21203137ea8753ab8903fe4edd568bcaa7ea084586a7acb2c3b361d3dae9c8"
---

## Simple Summary

This publication proposes reducing the wstETH Slope1 and increasing the rsETH Supply Cap.

## Motivation

The Prime instance of Aave v3 on Ethereum has experienced significant growth since its launch in Q3 2024, attracting over $2 billion in user deposits.

To support continued growth, this proposal suggests lowering the wstETH Slope1 parameter to align the borrow rate with market conditions. Based on feedback from the Renzo and Kelp teams, this adjustment is expected to drive an additional $300 million in user deposits to the Prime instance.

Expected Benefits of Reducing the Slope1 Parameter:

- ~72% increase in LRT deposits.
- ~50% increase in the wstETH Deposit Rate to 60 bps.
- ~50% increase in wstETH Borrow Rate fee generation.
- ~35% increase in the native wETH Deposit Rate.

Lowering the Slope1 parameter will encourage new LRT deposits, boosting the LRT/LST yield-generating strategy, which is projected to outperform the LST/wETH strategy. With LRT deposit incentives, this strategy further enhances Prime’s appeal.

As utilisation of wETH reserves across Core, Spark, and Prime approaches Uoptimal, the Prime instance of Aave v3 offers the highest native yield for LST/wETH yield strategies. The improved wstETH deposit rate solidifies Prime’s competitive position in the market.

### rsETH Supply Cap

rsETH has shown strong growth on the Core instance of Aave v3, while the Prime market has yet to attract rsETH deposits due to the lower wstETH Borrow Rate on Core and a small supply cap.

Lowering the wstETH Borrow Rate on Prime would make borrowing wstETH more attractive. Feedback from the Kelp team suggests strong demand for rsETH beyond the current supply cap’s capacity.

To support leveraged LRT/LST yield strategies, this proposal recommends a significant increase to the rsETH supply cap, enabling larger deposits to scale effectively, optimize returns, and reduce reliance on incentives.

## Specification

#### wstETH Reserve

| Parameter | Current Value | Proposed Value |
| --------- | ------------- | -------------- |
| Uoptimal  | 90.00%        | 90.00%         |
| Base      | 0.00%         | 0.00%          |
| Slope1    | 1.75%         | 0.75%          |
| Slope2    | 85.00%        | 85.00%         |

#### rsETH Supply Cap

| Parameter  | Current Value | Proposed Value |
| ---------- | ------------- | -------------- |
| Supply Cap | 10,000        | 65,000         |

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/ad47735f95ca24d2b65d7ffaca0b0a05f7397121/src/20250122_AaveV3EthereumLido_PrimeInstanceWstETHBorrowRateRsETHSupplyCapUpdate/AaveV3EthereumLido_PrimeInstanceWstETHBorrowRateRsETHSupplyCapUpdate_20250122.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/ad47735f95ca24d2b65d7ffaca0b0a05f7397121/src/20250122_AaveV3EthereumLido_PrimeInstanceWstETHBorrowRateRsETHSupplyCapUpdate/AaveV3EthereumLido_PrimeInstanceWstETHBorrowRateRsETHSupplyCapUpdate_20250122.t.sol)
- [Snapshot](https://snapshot.org/#/s:aave.eth/proposal/0xfc21203137ea8753ab8903fe4edd568bcaa7ea084586a7acb2c3b361d3dae9c8)
- [Discussion](https://governance.aave.com/t/arfc-prime-instance-wsteth-borrow-rate-rseth-supply-cap-update/20644)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
