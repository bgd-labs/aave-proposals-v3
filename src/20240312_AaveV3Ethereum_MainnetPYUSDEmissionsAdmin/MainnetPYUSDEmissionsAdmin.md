---
title: "Mainnet PYUSD Emissions Admin"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-pyusd-on-aave-v3-ethereum-market/16837"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xac80b6d5488c4949e30013d8ed88189ed48b64cb47580bee46921b28e3899bb7"
---

## Simple Summary

This AIP proposes to set the Aave Chan Initiative (ACI) wallet as the emission manager for the PYUSD token on Aave V3 Ethereum Market. This will enable the ACI to enact incentive programs funded by ecosystem partners for all PYUSD markets, promoting growth and expanding the user base of Aave.

## Motivation

The Aave Chan Initiative (ACI) has been in discussion with various parties that have a desire to actively contribute to the growth and development of the Aave V3 on the Ethereum Network.

Recently, governance approved the [addition of PYUSD to Aave V3 Ethereum Market](https://governance.aave.com/t/arfc-add-pyusd-to-aave-v3-ethereum-market/16218). As a result, onboarding PYUSD into Aave has:

- Built synergies between Aave and PYUSD.
- Offered Aave users an additional stablecoin option.
- Strengthened the relationship between the PYUSD & the GHO stablecoin.

In order to facilitate emissions by various stakeholders, ACI proposes becoming the emissions manager for PYUSD on Aave V3 Ethereum Market. Emission incentives will be sent to ACI multisig and distributed as agreed on with partners. By setting the multisig as the emission manager for the PYUSD token, the ACI will be able to directly manage incentive programs that can attract more users to the pool and stimulate activity. This aligns with the broader goals of the Aave community to foster active and engaged markets on the Ethereum Chain.

## Specification

The Aave Chan Initiative (ACI) multisig address [0xac140648435d03f784879cd789130F22Ef588Fcd](https://app.safe.global/home?safe=eth:0xac140648435d03f784879cd789130F22Ef588Fcd) will be set as Emissions manager.

The call to the setEmissionAdmin() method in the emission_manager contract will be as follows:

`EMISSION_MANAGER.setEmissionAdmin(pyUSD,0xac140648435d03f784879cd789130F22Ef588Fcd);`

This method will set the Aave Chan Initiative (ACI) wallet as the emission admin for the PYUSD token on Aave V3 Ethereum Market.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240312_AaveV3Ethereum_MainnetPYUSDEmissionsAdmin/AaveV3Ethereum_MainnetPYUSDEmissionsAdmin_20240312.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240312_AaveV3Ethereum_MainnetPYUSDEmissionsAdmin/AaveV3Ethereum_MainnetPYUSDEmissionsAdmin_20240312.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xac80b6d5488c4949e30013d8ed88189ed48b64cb47580bee46921b28e3899bb7)
- [Discussion](https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-pyusd-on-aave-v3-ethereum-market/16837)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
