---
title: "Register a.DI Ethereum -> Scroll adapter"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/15"
---

## Simple Summary

Proposal to register the Scroll adapter on Ethereum a.DI, a technical requirement for an activation vote of Aave v3 Scroll.

## Motivation

In order to be able to pass messages from Ethereum to Scroll via a.DI (Aave Delivery Infrastructure), it is necessary to at least have one valid adapter Ethereum -> Scroll smart contract enabled in the system.

The first case of message passing Ethereum -> Scroll is the activation proposal for an Aave v3 Scroll pool and consequently, to be able to execute on the Scroll side the payload, the Aave governance should approve in advance the a.DI adapter smart contract.

This procedure was not required on previous activations like BNB, given that their adapter were pre-configured on the initial a.DI release, but will be needed going forward.

## Specification

The proposal payload simply registers a pre-deployed Scroll adapter (with the necessary configurations to communicate with the Scroll a.DI) on the Ethereum a.DI instance.

This is done by calling the `enableBridgeAdapters()` function on the Ethereum Cross-chain Controller smart contract.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f700e6370439769ffd53c3504a3ab4a0ac2792b7/src/20240122_AaveV3Ethereum_RegisterADIScrollAdapter/AaveV3Ethereum_RegisterADIScrollAdapter_20240122.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f700e6370439769ffd53c3504a3ab4a0ac2792b7/src/20240122_AaveV3Ethereum_RegisterADIScrollAdapter/AaveV3Ethereum_RegisterADIScrollAdapter_20240122.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-aave-v3-deployment-on-scroll-mainnet/16126/)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
