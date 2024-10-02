---
title: "Set ACI as Emission Manager for USDS, aUSDS and awstETH"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898/18"
snapshot: "Direct-To-AIP"
---

## Simple Summary

This AIP proposes to appoint the Aave-Chan Initiative (ACI) as the Emission Manager for USDS, aUSDS and awstETH on Aave Ethereum Main & Lido instances.

## Motivation

Liquidity mining programs are essential for attracting liquidity providers by offering rewards for their participation. Effective management of these programs is crucial for the sustained growth of the Aave Ecosystem. Therefore, with its extensive experience and strategic partnerships, ACI is well-positioned to manage these emissions effectively.

To support Aave & Sky ecosystem synergies, The ACI will manage liquidity mining programs for USDS suppliers on Aave.

This proposal also seeks to allow wstETH suppliers on the lido instance to receive incentives in line with the Ahab Program

## Specification

The ACI multisig address will be set as the emission manager via the setEmissionAdmin() method in the relevant emission manager contracts for USDS & aUSDS.

ACI multisig address: 0xac140648435d03f784879cd789130F22Ef588Fcd
USDS: [0xdC035D45d973E3EC169d2276DDab16f1e407384F](https://etherscan.io/address/0xdC035D45d973E3EC169d2276DDab16f1e407384F)
aEthUSDS*: [0x32a6268f9Ba3642Dda7892aDd74f1D34469A4259](https://etherscan.io/address/0x32a6268f9Ba3642Dda7892aDd74f1D34469A4259)
aEthLidoUSDS*: [0x09AA30b182488f769a9824F15E6Ce58591Da4781](https://etherscan.io/address/0x09AA30b182488f769a9824F15E6Ce58591Da4781)
Aave Emission Manager contract on Ethereum: [0x223d844fc4B006D67c0cDbd39371A9F73f69d974](https://etherscan.io/address/0x223d844fc4B006D67c0cDbd39371A9F73f69d974)

- This payload requires the [AIP-175](https://vote.onaave.com/proposal/?proposalId=175&ipfsHash=0xe2efa3b07ac0333e5b8f6b57377a4ace8d43add290b780ac9924d6131ae797f7)
  to be executed to allow aEthUSDS & aEthLidoUSDS creation

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240929_AaveV3Ethereum_SetACIAsEmissionManagerForUSDSAndAUSDS/AaveV3Ethereum_SetACIAsEmissionManagerForUSDSAndAUSDS_20240929.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240929_AaveV3Ethereum_SetACIAsEmissionManagerForUSDSAndAUSDS/AaveV3Ethereum_SetACIAsEmissionManagerForUSDSAndAUSDS_20240929.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898/18)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
