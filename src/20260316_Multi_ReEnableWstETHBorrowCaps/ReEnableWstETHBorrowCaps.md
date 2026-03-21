---
title: "Re-enable wstETH borrow caps"
author: "Aavechan Initiative @aci and Chaos Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-re-enable-wsteth-borrow-caps-on-ethereum-core-and-prime-post-capo-incident/24295"
---

## Simple Summary

Following the CAPO oracle configuration incident affecting wstETH on Ethereum Core and Prime, this AIP proposes to restore the wstETH borrow caps to their previous values now that oracle configuration has been realigned.

Proposed caps (restore):

- **Ethereum Core**: wstETH borrow cap to **180,000 wstETH**
- **Ethereum Prime**: wstETH borrow cap to **70,000 wstETH**

## Background

A technical incident affecting the CAPO risk oracle caused the reported wstETH/stETH exchange rate cap to fall below the valid market exchange rate on Ethereum Core and Prime. This created an approximately **2.85% downward deviation** in the effective exchange rate used by the protocol and triggered E-Mode liquidations. The protocol incurred **no bad debt**, but users were impacted.

As an immediate containment measure, the wstETH borrow caps on both instances were temporarily reduced to **1**.

Since then, the configuration has been realigned and the oracle reverted to its true value, enabling the DAO to proceed with reinstating the caps.

## Motivation

The temporary caps were a safety measure to minimize exposure while remediation was underway. With the oracle configuration restored, reinstating the prior caps:

- returns wstETH borrowing capacity to normal operation on both instances,
- reduces disruption for users and integrators that rely on wstETH liquidity,
- aligns protocol parameters with the intended risk posture.

## Specification

This AIP will execute the following parameter updates:

1. **Aave V3 Ethereum Core**
   - Set **wstETH borrow cap** from **1** back to **180,000**.
2. **Aave V3 Ethereum Prime**
   - Set **wstETH borrow cap** from **1** back to **70,000**.

Notes:

- This AIP is scoped to **borrow caps only**.

## Disclaimer

ACI did not receive any compensation for creating this proposal.

### Copyright

Copyright and related rights waived via CC0.

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/43e0633d8f407b6c49b51ce04c64e513f20c1fca/src/20260316_Multi_ReEnableWstETHBorrowCaps/AaveV3Ethereum_ReEnableWstETHBorrowCaps_20260316.sol), [AaveV3EthereumLido](https://github.com/aave-dao/aave-proposals-v3/blob/43e0633d8f407b6c49b51ce04c64e513f20c1fca/src/20260316_Multi_ReEnableWstETHBorrowCaps/AaveV3EthereumLido_ReEnableWstETHBorrowCaps_20260316.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/43e0633d8f407b6c49b51ce04c64e513f20c1fca/src/20260316_Multi_ReEnableWstETHBorrowCaps/AaveV3Ethereum_ReEnableWstETHBorrowCaps_20260316.t.sol), [AaveV3EthereumLido](https://github.com/aave-dao/aave-proposals-v3/blob/43e0633d8f407b6c49b51ce04c64e513f20c1fca/src/20260316_Multi_ReEnableWstETHBorrowCaps/AaveV3EthereumLido_ReEnableWstETHBorrowCaps_20260316.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-re-enable-wsteth-borrow-caps-on-ethereum-core-and-prime-post-capo-incident/24295)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
