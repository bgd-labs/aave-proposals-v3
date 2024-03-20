---
title: "v3 Periphery maintenance"
author: "BGD Labs"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274"
---

## Simple Summary

Purely technical proposal to do minor improvements on two Aave v3’s periphery components: stataTokens and Sequencer Uptime Feed on Scroll (also known as PriceOracleSentinel).

## Motivation

### Price oracle sentinel

The Sequencer Uptime Feed (also known as “price oracle sentinel”) is a feature baked into Aave v3 that pauses liquidations & borrowing for a limited amount of time whenever a sequencer downtime is detected on a Chainlink oracle (l2 sequencer feed).

This pause should give users the ability to refill or repay their positions in case the market moved while the sequencer was down.

As the Chainlink Scroll l2 sequencer feed was not yet available when the pool launched, the Sequencer Uptime Feed on Aave was disabled until now.

### Stata tokens

In our continuous effort to enhance the security of the aave protocol and the surrounding ecosystem we discovered some minor issues with the Static a token implementation.

- For reserves without a `supplyCap` the `maxMint` function on the static aToken would revert. While there is currently no reserve without a supplyCap on any network, we think it’s reasonable to fix the issue to prevent unforeseen issues for integrators in the future.
- Similar to an issue fixed on the aave core, the static-a-token is prone to permit griefing. While there is no financial incentive for an attacker to perform griefing, we used the upgrade to close the griefing vector & upgrade the token to rely on the open-zeppelin ECDSA library.

## Specification

Upon execution, the proposal will call

- `POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel(NEW_PRICE_ORACLE_SENTINEL)` on the addresses provider contract and set the new implementation of the PriceOracleSentinel contract on Aave V3 Scroll
- `upgrade(token, NEW_TOKEN_IMPLEMENTATION)` for all the existing stata tokens
- `upgrade(token, NEW_FACTORY_IMPLEMENTATION)` for all the existing stata factories

## References

- Implementation: [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/18f654208a27fae18368cf3dff9395e70677fc2c/src/20240314_Multi_V3PeripheryMaintenance/AaveV3Scroll_V3PeripheryMaintenance_20240314.sol)
- Tests: [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/18f654208a27fae18368cf3dff9395e70677fc2c/src/20240314_Multi_V3PeripheryMaintenance/AaveV3Scroll_V3PeripheryMaintenance_20240314.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
