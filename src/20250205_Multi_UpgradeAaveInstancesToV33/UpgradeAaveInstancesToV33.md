---
title: "Upgrade Aave instances to v3.3"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-aave-v3-3-feat-umbrella/20129"
---

## Simple Summary

This proposal will upgrade all active Aave instances to version v3.3.0.

## Motivation

Back in December, we (BGD Labs) [presented](https://governance.aave.com/t/bgd-aave-v3-3-feat-umbrella/20129) the Aave v3.3.0 upgrade, improving Aave's liquidation engine, and supporting the previously proposed [Umbrella](https://governance.aave.com/t/bgd-aave-safety-module-umbrella/18366).
With the proposal being executed, the Aave Protocol will start tracking bad debt, which can then be used as an input on Umbrella to slash stakers & cover the realized deficit.

## Specification

This proposal will upgrade all active Aave instances to the new v3.3.0 version.
In practice this means:

1. The pool implementation will be upgraded via a call to `POOL_ADDRESSES_PROVIDER.setPoolImpl(newImpl)`
2. The pool configurator will be upgraded via a call to `POOL_ADDRESSES_PROVIDER.setPoolConfiguratorImpl(poolConfiguratorImpl)`
3. The pool data provider will be replaced via a call to `POOL_ADDRESSES_PROVIDER.setPoolDataProvider(newPoolDataProvider)`

In addition the proposal will transfer 66.400$ in aUSDC to a wallet controlled by BGD to cover audit costs, as disclosed [HERE](https://governance.aave.com/t/bgd-aave-v3-3-feat-umbrella/20129/5)

## Security procedures

The v3.3.0 upgrade was audited by:

- [StErMi](https://github.com/bgd-labs/aave-v3-origin/blob/v3.3.0/audits/2024-10-22_StErMi_Aave-v3.3.pdf)
- [Certora](https://github.com/bgd-labs/aave-v3-origin/blob/v3.3.0/audits/2024-11-07_Certora_Aave-v3.3.0.pdf)
- [Oxorio](https://github.com/bgd-labs/aave-v3-origin/blob/v3.3.0/audits/2025-01-29_Oxorio_Aave-v3.3.0.pdf)

In addition a [Sherlock Audit Contest](https://governance.aave.com/t/arfc-bgd-aave-v3-3-sherlock-contest/20498/2) was performed from `13.01.25 - 22.01.25`.
You can find the related audit report [here](https://github.com/aave-dao/aave-v3-origin/blob/v3.3.0/audits/2025-01-22_Sherlock_Aave-v3.3.0.pdf).

## References

- [Implementation](https://github.com/bgd-labs/protocol-v3.3-upgrade/blob/main/src/contracts/UpgradePayload.sol)
- [Tests](https://github.com/bgd-labs/protocol-v3.3-upgrade/tree/main/tests)
- [Diffs](https://github.com/bgd-labs/protocol-v3.3-upgrade/tree/main/diffs)
- [Discussion](https://governance.aave.com/t/bgd-aave-v3-3-feat-umbrella/20129)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
