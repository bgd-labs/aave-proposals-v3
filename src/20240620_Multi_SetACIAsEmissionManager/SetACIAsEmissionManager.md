---
title: "Set ACI as Emission Manager for Aave Liquidity Mining programs"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898#arfc-set-aci-as-emission-manager-for-liquidity-mining-programs-1"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x364de11d3a298f2c76721a8926cb32823cc29d0a95eadecbc0a98c628a38194b"
---

## Simple Summary

The current ARFC proposes to appoint the Aave Chan Initiative (ACI) as the Emission Manager for liquidity mining programs across Aave instances. This will enable ACI to manage incentive programs funded by different partners, with the purpose of stimulating market activity and growth.

## Motivation

Liquidity mining programs are essential for attracting liquidity providers by offering rewards for their participation. Effective management of these programs is crucial for the sustained growth of the Aave Ecosystem. Therefore, ACI, with its extensive experience and strategic partnerships, is well-positioned to manage these emissions effectively.

A recent example is the [Long Term Incentive Program (LTIPP)](https://forum.arbitrum.foundation/t/aave-ltipp-application-final/21741) from Arbitrum DAO, where Aave DAO will receive 750,000 ARB tokens, illustrating the benefits of coordinated emission management.

## Specification

- Appointment of ACI as Emission Manager for Liquidity Mining Programs

1. ACI will be authorized to manage Emission Programs for Liquidity Mining across Aave Markets.
2. ACI’s multisig address will be the one receiving and distributing emissions on behalf of the DAO.

- Appointment of ACI as coordinator with ecosystem partners, to define and implement emission strategies, managing the distribution of rewards to liquidity providers, and monitor & adjust emissions based on market performance.
- Integration of Liquidity mining program as part of “Dolce Vita” service of the ACI at no extra cost for the DAO.
- Make the ACI multisig the emission manager for ARB on Arbitrum
- Make the ACI multisig the emission manager for SD on Ethereum

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240620_Multi_SetACIAsEmissionManager/AaveV3Ethereum_SetACIAsEmissionManager_20240620.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240620_Multi_SetACIAsEmissionManager/AaveV3Arbitrum_SetACIAsEmissionManager_20240620.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240620_Multi_SetACIAsEmissionManager/AaveV3Ethereum_SetACIAsEmissionManager_20240620.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240620_Multi_SetACIAsEmissionManager/AaveV3Arbitrum_SetACIAsEmissionManager_20240620.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x364de11d3a298f2c76721a8926cb32823cc29d0a95eadecbc0a98c628a38194b)
- [Discussion](https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898#arfc-set-aci-as-emission-manager-for-liquidity-mining-programs-1)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
