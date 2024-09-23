---
title: "Set ACI as Emission Manager for wstETH"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898/16"
---

## Simple Summary

This AIP proposes to appoint the Aave-Chan Initiative (ACI) as the Emission Manager for wstETH.

## Motivation

Liquidity mining programs are essential for attracting liquidity providers by offering rewards for their participation. Effective management of these programs is crucial for the sustained growth of the Aave Ecosystem. Therefore, with its extensive experience and strategic partnerships, ACI is well-positioned to manage these emissions effectively.

To extend Lido Instance growth, the ACI proposes setting its multisig as the emission manager for wstETH on the Lido instance. This is meant to kickstart a wstETH supply incentives program to prepare the ground for Liquid e-mode with LRTs on this instance.

## Specification

The ACI multisig address will be set as the emission manager via the setEmissionAdmin() method in the relevant emission manager contracts for wstETH.

ACI multisig address: 0xac140648435d03f784879cd789130F22Ef588Fcd
wstETH: [0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0)
Aave Emission Manager contract on Ethereum: [0x223d844fc4B006D67c0cDbd39371A9F73f69d974](https://etherscan.io/address/0x223d844fc4B006D67c0cDbd39371A9F73f69d974)

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240923_AaveV3EthereumLido_SetACIAsEmissionManagerForWstETH/AaveV3EthereumLido_SetACIAsEmissionManagerForWstETH_20240923.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240923_AaveV3EthereumLido_SetACIAsEmissionManagerForWstETH/AaveV3EthereumLido_SetACIAsEmissionManagerForWstETH_20240923.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898/16)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
