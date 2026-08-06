---
title: "Remote GSM Launch: Arbitrum"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-launch-remotegsm-on-arbitrum/24986"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0xf24321514fb593af9e5082d26a1358819ec0f648db8fdb5c2b083f53ef785793"
---

## Simple Summary

Launch GHO GSM on Arbitrum (stataUSDC) using the new RemoteGSM architecture. The proposal mints 50M GHO via a dedicated `GhoDirectFacilitator` on Ethereum, bridges it to Arbitrum over CCIP to seed the local `GhoReserve`, wires up the Arbitrum GSM, and normalizes the GHO CCIP lane capacity across every supported network to a uniform 5M GHO max transfer with a 1,000 GHO/sec refill rate.

## Motivation

The RemoteGSM upgrade refactors GHO's stability mechanism into a three-layer design (`GhoDirectFacilitator` → `GhoReserve` → `GSM`), removing the prior requirement that each GSM be its own GHO facilitator and unlocking GSM deployment on L2s, where GHO cannot be minted directly. Arbitrum is the first L2 target: deploying USDC GSM there extends GHO's stability surface to where a large share of L2 stablecoin liquidity sits, while keeping mint and bridge control under DAO governance.

## Specification

### Fund the Arbitrum GHO Reserve

On Ethereum:

- Temporarily raise the Arbitrum-lane outbound rate limiter to fit a one-off 50M GHO transfer.
- Register an Arbitrum-scoped `GhoDirectFacilitator` on the GHO token with a 50M bucket capacity.
- Mint 50M GHO into the payload and bridge it to Arbitrum via `AaveGhoCcipBridge` (configuring the Arbitrum destination lane first).
- Increase bridge limit by 50M.

On Arbitrum:

- Raise the CCIP token-pool facilitator bucket capacity by 50M.
- Temporarily raise the Ethereum-lane inbound rate limiter to receive the 50M GHO.
- On receipt, the `Collector` forwards the 50M GHO to the `GhoReserve`.

### Wire up Arbitrum GSM (stataUSDC)

- Point it at the `GhoReserve`, enroll it as an entity with a 25M GHO reserve limit.
- Grant `SWAP_FREEZER_ROLE` to the asset's `OracleSwapFreezer` and to the Arbitrum executor.
- Register it in the `GsmRegistry` and grant `CONFIGURATOR_ROLE` to the `GhoGsmSteward`.
- Set the initial exposure cap to 20M of the underlying (6 decimals) and attach the 0% mint / 0.10% burn fee strategy.

`LIMIT_MANAGER_ROLE` on the Arbitrum `GhoReserve` is granted to the Arbitrum Risk Council.

### Normalize GHO CCIP lane capacity across networks

On both ends of every GHO lane touched by this proposal — Arbitrum, Avalanche, Base, Gnosis, Mantle, Plasma, X-Layer, Ink and Monad — set inbound and outbound CCIP rate-limit configs to canonical defaults: **capacity 5,000,000 GHO max transfer, refill 1,000 GHO/sec**. The temporary boosts on the Arbitrum lane used for the 50M seed transfer are restored to these defaults in the same payloads. All L2 facilitator bucket capacity limits are increased by 50M.

- Increase bridge capacity by 50M across all networks.

### Execution Order

Execution order (same pattern as the Plasma launch, #879):

- Ethereum Part 1 — raises the bridge limit and the Eth→Arb outbound rate limiter.
- Ethereum Part 2 — mints 50M GHO via the new GhoDirectFacilitator and bridges it. Reverts if executed within the same second as Part 1 (the outbound bucket needs ~1s to refill).
- Arbitrum Part 1 must execute before the CCIP message arrives, otherwise the inbound rate limit / facilitator bucket rejects the mint and the delivery has to be manually retried on https://ccip.chain.link/.
- Arbitrum Part 2 — reverts until the bridged GHO reaches the Collector.
- The remaining network payloads (Avalanche, Base, Gnosis, Ink, Mantle, Monad, Plasma, X-Layer) are independent and can execute any time.
- Manually register OracleSwapFreezer via SAFE post execution.

## References

- Implementation: [AaveV3Ethereum_Part 1](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1.sol), [AaveV3Ethereum_Part 2](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part2.sol), [AaveV3Arbitrum_Part 1](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part1.sol), [AaveV3Arbitrum_Part 2](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part2.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Avalanche_RemoteGSMLaunchArbitrum_20260512.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Base_RemoteGSMLaunchArbitrum_20260512.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Gnosis_RemoteGSMLaunchArbitrum_20260512.sol), [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Mantle_RemoteGSMLaunchArbitrum_20260512.sol), [AaveV3Ink](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Ink_RemoteGSMLaunchArbitrum_20260512.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Plasma_RemoteGSMLaunchArbitrum_20260512.sol), [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3XLayer_RemoteGSMLaunchArbitrum_20260512.sol), [AaveV3Monad](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Monad_RemoteGSMLaunchArbitrum_20260512.sol)
- Tests: [AaveV3Ethereum_Part 1](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1.t.sol), [AaveV3Ethereum_Part 2](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part2.t.sol), [AaveV3Arbitrum_Part 1](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part1.t.sol), [AaveV3Arbitrum_Part 2](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part2.t.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Avalanche_RemoteGSMLaunchArbitrum_20260512.t.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Base_RemoteGSMLaunchArbitrum_20260512.t.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Gnosis_RemoteGSMLaunchArbitrum_20260512.t.sol), [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Mantle_RemoteGSMLaunchArbitrum_20260512.t.sol), [AaveV3Ink](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Ink_RemoteGSMLaunchArbitrum_20260512.t.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Plasma_RemoteGSMLaunchArbitrum_20260512.t.sol), [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3XLayer_RemoteGSMLaunchArbitrum_20260512.t.sol), [AaveV3Monad](https://github.com/aave-dao/aave-proposals-v3/blob/27cb6948f818712371dfb203afd30733fca50c65/src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Monad_RemoteGSMLaunchArbitrum_20260512.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0xf24321514fb593af9e5082d26a1358819ec0f648db8fdb5c2b083f53ef785793)
- [Discussion](https://governance.aave.com/t/arfc-launch-remotegsm-on-arbitrum/24986)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
