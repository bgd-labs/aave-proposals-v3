---
title: "Allow Emergency Admin to freeze on Aave V2"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/aave-v2-v3-security-incident-04-11-2023/15335"
---

## Simple Summary

Proposal to allow the emergencyAdmin role to freeze reserves on Aave V2 pools - including Aave V2 AMM, Aave V2 Ethereum, Polygon, and Avalanche; same behavior as on Aave v3.
Additionally, Liquidations Grace Sentinel is activated for Aave V2 AMM, following the same approach as [AIP 361](https://app.aave.com/governance/proposal/361/)

## Motivation

To be consistent with the approved Aave v3 approach of Freezing Stewards ([AIP 319](https://app.aave.com/governance/proposal/319/)), and maintain security across all Aave V2 deployments, the protocol needs to have up-to-date preventative functionality.

Freezing is a less invasive mechanism compared with pause, which can already be done by the emergencyAdmin on v2.

## Specification

The proposal payloads will update the `freezeReserve()` / `unfreezeReserve()` functions on the pool configurator contract to use the new `onlyPoolOrEmergencyAdmin` modifier, which allows both the emergency admin (Aave Guardian) and pool admin (governance Executor contract) to freeze and unfreeze reserves.

On AaveV2Ethereum, AaveV2EthereumAMM, AaveV2Polygon and AaveV2Avalanche the proposal will call:

- `POOL_ADDRESSES_PROVIDER.setLendingPoolConfiguratorImpl(NEW_POOL_CONFIGURATOR);`

To update the pool configurator with the new implementation.

In addition `LendingPoolCollateralManager` for Aave V2 AMM is updated analog to [AIP 361](https://app.aave.com/governance/proposal/361/).

## References

- Implementation: [Payload](https://github.com/bgd-labs/stable-rate-patch/blob/main/src/payloads/ConfiguratorUpdatePayload.sol),
- Tests: [PoolConfiguratorTest](https://github.com/bgd-labs/stable-rate-patch/blob/main/tests/V2PoolConfigurator.t.sol), [PoolConfiguratorTestBase](https://github.com/bgd-labs/stable-rate-patch/blob/main/tests/V2PoolConfiguratorTestBase.t.sol)
- [Discussion](https://governance.aave.com/t/aave-v2-v3-security-incident-04-11-2023/15335)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
