---
title: "Temporary Freeze KNC on V3 Ethereum"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-temporary-freeze-knc-on-v3-ethereum/15654"
---

## Simple Summary

A proposal to freeze KNC on Aave V3 Ethereum market.

## Motivation

As a precautionary measure, and to protect the protocol from unexpected behaviors and developments stemming from the recent KyberSwap DEX exploit, Chaos Labs recommends a temporary freeze of the KNC reserve on Aave V3 Ethereum.

The full analysis can be found in the governance forum post here - https://governance.aave.com/t/arfc-temporary-freeze-knc-on-v3-ethereum/15654

It is important to note that given the current parameter settings on the protocol, alongside the current usage of the protocol, we do not foresee significant risk to the protocol.

## Specification

The proposal payload executes setReserveFreeze on the Aave V3 Ethereum LendingPoolConfigurator for KNC.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231123_AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum/AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum_20231123.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231123_AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum/AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum_20231123.t.sol)
- [Snapshot](Direct to AIP)
- [Discussion](https://governance.aave.com/t/arfc-temporary-freeze-knc-on-v3-ethereum/15654)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
