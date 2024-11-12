---
title: "PYUSD Reserve Configuration Update & Incentive Campaign"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-pyusd-reserve-configuration-update-incentive-campaign/19573"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xcd73f17361c7757cd94ec758b4d9f160b7cecefa7f4cb23b0b4ee49b5eb1b8b2"
---

## Simple Summary

This publication proposes amendments to the PYUSD Reserve in preparation for an upcoming incentive campaign.

Additionally, a co-incentive campaign is to be implemented to improve the PYUSD and GHO liquidity.

## Motivation

Trident Digital with support from PayPal, presents the Aave DAO with an opportunity to promote the adoption of PYUSD on Aave Protocol and PYUSD/GHO liquidity on Balancer for an initial 6 month period.

Eligible Aave Protocol users are expected to receive up to 4.00% APR in Liquidity Mining (LM) rewards made available by Trident Digital on behalf of PayPal. The PYUSD reserve on Aave v3 is to be adjusted to align with the objectives of the PYUSD incentive campaign. Further details can be found on the governance forum.

### PYUSD/GHO Liquidity

As part of the PYUSD growth iniative, a 8M PYUSD/GHO Elliptic Liquidity Pool (ECLP) with an asymmetric concentrated liquidity profile will be used on Balancer.

The pool will be funded and supported for an initial 6 month period with an additional 300k GHO made available to the ALC.

## Specification

The following PYUSD Reserve parameters are to be updated:

| Parameter                | PYUSD  |
| ------------------------ | ------ |
| Borrowable               | Yes    |
| Collateral               | Yes    |
| Borrow Cap               | 15M    |
| LTV                      | 75.00% |
| LT                       | 78.00% |
| Liquidation Penalty      | 7.50%  |
| Liquidation Protocol Fee | 10.00% |

Create 300k GHO Allowance for the ALC SAFE.

ALC SAFE: `0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b`
GHO: `0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f`

Whilst not expected to be needed, in case aEthPYUSD Liquidity Mining rewards are to be distributed across Aave v3, the ACI is to be granted sufficient permission to do so.

EMISSION_MANAGER.setEmissionAdmin(`PYUSD`,`ACI Treasury`)
EMISSION_MANAGER.setEmissionAdmin(`aEthPYUSD`,`ACI Treasury`)

PYUSD: `0x6c3ea9036406852006290770BEdFcAbA0e23A0e8`
aEthPYUSD: `0x0C0d01AbF3e6aDfcA0989eBbA9d6e85dD58EaB1E`
ACI Treasury: `0xac140648435d03f784879cd789130F22Ef588Fcd`

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241031_AaveV3Ethereum_PYUSDReserveConfigurationUpdateIncentiveCampaign/AaveV3Ethereum_PYUSDReserveConfigurationUpdateIncentiveCampaign_20241031.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241031_AaveV3Ethereum_PYUSDReserveConfigurationUpdateIncentiveCampaign/AaveV3Ethereum_PYUSDReserveConfigurationUpdateIncentiveCampaign_20241031.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xcd73f17361c7757cd94ec758b4d9f160b7cecefa7f4cb23b0b4ee49b5eb1b8b2)
- [Discussion](https://governance.aave.com/t/arfc-pyusd-reserve-configuration-update-incentive-campaign/19573)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
