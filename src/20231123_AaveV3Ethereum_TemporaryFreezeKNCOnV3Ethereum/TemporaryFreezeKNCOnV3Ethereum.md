---
title: "Temporary Freeze KNC on V3 Ethereum"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-temporary-freeze-knc-on-v3-ethereum/15654"
---

## Simple Summary

A proposal to freeze KNC on Aave V3 Ethereum market.

## Motivation

On November 22, the KyberSwap DEX experienced a significant security breach, resulting in a loss of nearly $50M in various assets. This incident led the Kyber Network team to advise its users to withdraw their funds as a precaution. Following the hack, KyberSwap's TVL plummeted by 68%, dropping from its peak of $134M in 2023 to $27M. Additionally, the price of the KNC token briefly fell by 7% upon the news breaking but later stabilized and is now trading at ~$0.71

### **Aave Protocol Specifics**

- **KNC on Aave V3 Ethereum:** KNC is currently listed as a collateral asset in isolation mode, with a $1M debt ceiling.
- **Supply Cap:** The supply cap for KNC is set at 1.2M (~$850,000).
- **Borrow Cap:** The borrow cap for KNC is set at 650K (~$460,000).
- **Current State:** As of the time of this post, ~$75,000 worth of KNC has been supplied to the protocol and ~$65,000 has been borrowed. No assets are currently being borrowed against KNC

### **Post-Exploit Developments**

- **Increased Borrowing Activity:** A notable spike in KNC borrowing was observed following the exploit announcement. A specific [account](https://community.chaoslabs.xyz/aave/risk/wallets/0x473d3a2005499301dc353afa9d0c9c5980b5188c) borrowed 50,000 KNC, bringing the asset utilization to over 90% and the borrow APY to over 1,000%.

### Conclusion

- **Minimal Exposure:** Despite the significant exploit in the Kyber Network, it is important to highlight that the exposure of Aave Protocol to KNC remains minimal.
- **Effective Protocol Mechanisms and Parmeter Settings:** Given the current parameters settings on the protocol, alongside the current usage of the protocol, we do not foresee significant risk to the protocol.

## Specification

The proposal payload executes setReserveFreeze on the Aave V3 Ethereum LendingPoolConfigurator for KNC.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231123_AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum/AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum_20231123.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231123_AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum/AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum_20231123.t.sol)
- [Snapshot](Direct to AIP)
- [Discussion](https://governance.aave.com/t/arfc-temporary-freeze-knc-on-v3-ethereum/15654)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
