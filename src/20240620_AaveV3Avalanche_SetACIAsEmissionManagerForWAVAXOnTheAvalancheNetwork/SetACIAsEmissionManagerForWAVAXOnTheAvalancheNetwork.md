---
title: "Set ACI as Emission Manager on the Avalanche network"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898/4"
---

## Simple Summary

Following coordination with the Avalanche Foundation, the ACI is requesting governance approval to appoint the ACI multisig to operate an LM program on the Avalanche network on their behalf.

## Motivation

Liquidity mining programs are essential for attracting liquidity providers by offering rewards for their participation. Effective management of these programs is crucial for the sustained growth of the Aave Ecosystem. Therefore, ACI, with its extensive experience and strategic partnerships, is well-positioned to manage these emissions effectively.

A recent example is the [Long Term Incentive Program (LTIPP) ](https://forum.arbitrum.foundation/t/aave-ltipp-application-final/21741) from Arbitrum DAO, where Aave DAO will receive 750,000 ARB tokens, illustrating the benefits of coordinated emission management.

## Specification

The ACI multisig address will be set as the emission manager via the **`setEmissionAdmin()`** method in the relevant emission manager contracts.

ACI multisig address: `0xac140648435d03f784879cd789130F22Ef588Fcd`

This method will appoint the Aave Chan Initiative (ACI) wallet as the emissions admin for the wAVAX, ggAVAX & sAVAX assets on the Avalanche network

## References

- Implementation: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240620_AaveV3Avalanche_SetACIAsEmissionManagerForWAVAXOnTheAvalancheNetwork/AaveV3Avalanche_SetACIAsEmissionManagerForWAVAXOnTheAvalancheNetwork_20240620.sol)
- Tests: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240620_AaveV3Avalanche_SetACIAsEmissionManagerForWAVAXOnTheAvalancheNetwork/AaveV3Avalanche_SetACIAsEmissionManagerForWAVAXOnTheAvalancheNetwork_20240620.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898/4)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
