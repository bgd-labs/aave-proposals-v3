---
title: "Set Aave Chan Initiative as Emission Manager for fdUSD on BNB Chain Aave V3"
author: " Aave Chan Initiative (ACI)"
discussions: "https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-fdusd-on-bnb-chain-aave-v3/16558"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x4db0fe8cb6c21abd34e4d38836db72ed7f1b06c91386ec9e637df8786a289d0d"
---

## Simple Summary

This ARFC proposes to set the Aave Chan Initiative (ACI) wallet as the emission manager for the fdUSD token on BNB Chain Aave V3 markets. This will enable the ACI to enact incentive programs funded by BNB Chain ecosystem partners for all fdUSD markets, promoting growth and expanding the user base of Aave on the BNB Chain.

## Motivation

The Aave Chan Initiative has been in discussion with various parties that have a desire to actively contribute to the growth and development of the Aave V3 on the BNB Chain. In order to facilitate emissions by various stakeholders, ACI proposes becoming the emissions manager for fdUSD on BNB Chain. Emission incentives will be sent to ACI multisig and distributed as agreed on with partners. By setting the multisig as the emission manager for the fdUSD token, the ACI will be able to directly manage incentive programs that can attract more users to the pool and stimulate activity. This aligns with the broader goals of the Aave community to foster active and engaged markets on the BNB Chain.

## Specification

The ACI multisig address bnb:0xac140648435d03f784879cd789130F22Ef588Fcd will be set as Emissions manager.

The call to the setEmissionAdmin() method in the emission_manager contract will be as follows:

EMISSION_MANAGER.setEmissionAdmin(fdUSD, 0xac140648435d03f784879cd789130F22Ef588Fcd);

This method will set the ACI multisig as the emission admin for the fdUSD token on BNB Chain Aave V3 markets.

## References

- Implementation: [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/b43ea63eb57a498f1690a930f2faf822c2ed26c3/src/20240208_AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3/AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208.sol)
- Tests: [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/b43ea63eb57a498f1690a930f2faf822c2ed26c3/src/20240208_AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3/AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x4db0fe8cb6c21abd34e4d38836db72ed7f1b06c91386ec9e637df8786a289d0d)
- [Discussion](https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-fdusd-on-bnb-chain-aave-v3/16558)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
