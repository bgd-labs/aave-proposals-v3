---
title: "Optimism susd Emission Admin"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-susd-on-aave-v3-optimism/16867"
snapshot: "https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-susd-on-aave-v3-optimism/16867"
---

## Simple Summary

This AIP proposes to set the Aave Chan Initiative (ACI) wallet as the emission manager for the sUSD token on Optimism Aave V3 market. This will enable the ACI to enact incentive programs funded by SNX ecosystem partners for all sUSD markets, promoting growth and expanding the user base of Aave on Optimism.

## Motivation

The Aave Chan Initiative has been in discussion with various parties that have a desire to actively contribute to the growth and development of Aave V3 on Optimism. In order to facilitate emissions by various stakeholders, ACI proposes becoming the emissions manager for sUSD on Optimism. Emission incentives will be sent to ACI multisig and distributed as agreed on with partners.

By setting the multisig as the emission manager for the sUSD token, the ACI will be able to directly manage incentive programs that can attract more users to the protocol and stimulate activity. This aligns with the broader goals of the Aave community to foster active and engaged markets on Optimism.

## Specification

The ACI multisig address OP:[0xac140648435d03f784879cd789130F22Ef588Fcd](https://optimistic.etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) will be set as Emissions manager.

The call to the setEmissionAdmin() method in the emission_manager contract will be as follows:

`EMISSION_MANAGER.setEmissionAdmin(sUSD, 0xac140648435d03f784879cd789130F22Ef588Fcd);`

This method will set the ACI multisig as the emission admin for the sUSD token on Optimism Aave V3 market.

## References

- Implementation: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/8810a7cd06432a6e77fc2669676323b07fa870bd/src/20240312_AaveV3Optimism_OptimismSusdEmissionAdmin/AaveV3Optimism_OptimismSusdEmissionAdmin_20240312.sol)
- Tests: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/8810a7cd06432a6e77fc2669676323b07fa870bd/src/20240312_AaveV3Optimism_OptimismSusdEmissionAdmin/AaveV3Optimism_OptimismSusdEmissionAdmin_20240312.t.sol)
- [Snapshot](https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-susd-on-aave-v3-optimism/16867)
- [Discussion](https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-susd-on-aave-v3-optimism/16867)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
