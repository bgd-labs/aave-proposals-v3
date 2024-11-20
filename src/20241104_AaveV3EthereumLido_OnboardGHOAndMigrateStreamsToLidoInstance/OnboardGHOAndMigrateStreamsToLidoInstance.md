---
title: "Onboard GHO and Migrate Streams to Lido Instance"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-onboard-gho-and-migrate-streams-to-lido-instance/19686"
snapshot: "TBD"
---

## Simple Summary

This publication proposes the following:

- Onboarding GHO to the Lido instance of Aave v3;
- Providing initial GHO liquidity from the Treasury; and,
- Migrating Service Providers streams to GHO from Lido instance.

## Motivation

### Onboard GHO Lido Instance

With the circulating supply nearing 180M and nearly 50M in DEX liquidity on Ethereum, this publication proposes adding GHO to the Lido instance of Aave v3.

Adding GHO to the Lido instance of Aave v3 would provide the DAO with several opportunities:

- Mint GHO through a Facilitator and deposit it into the Reserve to generate revenue;
- Enable Aave DAO to earn yield on existing GHO holdings; and,
- Establish a GHO reserve that provides an organic deposit yield.

Each of these options offers clear advantages for the Aave DAO and GHO users. GHO is to be onboarded as a borrow-only asset, similar to the current configurations of USDC and USDS.

### Deploy GHO from Treasury

From observing the USDC reserve on the Lido instance, it is apparent that GHO would benefit from some initial liquidity. With passive GHO held in the Treasury, this publication proposes depositing available GHO into the new Reserve. With the GHO expected to earn a yield the DAO will benefit from a new revenue source.

A separate proposal will recommend minting and depositing GHO into the new reserve via a new Facilitator on Ethereum to futher help bootstrap the reserve. The addition of sUSDe to the Lido instance is expected to provide strong demand for stablecoin debt.

### Migrate Service Provider Streams

With the GHO being deployed into Lido, several Aave DAO service provider streams are to be amended to draw GHO from Lido instance.

- Chaos Labs;
- Aave Labs;
- LlamaRisk; and,
- Aave Chan Initiative.

When the AIP is submitted, new streams will be created to replace the streams being cancelled. With several streams are soon to expire during December, these streams are not migrated to Lido instance and sufficient GHO will remain in the treasury to facilitate payment to these teams.

Within this publication, the Aave Grants DAO GHO Allowance is to be cancelled.

## Specification

The below details the parameter configuration of the GHO Reserve on the Lido instance of Aave v3.

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (GHO)          |                                 20,000,000 |
| Borrow Cap (GHO)          |                                  2,500,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                     4.50 % |
| Variable Slope 1          |                                     3.00 % |
| Variable Slope 2          |                                       50 % |
| Uoptimal                  |                                       92 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xD110cac5d8682A3b045D5524a9903E031d70FCCd |

The below table shows the GHO balance at time of writing for reference only:

| Treasury Assert |                                                              Holding                                                               |
| :-------------- | :--------------------------------------------------------------------------------------------------------------------------------: |
| GHO             | [7,295,678.65](https://etherscan.io/token/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f?a=0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c) |

Note: The September funding update is to acquire GHO and transfer 5M GHO to Arbitrum to be deployed into the GHO reserve to earn yield.

Sufficient GHO shall remain in the Treasury to support streams with a 2024 expiry date, with the balance to be deposited into the Lido instance of Aave v3. This will be confirmed and detailed in the comments just prior to submission of the AIP.

The following Service Provider streams are to be migrated to using GHO from the Lido instance.

| Service Provider     | StreamID |
| :------------------- | :------: |
| Aave Chan Initiative |  100034  |
| Aave Labs            |  100039  |
| Chaos Labs           |  100046  |
| LlamaRisk            |  100048  |

Cancel Aave Grants DAO GHO [Allowance](https://governance.aave.com/t/update-from-aave-grants-winding-down-agd-1-0-and-what-s-next/18707).

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241104_AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance/AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241104_AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance/AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104.t.sol)
- [Snapshot](TBD)
- [Discussion](https://governance.aave.com/t/arfc-onboard-gho-and-migrate-streams-to-lido-instance/19686)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
