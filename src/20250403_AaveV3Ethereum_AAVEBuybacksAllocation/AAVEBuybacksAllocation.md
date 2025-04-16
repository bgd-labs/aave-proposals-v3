---
title: "AAVE Buybacks allocation"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-aavenomics-implementation-part-one/21248"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0xf0591fe8e54900da9929fe25c466c2b4a0fac6e8f7a3a000087797363847fb65"
---

## Simple Summary

This proposal approves a specific allowance of **aEthUSDT** from the Aave Collector contract to the **Aave Finance Committee (AFC)**, enabling the committee to initiate AAVE buybacks as part of the Aavenomics implementation.

## Motivation

As outlined in the [Aavenomics Part One proposal](https://governance.aave.com/t/arfc-aavenomics-implementation-part-one/21248), the Aave DAO is launching a structured AAVE Buy and Distribute program. The goal is to sustainably increase AAVE acquisition from the open market and distribute it to the Ecosystem Reserve.

This initial proposal enables the AFC to begin executing the first phase of the buyback program by approving $4M in aEthUSDT, allowing for approximately one month of AAVE buybacks. While the full program targets up to $1M/week over six months, this limited approval serves as a first step. It also gives us time to finalize and deploy the updated Aave Swapper contract, which will be used for future buybacks.

This allowance mechanism ensures:

- Treasury operations remain secure, with no direct token transfer.
- The AFC can operate within clearly defined, governance-approved budgets.
- Buyback operations can begin without delay, supporting protocol alignment and tokenomics upgrades.

## Specification

- **Asset**: aEthUSDT: 0x23878914EFE38d27C4D67Ab83ed1b93A74D4086a
- **Amount**: 4M
- **Spender**: [Aave Finance Committee (AFC)](https://etherscan.io/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa): 0x22740deBa78d5a0c24C58C740e3715ec29de1bFa
- **Method**: `approve()` aEthUSDT on the Aave Collector contract to the AFC address

Once approved, the AFC will be able to pull USDT from the Collector contract to perform AAVE purchases on secondary markets or via market makers.

This operation does **not** transfer any tokens at execution, and the allowance can be adjusted or revoked at any time through a new governance vote.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/5bf5796951820701d82d50530c71fcf1edd0d091/src/20250403_AaveV3Ethereum_AAVEBuybacksAllocation/AaveV3Ethereum_AAVEBuybacksAllocation_20250403.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/5bf5796951820701d82d50530c71fcf1edd0d091/src/20250403_AaveV3Ethereum_AAVEBuybacksAllocation/AaveV3Ethereum_AAVEBuybacksAllocation_20250403.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0xf0591fe8e54900da9929fe25c466c2b4a0fac6e8f7a3a000087797363847fb65)
- [Discussion](https://governance.aave.com/t/arfc-aavenomics-implementation-part-one/21248)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
