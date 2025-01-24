---
title: "GHO Risk Stewards Update and GHO CCIP Integration Upgrade"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/59"
---

## Simple Summary

This AIP proposes to:

1. update the GHO Risk Steward contracts to enhance the Risk Council’s user experience and align the design of the Risk Stewards implementations throughout the Aave Protocol.
2. update the GHO CCIP Token Pools on Arbitrum and Ethereum to integrate them with latest version of CCIP (1.5.1) to leverage the full functionality of CCIP and prepare for future expansions to other chains.

## Motivation

This AIP seeks to enhance the Aave user experience and align the design of the Risk Stewards implementation across the Aave Protocol. Additionally, the CCIP was recently upgraded to version 1.5.1, introducing a number of enhancements for cross-chain pool management. Currently, GHO CCIP Token Pools are based on version 1.4, though still compatible with 1.5.1.

Aave Labs will provide technical support to maintain the GHO CCIP Token Pools functional, secured, and aligned with the latest updates, enabling GHO expansion to other networks when needed.

## Specification

The proposal includes the following actions:

Risk Stewards update:

1. GhoAaveSteward: Remove the max cap of 25% configured by `GHO_BORROW_RATE_MAX`. While this limitation was sensible when applied to the Ethereum reserve only, it is not necessary for different instances of GHO when implemented as a regular reserve. Additionally, the Risk Stewards already have limitations and sanity checks in place to restrict capabilities during rates update.
2. GhoCcipSteward: Add a missing getter for the timelock state of the CCIP.
3. GhoBucketSteward: No modification, configure new token pool and retire permissions for the existing token pool.

GHO CCIP Token Pools upgrade:

1. Ownership maintenance of contracts:
   1. Accept ownership of new token pool contracts for GHO on each network.
   2. Assume Admin role for the GHO token in the CCIP TokenAdminRegistry contract on each network.
   3. Take ownership of the existing proxy pools (even though they'll be deprecated).
2. Migrate Liquidity Between Old and New Token Pools:
   1. On Ethereum: Transfer locked GHO liquidity from the old LockReleaseTokenPool contract to the new one, and properly initialize the new contract to reflect the correct amount of bridged liquidity.
   2. On Arbitrum: Mint tokens on the new BurnMintTokenPool contract and burn tokens from the old pool using the newly introduced `directMint` and `directBurn` methods. This is necessary to offboard the old pool as a facilitator and enable the new pool to handle bridge transactions.
3. Setup a token rate limit of 300,000 GHO capacity and 60 GHO per second refill rate (216,000 GHO per hour), as recommended by the Risk Provider ChaosLabs in the previous maintenance upgrade to v1.5, see [here](https://governance.aave.com/t/technical-maintenance-proposals/15274/54).
4. Keep GhoStewards functional by validating they can execute actions over the new CCIP lane and remain fully operational.

## References

- Implementation: [GhoAaveSteward](https://github.com/aave/gho-core/blob/cf6ee42adc8b2e9ac8ffd1d70bd5b52f06e536b6/src/contracts/misc/GhoAaveSteward.sol), [GhoCcipSteward](https://github.com/aave/gho-core/blob/cf6ee42adc8b2e9ac8ffd1d70bd5b52f06e536b6/src/contracts/misc/GhoCcipSteward.sol), [UpgradeableLockReleaseTokenPool](https://github.com/aave/ccip/blob/d5c6cedde6fbca9890a92a55f2db80e94793d0ec/contracts/src/v0.8/ccip/pools/GHO/UpgradeableLockReleaseTokenPool.sol), [UpgradeableTokenPool](https://github.com/aave/ccip/blob/d5c6cedde6fbca9890a92a55f2db80e94793d0ec/contracts/src/v0.8/ccip/pools/GHO/UpgradeableTokenPool.sol)

- Contracts:

  - Ethereum
    - [UpgradeableLockReleaseTokenPool](https://etherscan.io/address/0x06179f7C1be40863405f374E7f5F8806c728660A)
    - [GhoAaveSteward](https://etherscan.io/address/0x98217A06721Ebf727f2C8d9aD7718ec28b7aAe34)
    - [GhoCcipSteward](https://etherscan.io/address/0xC5BcC58BE6172769ca1a78B8A45752E3C5059c39)
  - Arbitrum
    - [UpgradeableBurnMintTokenPool](https://arbiscan.io/address/0xB94Ab28c6869466a46a42abA834ca2B3cECCA5eB)
    - [GhoAaveSteward](https://arbiscan.io/address/0xd2D586f849620ef042FE3aF52eAa10e9b78bf7De)
    - [GhoCcipSteward](https://arbiscan.io/address/0xCd5ab470AaC5c13e1063ee700503f3346b7C90Db)

- Discussion: [GHO CCIP Integration Maintenance (CCIP v1.5.1 upgrade)](https://governance.aave.com/t/technical-maintenance-proposals/15274/59), [Update GHO Risk Stewards](https://governance.aave.com/t/technical-maintenance-proposals/15274/60)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
