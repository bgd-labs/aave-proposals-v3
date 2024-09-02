---
title: "EtherFi Ethereum Activation"
author: "Catapulta"
discussions: "https://governance.aave.com/t/arfc-deploy-an-etherfi-stablecoin-aave-v3-instance/18440"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x4acd11c6100a6b85a553e21359f3720fa5cd4783a76c77857436ace134f88c05"
---

## Simple Summary

This AIP activates the EtherFi and Stables Aave V3 instance in Ethereum network, following [ARFQ request](https://governance.aave.com/t/arfc-deploy-an-etherfi-stablecoin-aave-v3-instance/18440).

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

The table below illustrates the configured risk parameters for **weETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (weETH)        |                                     50,000 |
| Borrow Cap (weETH)        |                                          0 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       78 % |
| LT                        |                                       81 % |
| Liquidation Bonus         |                                        6 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor \*\*       |                                       45 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1 \*\*     |                                        7 % |
| Variable Slope 2 \*\*     |                                      300 % |
| Uoptimal \*\*             |                                       35 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xf112aF6F0A332B815fbEf3Ff932c057E570b62d3 |

\*\* Deviation of risk params for `weETH` from original ARFQ due 0 is not a valid value for `RESERVE_FACTOR, Uoptimal, Variable Slope 1, Variable Slope 2` and causes payload to fail due validation errors. The updates values are from Aave V3 Ethereum Mainnet market and this does NOT enable the token as borrowable.

The table below illustrates the configured risk parameters for **USDC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDC)         |                                140,000,000 |
| Borrow Cap (USDC)         |                                135,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                        0 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      6.5 % |
| Variable Slope 2          |                                       60 % |
| Uoptimal                  |                                       90 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x736bF902680e68989886e9807CD7Db4B3E015d3C |

The table below illustrates the configured risk parameters for **PYUSD**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (PYUSD)        |                                 60,000,000 |
| Borrow Cap (PYUSD)        |                                 15,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      5.5 % |
| Variable Slope 2          |                                       80 % |
| Uoptimal                  |                                       90 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x150bAe7Ce224555D39AfdBc6Cb4B8204E594E022 |

The table below illustrates the configured risk parameters for **FRAX**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (FRAX)         |                                 54,000,000 |
| Borrow Cap (FRAX)         |                                 12,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      5.5 % |
| Variable Slope 2          |                                       80 % |
| Uoptimal                  |                                       90 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x45D270263BBee500CF8adcf2AbC0aC227097b036 |

## References

- Implementation: [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240902_AaveV3EthereumEtherFi_EtherFiEthereumActivation/AaveV3EthereumEtherFi_EtherFiEthereumActivation_20240902.sol)
- Tests: [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240902_AaveV3EthereumEtherFi_EtherFiEthereumActivation/AaveV3EthereumEtherFi_EtherFiEthereumActivation_20240902.t.sol)
- [Catapulta deployment report](https://catapulta.sh/report/719c68e7-9829-455d-a580-b5c93b25812a)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x4acd11c6100a6b85a553e21359f3720fa5cd4783a76c77857436ace134f88c05)
- [Discussion](https://governance.aave.com/t/arfc-deploy-an-etherfi-stablecoin-aave-v3-instance/18440)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
