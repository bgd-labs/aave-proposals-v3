---
title: "Extend SVR V1 to more reserves"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/direct-to-aip-aave-chainlink-svr-v1-activation-phase-2/21940"
---

## Simple Summary

Enable SVR feeds on the following assets:

- `eBTC`, `cbBTC` and `WBTC` on the Aave V3 Core instance
- `USDC`, `WETH`, `rsETH`, `ezETH` and `wstETH` on the Aave V3 Prime instance

## Motivation

In [proposal 274](https://vote.onaave.com/proposal/?proposalId=274) a fist set of SVR feeds was enabled.
Over the recent weeks, the oracles were monitored and as expected no relevant deviations were monitored and SVR updates arrived in time. Therefore, in order to make integrating with SVR more attractive, this proposal aims to enable the next set of SVR feeds on ethereum mainnet.

## Specification

Given the new introduction of SVR feeds on the prime instance, this proposal will perform the activation through a dedicated instance of the previously introduced SVR_STEWARD steward.
The SVR_STEWARD, ensures there is minimal derivation between the current price feed and the svr price feed at activation.
Also the SVR_STEWARD allows for the Protocol guardian to revert to the previous oracle in case any unforeseen issue arises.

- grant the "ASSET LISTING ADMIN" role to the [Prime SVR_STEWARD](https://etherscan.io/address/0x84f2C90f2D66E700baA4CF3cbF66bE7D8f21Bd87)
- call the `SVR_STEWARD.enableSvrOracles`, replacing the oracle of
  - `eBTC`, `cbBTC` and `WBTC` on the Aave V3 Core instance
  - `USDC`, `WETH`, `rsETH`, `ezETH` and `wstETH` on the Aave V3 Prime instance

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7dfaeee8e64d904f3350186e0e6159dccb944f41/src/20250429_Multi_ExtendSVRV1ToMoreReserves/AaveV3Ethereum_ExtendSVRV1ToMoreReserves_20250429.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/7dfaeee8e64d904f3350186e0e6159dccb944f41/src/20250429_Multi_ExtendSVRV1ToMoreReserves/AaveV3EthereumLido_ExtendSVRV1ToMoreReserves_20250429.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7dfaeee8e64d904f3350186e0e6159dccb944f41/src/20250429_Multi_ExtendSVRV1ToMoreReserves/AaveV3Ethereum_ExtendSVRV1ToMoreReserves_20250429.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/7dfaeee8e64d904f3350186e0e6159dccb944f41/src/20250429_Multi_ExtendSVRV1ToMoreReserves/AaveV3EthereumLido_ExtendSVRV1ToMoreReserves_20250429.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-aave-chainlink-svr-v1-activation-phase-2/21940)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
