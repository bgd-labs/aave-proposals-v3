---
title: "Aave v3 EtherFi Ethereum Activation"
author: "Catapulta"
discussions: "https://governance.aave.com/t/arfc-deploy-an-etherfi-stablecoin-aave-v3-instance/18440"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x4acd11c6100a6b85a553e21359f3720fa5cd4783a76c77857436ace134f88c05"
---

## Simple Summary

This AIP activates an Aave v3 EtherFi instance in the Ethereum network, following [ARFQ request](https://governance.aave.com/t/arfc-deploy-an-etherfi-stablecoin-aave-v3-instance/18440), focused on weETH holders borrowing stablecoins.

## Motivation

The demand for borrowing wETH on Aave using weETH as collateral is extremely high, with caps being filled within minutes each week.

While this $2B growth is welcomed and responsible for ~$12.5M yearly revenue (at current ETH prices) for the DAO, it has created some frustration for significant users looking to borrow stablecoins using their weETH as collateral.

With this asset being constantly at cap, users are wary of leveraging Aave for this use case as they have legitimate concerns about their ability to add more collateral/debt to (de)leverage following market conditions.

To provide weETH holders with more suitable options, we propose creating a dedicated weETH/stablecoin Aave v3 Instance.

This market also lays the groundwork for future integrations & synergies with EtherFi’s Cash product.

## Specification

The Etherfi/Stables Aave v3 instance activation payload implements the following:

- Pre-execution:
  - Register Ethereum EtherFi instance in Ethereum V3 PoolAddressesProviderRegistry with ID 45.
- Execution:
  - Listing of weETH, USDC, PYUSD, and FRAX tokens.
- Post execution:
  - Add PROTOCOL_GUARDIAN as POOL_ADMIN role
  - Add CAPS_PLUS_RISK_STEWARD as RISK_ADMIN role
  - Seed amounts
  - Pay Catapulta service fee

The table below illustrates the configured risk parameters\* for Aave v3 EtherFi Ethereum instance:

| Parameter                 |                                      weETH |                                       USDC |                                      PYUSD |                                       FRAX |
| ------------------------- | -----------------------------------------: | -----------------------------------------: | -----------------------------------------: | -----------------------------------------: |
| Isolation Mode            |                                      false |                                      false |                                      false |                                      false |
| Borrowable                |                                   DISABLED |                                    ENABLED |                                    ENABLED |                                    ENABLED |
| Collateral Enabled        |                                       true |                                      false |                                      false |                                      false |
| Supply Cap                |                                     50,000 |                                140,000,000 |                                 60,000,000 |                                 15,000,000 |
| Borrow Cap                |                                          0 |                                135,000,000 |                                 54,000,000 |                                 12,000,000 |
| Debt Ceiling              |                                      USD 0 |                                      USD 0 |                                      USD 0 |                                      USD 0 |
| LTV                       |                                       78 % |                                        0 % |                                        0 % |                                        0 % |
| LT                        |                                       81 % |                                        0 % |                                        0 % |                                        0 % |
| Liquidation Bonus         |                                        6 % |                                        0 % |                                        0 % |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |                                \*\*\* 10 % |                                       10 % |                                       10 % |
| Reserve Factor            |                                  \*\* 45 % |                                       10 % |                                       20 % |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |                                        0 % |                                        0 % |                                        0 % |
| Variable Slope 1          |                                   \*\* 7 % |                                      6.5 % |                                      5.5 % |                                      5.5 % |
| Variable Slope 2          |                                 \*\* 300 % |                                       60 % |                                       80 % |                                       80 % |
| Uoptimal                  |                                  \*\* 35 % |                                       90 % |                                       90 % |                                       90 % |
| Stable Borrowing          |                                   DISABLED |                                   DISABLED |                                   DISABLED |                                   DISABLED |
| Flashloanable             |                                    ENABLED |                                    ENABLED |                                    ENABLED |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |                                   DISABLED |                                   DISABLED |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |                                   DISABLED |                                   DISABLED |                                   DISABLED |
| Oracle                    | 0xf112aF6F0A332B815fbEf3Ff932c057E570b62d3 | 0x736bF902680e68989886e9807CD7Db4B3E015d3C | 0x150bAe7Ce224555D39AfdBc6Cb4B8204E594E022 | 0x45D270263BBee500CF8adcf2AbC0aC227097b036 |

\* The risk parameters follows latest [Chaos Labs recommendation](https://governance.aave.com/t/arfc-deploy-an-etherfi-stablecoin-aave-v3-instance/18440/10).

\*\* Deviation of risk params for `weETH` from original ARFQ due "0" is not a valid value for `RESERVE_FACTOR, Uoptimal, Variable Slope 1, Variable Slope 2` and causes payload to fail due validation errors. The updates values are from Aave V3 Ethereum Mainnet market and this does NOT enable the token as borrowable.

\*\*\* Deviation of risk param "Liquidation Protocol Fee" for `USDC`, set to "10%" to keep constistency from the rest of tokens. This change does not affect due USDC token will not have collateral enabled.

## References

- Implementation: [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/3190d5b947d8e5185260a1d2ed93049a81fa3d26/src/20240902_AaveV3EthereumEtherFi_EtherFiEthereumActivation/AaveV3EthereumEtherFi_EtherFiEthereumActivation_20240902.sol)
- Tests: [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/3190d5b947d8e5185260a1d2ed93049a81fa3d26/src/20240902_AaveV3EthereumEtherFi_EtherFiEthereumActivation/AaveV3EthereumEtherFi_EtherFiEthereumActivation_20240902.t.sol)
- [Catapulta deployment report](https://catapulta.sh/report/719c68e7-9829-455d-a580-b5c93b25812a)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x4acd11c6100a6b85a553e21359f3720fa5cd4783a76c77857436ace134f88c05)
- [Discussion](https://governance.aave.com/t/arfc-deploy-an-etherfi-stablecoin-aave-v3-instance/18440)
- [Code diff between EtherFi and Lido Aave V3 instances](https://diffy.org/diff/499d8ea81137d)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
