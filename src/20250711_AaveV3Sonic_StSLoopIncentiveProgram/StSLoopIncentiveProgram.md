---
title: "stS Loop Incentive Program"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-sts-loop-incentive-program/22368"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x65e12ce7784f12fbed9731d4cdbc826a8a5d4804439dc6d55d6e31c0b069a048"
---

## Simple Summary

This ARFC proposes the launch of a 3-month stS loop incentive program on Aave. The goal is to deepen stS liquidity on Aave, align incentives with Beets, and ensure Aave remains the exclusive lending market for stS.

## Motivation

Beets has committed to Aave as the exclusive home for stS liquidity and will not incentivize or market any external stS lending market. This commitment aligns with the broader “Just Use Aave” strategy and presents a strong opportunity to consolidate stS liquidity on Aave v3.

To support this integration and unlock meaningful TVL, this ARFC outlines a clear path forward to bootstrap stS<>wS loop participation via:

- Cashback incentives based on stS collector revenue.
- Clarity around exclusivity boundaries regarding Beets’ Boosted Pools.

## Specification

An allowance from the Aave Collector will be requested to fund the 40,000 wS budget via a single transaction to the designated MASiv Nested SAFE.

The initial Allowance is for 40,000 wS from Sonic instance.

Asset: aSonwS `0x6C5E14A212c1C3e4Baf6f871ac9B1a969918c131`[https://sonicscan.org/address/0x6C5E14A212c1C3e4Baf6f871ac9B1a969918c131]
Amount: 40,000
Spender: Masiv nested safe `0x565B80842eCEDad88A2564Ea375CE875Ed3bAdeC`[https://sonicscan.org/address/0x565B80842eCEDad88A2564Ea375CE875Ed3bAdeC]
Method: `approve()` aSonwS on the Aave Collector contract to the Masiv address.

## References

- Implementation: [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/809b310d755b72dcf0802d8110efeae83d381ded/src/20250711_AaveV3Sonic_StSLoopIncentiveProgram/AaveV3Sonic_StSLoopIncentiveProgram_20250711.sol)
- Tests: [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/809b310d755b72dcf0802d8110efeae83d381ded/src/20250711_AaveV3Sonic_StSLoopIncentiveProgram/AaveV3Sonic_StSLoopIncentiveProgram_20250711.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x65e12ce7784f12fbed9731d4cdbc826a8a5d4804439dc6d55d6e31c0b069a048)
- [Discussion](https://governance.aave.com/t/arfc-sts-loop-incentive-program/22368)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
