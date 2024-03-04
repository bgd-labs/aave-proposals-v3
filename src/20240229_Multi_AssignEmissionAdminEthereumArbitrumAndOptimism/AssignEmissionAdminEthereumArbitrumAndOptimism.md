---
title: "Assign Emission Admin - Ethereum, Arbitrum and Optimism"
author: "karpatkey-TokenLogic & ACI"
discussions: "https://governance.aave.com/t/arfc-set-op-emission-admin/16621"
---

## Simple Summary

This enables various teams to distribute rewards across Aave v3 Ethereum.

## Motivation

This AIP integrates four separate ARFC that each propose granting a team the privileges to distribute there chosen asset across an Aave v3 deployment. The below summaries each initiative:

- ETHx & SD rewards by Stader Labs
- osETH & SWISE by Stakewise DAO
- OP reward via an Aave Community SAFE
- ARB rewards via Gauntlet

The two LST providers are intending on using rewards to bootstrap the growth and adoption of there resepective LST.

The OP and ARB incentives are being distributed with the intent of migrating USDC.e to USDC on each respective network. These ARB and OP rewards were originally provide by the respective foundation and are not those belonging to the Aave DAO.

## Specification

The `setEmissionAdmin`, a governance controlled function, assigns the `EMISSION_ADMIN` role for a specified token on the respective network.

The `EMISSION_ADMIN` role controls the distribution of the specified token across the specified Aave v3 deployment.

The `EMISSION_ADMIN` can distribute the specified token anywhere across the Aave v3 deployment on the respective Liquidity Pool.

## Implementation

Set `EMISSION_ADMIN` permission for ETHx, SD, SWISE, osETH, OP and ARB to the following address:

**Aave v3 Ethereum**

Address Reward (SD): [0x30D20208d987713f46DFD34EF128Bb16C404D10f](https://etherscan.io/address/0x30D20208d987713f46DFD34EF128Bb16C404D10f)
Address Reward (ETHx): [0xA35b1B31Ce002FBF2058D22F30f95D405200A15b](https://etherscan.io/address/0xA35b1B31Ce002FBF2058D22F30f95D405200A15b)
SD & ETHx EMISSION_ADMIN: [0xbDa6C9cd7eD043CB739ca2C748dAbd1fCA397132](https://etherscan.io/address/0xbDa6C9cd7eD043CB739ca2C748dAbd1fCA397132)

Address Reward (SWISE): [0x48C3399719B582dD63eB5AADf12A40B4C3f52FA2](https://etherscan.io/address/0x48C3399719B582dD63eB5AADf12A40B4C3f52FA2)
Address Reward (osETH): [0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38](https://etherscan.io/address/0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38)
SWISE & osETH EMISSION_ADMIN:[0x189Cb93839AD52b5e955ddA254Ed7212ae1B1f61](https://etherscan.io/address/0x189Cb93839AD52b5e955ddA254Ed7212ae1B1f61)

**Aave v3 Arbitrum**

Address Reward (ARB): [0x912CE59144191C1204E64559FE8253a0e49E6548](https://arbiscan.io/address/0x912CE59144191C1204E64559FE8253a0e49E6548)
EMISSION_ADMIN: [0xE79C65a313a1f4Ca5D1d15414E0c515056dA90b4](https://arbiscan.io/address/0xE79C65a313a1f4Ca5D1d15414E0c515056dA90b4)

**Aave v3 Optimism**

Address Reward (OP): [0x4200000000000000000000000000000000000042](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000042)
EMISSION_ADMIN: [0x3479CEb4b1fcaDC586d4c5F1c16b4d8c0D70Bc71](https://optimistic.etherscan.io/address/0x3479CEb4b1fcaDC586d4c5F1c16b4d8c0D70Bc71)

The AIP calls setEmissionAdmin() method in the EMISSION_MANAGER contract.

EMISSION_MANAGER.setEmissionAdmin(REWARD_ASSET,EMISSION_ADMIN);

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/232ceaea2e9eb0b3e9dd7f2f8ba01f94c8abea15/src/20240229_Multi_AssignEmissionAdminEthereumArbitrumAndOptimism/AaveV3Ethereum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/232ceaea2e9eb0b3e9dd7f2f8ba01f94c8abea15/src/20240229_Multi_AssignEmissionAdminEthereumArbitrumAndOptimism/AaveV3Optimism_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/232ceaea2e9eb0b3e9dd7f2f8ba01f94c8abea15/src/20240229_Multi_AssignEmissionAdminEthereumArbitrumAndOptimism/AaveV3Arbitrum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/232ceaea2e9eb0b3e9dd7f2f8ba01f94c8abea15/src/20240229_Multi_AssignEmissionAdminEthereumArbitrumAndOptimism/AaveV3Ethereum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/232ceaea2e9eb0b3e9dd7f2f8ba01f94c8abea15/src/20240229_Multi_AssignEmissionAdminEthereumArbitrumAndOptimism/AaveV3Optimism_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/232ceaea2e9eb0b3e9dd7f2f8ba01f94c8abea15/src/20240229_Multi_AssignEmissionAdminEthereumArbitrumAndOptimism/AaveV3Arbitrum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229.t.sol)
- Snapshot: [SD + ETHx](https://snapshot.org/#/aave.eth/proposal/0x0d83730d546d74d463f045697e9ea6b1708b5c833a40e09e4f87f1804177f5a6), [SWISE + osETH](https://snapshot.org/#/aave.eth/proposal/0xe0579b1efa1f26237104632f4ccddac0158866a18061b27a634634fa9d31e250), [OP](https://snapshot.org/#/aave.eth/proposal/0x66040ad4d46ba756365fbe5c2ed5957d17a3e70db5a00ec532fdc725251d2327) and [ARB](https://snapshot.org/#/aave.eth/proposal/0x4518ee2130b2299fdf0827aa6a97b8211b3273f5b07b6f13b8141e5b9ad89e5f)
- Discussion: [SD + ETHx](https://governance.aave.com/t/arfc-set-ethx-and-sd-emission-admin-to-stader-labs/16599), [SWISE + osETH](https://governance.aave.com/t/arfc-set-oseth-swise-emission-admin-to-stakewise/16590), [OP](https://governance.aave.com/t/arfc-set-op-emission-admin/16621) and [ARB](https://governance.aave.com/t/arfc-set-arb-emission-admin-to-gauntlet/16554)

# Disclosure

TokenLogic, karpatkey and ACI receive no payment for this proposal. TokenLogic and karpatkey are both delegates within the Aave community.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
