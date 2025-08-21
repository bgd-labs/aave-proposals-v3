---
title: "Horizon RWA Instance Activation"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-horizon-s-rwa-instance/21898"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xc69410600084e9d3d27e6569dddda08fc053182bcf402e3e612fc97cab783f24"
---

# Simple Summary

Proposal to activate the Horizon RWA instance, a friendly fork which launches a white label instance of the Aave Protocol, enabling the Aave DAO to capture new revenue from RWAs.

# Motivation

Horizon’s RWA instance on Ethereum is deployed but currently the pool is paused, rewards and its admin roles are unset for the onboarded tokens, and GHO cannot be minted via a Horizon facilitator. This AIP activates the instance so integrators and users can begin interacting with the pool.

Concretely, the proposal:

1. Unpauses the deployed Horizon Pool so deposits/borrows can proceed.
2. Assigns the Horizon Emission Admin to all supported assets (and their aTokens where applicable) so incentives can be configured and adjusted via EmissionManager without further governance actions.
3. Enables GHO utility within the instance by granting the direct minter the RISK_ADMIN role, registering it as a facilitator with a 1M GHO bucket capacity, and registering this new direct minter as a controlled facilitator on the existing Gho Bucket Steward.
4. Seeds 1M GHO liquidity into the protocol as defined in the ARFC through GhoDirectMinter.

These steps finalize the operational setup for the Horizon instance.

# Specification

This proposal executes the following actions:

- Unpause the Pool

  - Call IPoolConfigurator.setPoolPause(false)
  - Enables all standard pool operations per current reserve configurations.

- Set Emission Admins

  - For stablecoins (GHO, RLUSD, USDC):
    - Fetch aToken via IPoolDataProvider.getReserveTokensAddresses(token)
    - Set emission admin for both the underlying token and its aToken to EMISSION_ADMIN using IEmissionManager.setEmissionAdmin.
  - For RWA tokens (USTB, USCC, USYC, JAAA, JTRSY):
    - Set emission admin for each token to EMISSION_ADMIN using IEmissionManager.setEmissionAdmin.
    - Configures and updates liquidity mining / rewards programs across assets.

- Enable GHO Facilitator

  - Grant RISK_ADMIN_ROLE to GHO_DIRECT_MINTER via IACLManager.grantRole.
  - Register facilitator: IGhoToken.addFacilitator(GHO_DIRECT_MINTER, "HorizonGhoDirectMinter", 1M GHO).
  - Set GHO_DIRECT_MINTER as a controlled facilitator on GHO_BUCKET_STEWARD.

- Seed GHO Liquidity
  - Supply 1M GHO through GHO_DIRECT_MINTER.mintAndSupply

## References

- Horizon addresses

  - POOL_CONFIGURATOR: 0x83Cb1B4af26EEf6463aC20AFbAC9c0e2E017202F
  - PROTOCOL_DATA_PROVIDER: 0x53519c32f73fE1797d10210c4950fFeBa3b21504
  - ACL_MANAGER: 0xEFD5df7b87d2dCe6DD454b4240b3e0A4db562321
  - EMISSION_MANAGER: 0xC2201708289b2C6A1d461A227A7E5ee3e7fE9A2F
  - EMISSION_ADMIN: 0xac140648435d03f784879cd789130F22Ef588Fcd

- Tokens

  - Stablecoins:

    - GHO: 0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f
    - RLUSD: 0x8292Bb45bf1Ee4d140127049757C2E0fF06317eD
    - USDC: 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48

  - RWA:
    - USTB: 0x43415eB6ff9DB7E26A15b704e7A3eDCe97d31C4e
    - USCC: 0x14d60E7FDC0D71d8611742720E4C50E7a974020c
    - USYC: 0x136471a34f6ef19fE571EFFC1CA711fdb8E49f2b
    - JTRSY: 0x8c213ee79581Ff4984583C6a801e5263418C4b86
    - JAAA: 0x5a0F93D040De44e78F251b03c43be9CF317Dcf64

- GHO Roles

  - GHO_DIRECT_MINTER: 0xe10C78A3AC7f016eD2DE1A89c5479b1039EAB9eA
  - BUCKET_CAPACITY: 1_000_000e18

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/786b4930a2badb738cc76c30f147af69ade9453d/src/20250813_AaveV3Ethereum_HorizonRWAInstanceActivation/AaveV3Ethereum_HorizonRWAInstanceActivation_20250813.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/786b4930a2badb738cc76c30f147af69ade9453d/src/20250813_AaveV3Ethereum_HorizonRWAInstanceActivation/AaveV3Ethereum_HorizonRWAInstanceActivation_20250813.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xc69410600084e9d3d27e6569dddda08fc053182bcf402e3e612fc97cab783f24)
- [Discussion](https://governance.aave.com/t/arfc-horizon-s-rwa-instance/21898)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
