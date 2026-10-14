---
title: "Aave V4 Sentora Market Activation"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-sentora-externally-curated-hub-spoke-framework-on-aave-v4/25723"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x682f73c809e03d25008b9c4898f4e25c047806683f4d1b0d7635ba8ed50276aa"
---

## Simple Summary

This payload activates the Sentora curated market on Aave V4 Ethereum: one Hub (Sentora) and three Spokes (RLUSD Yield, OUSD Yield, Bluechip).

## Motivation

The [ARFC](https://governance.aave.com/t/arfc-sentora-externally-curated-hub-spoke-framework-on-aave-v4/25723), approved on Snapshot, sets up a framework for Sentora to operate externally curated Hub and Spoke instances on Aave V4 and authorises the first one on Ethereum. Sentora curates the instance: it selects collateral and sets risk parameters, interest rate curves and oracles. These are outside the risk management mandate of the Aave DAO and its service providers. The Aave DAO receives 50% of the instance revenue.

RLUSD, PYUSD and OUSD are the only borrowable assets. USDe, PRIME, mWIN, PST and kBTC are collateral only. The RLUSD Yield and OUSD Yield Spokes lend RLUSD and OUSD against yield-bearing collateral, and the Bluechip Spoke lends RLUSD, PYUSD and OUSD against kBTC.

The market is deployed and configured with every asset-spoke pair halted. This payload hands the position managers and gateways to the Sentora Executor and opens the market.

## Specification

The payload is executed by the Sentora Executor through the Sentora PermissionedPayloadsController, after its timelock. It:

1. Accepts the ownership of the Giver, Taker and Config position managers, the NativeTokenGateway and the SignatureGateway, transferred to the Sentora Executor during the deployment handover.
2. Unhalts every asset-spoke pair on the Sentora Hub via `HubConfigurator.updateSpokeHalted`, which the market configuration halted at deployment: the 14 reserves across the three Spokes, and the TreasurySpoke as fee receiver of each of the 8 assets.

The TreasurySpoke ownership is accepted separately by the Sentora Fee Admin.

## References

- Implementation: [AaveV4EthereumSentoraCurated](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20261009_AaveV4EthereumSentoraCurated_SentoraMarketActivation/AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009.sol)
- Tests: [AaveV4EthereumSentoraCurated](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20261009_AaveV4EthereumSentoraCurated_SentoraMarketActivation/AaveV4EthereumSentoraCurated_SentoraMarketActivation_20261009.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x682f73c809e03d25008b9c4898f4e25c047806683f4d1b0d7635ba8ed50276aa)
- [Discussion](https://governance.aave.com/t/arfc-sentora-externally-curated-hub-spoke-framework-on-aave-v4/25723)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
