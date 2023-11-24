---
title: "Allow Emergency Admin to freeze on Aave V2"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/aave-v2-v3-security-incident-04-11-2023/15335"
---

## Simple Summary

Proposal to allow emergency admin to freeze reserves on Aave V2 pools - including Aave V2 AMM, Aave V2 on Ethereum, Polygon and Avalanche.
Additionally, Liquidations Grace Sentinel is activated for Aave V2 AMM, following the same approach as [AIP 361](https://app.aave.com/governance/proposal/361/)

## Motivation

Similar to the Freezing Stewards [AIP 319](https://app.aave.com/governance/proposal/319/), in order to maintain security across all Aave V2 deployments, it is essential for the protocol to have up-to-date preventative functionality.

## Specification

Updates the `freezeReserve()` function on the pool configurator to use the new `onlyPoolOrEmergencyAdmin` modifier which allows both the emergency admin and pool admin to freeze reserves.

On AaveV2Ethereum, AaveV2EthereumAMM, AaveV2Polygon and AaveV2Avalanche the proposal will call:

- `POOL_ADDRESSES_PROVIDER.setLendingPoolConfiguratorImpl(NEW_POOL_CONFIGURATOR);`

To update the pool configurator with the new implementation.

In addition `LendingPoolCollateralManager` for Aave V2 AMM is updated analog to [AIP 361](https://app.aave.com/governance/proposal/361/).

## References

- Implementation: [EthereumPayload](https://github.com/bgd-labs/stable-rate-patch/blob/main/src/payloads/V2EthConfiguratorUpdatePayload.sol), [L2Payload](https://github.com/bgd-labs/stable-rate-patch/blob/main/src/payloads/V2L2ConfiguratorUpdatePayload.sol)
- Tests: [PoolConfiguratorTest](https://github.com/bgd-labs/stable-rate-patch/blob/main/tests/V2PoolConfigurator.t.sol), [PoolConfiguratorTestBase](https://github.com/bgd-labs/stable-rate-patch/blob/main/tests/V2PoolConfiguratorTestBase.t.sol)
- [Discussion](https://governance.aave.com/t/aave-v2-v3-security-incident-04-11-2023/15335)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
