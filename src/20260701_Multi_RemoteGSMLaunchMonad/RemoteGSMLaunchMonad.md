---
title: "Remote GSM Launch: Monad"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-protocol-v3-7-on-monad/24943"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6"
---

## Simple Summary

Launch a GHO GSM on Monad (USDC) using the RemoteGSM architecture. The proposal mints 50M GHO via a dedicated `GhoDirectFacilitator` on Ethereum, bridges it to Monad over CCIP to seed the local `GhoReserve`, and wires up the Monad USDC GSM.

## Motivation

The RemoteGSM upgrade refactors GHO's stability mechanism into a three-layer design (`GhoDirectFacilitator` → `GhoReserve` → `GSM`), removing the prior requirement that each GSM be its own GHO facilitator and unlocking GSM deployment on L2s, where GHO cannot be minted directly. Deploying a USDC GSM on Monad extends GHO's stability surface to a new network while keeping mint and bridge control under DAO governance.

## Specification

### Fund the Monad GHO Reserve

On Ethereum:

- Raise the GHO CCIP bridge limit by 50M (permanent: the bridged 50M becomes part of the locked supply) and temporarily widen the Monad-lane outbound rate limiter to fit the one-off 50M GHO transfer.
- Register a Monad-scoped `GhoDirectFacilitator` on the GHO token with a 50M bucket capacity.
- Mint 50M GHO into the payload and bridge it to Monad via `AaveGhoCcipBridge` (configuring the Monad destination lane first).
- After bridging, restore the Ethereum ↔ Monad lane rate-limit config to its prior value. No other lane is modified.

On Monad:

- Raise the CCIP token-pool facilitator bucket capacity by 50M.
- Temporarily raise the Ethereum-lane inbound rate limiter to receive the 50M GHO.
- On receipt, the `Collector` forwards the 50M GHO to the `GhoReserve`.
- After bridging, restore the Monad ↔ Ethereum lane rate-limit config to its prior value.

### Wire up Monad GSM (USDC)

For the GSM:

- Point it at the `GhoReserve`, enroll it as an entity with a 25M GHO reserve limit.
- Grant `SWAP_FREEZER_ROLE` to the asset's `OracleSwapFreezer` and to the Monad executor.
- Register it in the `GsmRegistry` and grant `CONFIGURATOR_ROLE` to the `GhoGsmSteward`.
- Set the initial exposure cap to 40M of the underlying (6 decimals) and attach the 0% sell / 0.10% buy fee strategy (selling the underlying for GHO is free; buying it back with GHO costs 0.10%).

`LIMIT_MANAGER_ROLE` on the Monad `GhoReserve` is granted to the Monad Risk Council.

### GHO CCIP lane capacity

GHO CCIP lane rate-limit capacities are kept the same as before execution. The proposal only widens the Ethereum ↔ Monad lane temporarily to move the 50M seed, then restores it. The remaining networks (Arbitrum, Avalanche, Base, Gnosis, Mantle, Plasma, X-Layer, Ink) only increase their CCIP token-pool facilitator bucket capacity by 50M to account for the newly minted supply; their lane rate limits are not touched.

### Execution Order

Execution order:

- Ethereum Part 1 — raises the bridge limit and the Eth→Monad outbound rate limiter.
- Ethereum Part 2 — mints 50M GHO via the new GhoDirectFacilitator and bridges it. Reverts if executed within the same second as Part 1 (the outbound bucket needs ~1s to refill).
- Monad Part 1 must execute before the CCIP message arrives, otherwise the inbound rate limit / facilitator bucket rejects the mint and the delivery has to be manually retried on https://ccip.chain.link/.
- Monad Part 2 — reverts until the bridged GHO reaches the Collector.
- The remaining network payloads (Arbitrum, Avalanche, Base, Gnosis, Ink, Mantle, Plasma, X-Layer) are independent and can execute any time.
- Manually register OracleSwapFreezer via SAFE post execution.

## References

- Implementation: [AaveV3Ethereum_Part 1](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part1.sol), [AaveV3Ethereum_Part 2](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part2.sol), [AaveV3Monad_Part 1](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part1.sol), [AaveV3Monad_Part 2](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part2.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Arbitrum_RemoteGSMLaunchMonad_20260701.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Avalanche_RemoteGSMLaunchMonad_20260701.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Base_RemoteGSMLaunchMonad_20260701.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Gnosis_RemoteGSMLaunchMonad_20260701.sol), [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Mantle_RemoteGSMLaunchMonad_20260701.sol), [AaveV3Ink](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Ink_RemoteGSMLaunchMonad_20260701.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Plasma_RemoteGSMLaunchMonad_20260701.sol), [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3XLayer_RemoteGSMLaunchMonad_20260701.sol)
- Tests: [AaveV3Ethereum_Part 1](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part1.t.sol), [AaveV3Ethereum_Part 2](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part2.t.sol), [AaveV3Monad_Part 1](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part1.t.sol), [AaveV3Monad_Part 2](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part2.t.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Arbitrum_RemoteGSMLaunchMonad_20260701.t.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Avalanche_RemoteGSMLaunchMonad_20260701.t.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Base_RemoteGSMLaunchMonad_20260701.t.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Gnosis_RemoteGSMLaunchMonad_20260701.t.sol), [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Mantle_RemoteGSMLaunchMonad_20260701.t.sol), [AaveV3Ink](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Ink_RemoteGSMLaunchMonad_20260701.t.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Plasma_RemoteGSMLaunchMonad_20260701.t.sol), [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3XLayer_RemoteGSMLaunchMonad_20260701.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-protocol-v3-7-on-monad/24943)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
