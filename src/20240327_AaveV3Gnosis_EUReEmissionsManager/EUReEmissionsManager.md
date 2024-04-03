---
title: "EURe Emissions Manager"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-set-aci-as-emissions-manager-for-eure-on-aave-v3-gnosis-market/17130"
---

## Simple Summary

This ARFC proposes a direct-to-AIP vote to appoint the Aave Chan Initiative (ACI) as the emissions manager for the EURe token on Aave V3 Gnosis Market.

## Motivation

The Aave Chan Initiative (ACI) has been engaging with several entities interested in contributing actively to the growth and development of Aave V3 on the Gnosis Network.

To streamline emissions from various stakeholders, ACI proposes to take on the role of emissions manager for EURe on Aave V3 Gnosis Market. Emission incentives will be directed to the ACI multisig and distributed as per agreements with partners. This will empower the ACI to implement incentive schemes, backed by ecosystem collaborators, for EURe. The goal is to drive growth and broaden the user base of Aave.

Per the [Emissions Manager Framework ](https://governance.aave.com/t/arfc-emission-manager-framework-update/16884), this proposal will be escalated straight to AIP voting after a period of discussion.

## Specification

The Aave Chan Initiative (ACI) multisig address 0xac140648435d03f784879cd789130F22Ef588Fcd will be set as Emissions manager.

The call to the setEmissionAdmin() method in the emission_manager contract will be as follows:

EMISSION_MANAGER.setEmissionAdmin(EURe,0xac140648435d03f784879cd789130F22Ef588Fcd);

This method will appoint the Aave Chan Initiative (ACI) wallet as the emissions admin for the EURe token on Aave V3 Gnosis Market.

## References

- Implementation: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/b996197773b566b6ebd3a9f82e2abbcf118f0d09/src/20240327_AaveV3Gnosis_EUReEmissionsManager/AaveV3Gnosis_EUReEmissionsManager_20240327.sol)
- Tests: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/b996197773b566b6ebd3a9f82e2abbcf118f0d09/src/20240327_AaveV3Gnosis_EUReEmissionsManager/AaveV3Gnosis_EUReEmissionsManager_20240327.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-set-aci-as-emissions-manager-for-eure-on-aave-v3-gnosis-market/17130)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
