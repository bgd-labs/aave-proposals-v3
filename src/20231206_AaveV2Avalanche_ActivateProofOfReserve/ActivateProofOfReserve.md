---
title: "Activate Proof of Reserve"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/11"
---

## Simple Summary

This proposal aims to add Proof of Reserve Admin role to the Avalanche V2 Pool Configurator in order to activate the proof of reserve mechanism.

## Motivation

At the moment, in Aave v3 Avalanche there are multiple assets with a “bridged” nature: DAI.e, USDC.e, USDT.e, AAVE.e, LINK.e, WBTC.e, BTC.b and WETH.e.

These assets have 2 sides: one deposit account in the network where the asset originated (Ethereum in the case of the \*.e assets) and a token smart contract on the “usage” chain (Avalanche in this case).

Given that architecture, there are 2 main attack vectors to exploit “bridged” assets:

An exploit on the origination network, extracting tokens from the deposit contract.
An exploit on the usage network, generally minting tokens that have no backing on the origination network, usually called an “infinite minting attack”.

In order to prevent the 2) type of attack Proof of Reserve mechanism was introduced and activated for the V3 Pool on Avalanche almost a year ago. Now we are ready to activate it for the V2 as well.

## Specification

- `AaveV2Avalanche.POOL_ADDRESSES_PROVIDER.setLendingPoolConfiguratorImpl()` will be called with the new configurator address passed.

- `AaveV2Avalanche.POOL_ADDRESSES_PROVIDER.setAddress()` will be called to set proof of reserve executor as the admin.

## References

- Implementation: [AaveV2Avalanche](https://github.com/bgd-labs/aave-v2-proof-of-reserve/blob/main/src/payloads/ConfiguratorUpdatePayload.sol)
- Tests: [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/bf8c97c945bbd644a812043b1fd00c69feaaaab2/src/20231206_AaveV2Avalanche_ActivateProofOfReserve/AaveV2Avalanche_ActivateProofOfReserve_20231206.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-aave-chainlink-proof-of-reserve-phase-1-release-candidate/10972)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
