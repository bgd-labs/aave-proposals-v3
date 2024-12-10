---
title: "Onboard GHO and Migrate Streams to Prime Instance"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-onboard-gho-and-migrate-streams-to-lido-instance/19686"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x5c27aa8f1de66a3e56f535d60e4c1666a5617a36f8f81c09df2b0ea184a90290"
---

## Simple Summary

This publication proposes the following:

- Onboarding GHO to the Prime instance of Aave v3 with 3M seed from Collector;
- Acquire 3M GHO from spot market and send to the Collector
- Migrate Merit allowance
- Cancel AGD GHO allowance

## Motivation

### Onboard GHO Prime Instance with 3M seed from Collector

With the circulating supply nearing 180M and nearly 50M in DEX liquidity on Ethereum, this publication proposes adding GHO to the Prime instance of Aave v3.

Adding GHO to the Prime instance of Aave v3 would provide the DAO with several opportunities:

- Mint GHO through a Facilitator and deposit it into the Reserve to generate revenue;
- Enable Aave DAO to earn yield on existing GHO holdings; and,
- Establish a GHO reserve that provides an organic deposit yield.

Each of these options offers clear advantages for the Aave DAO and GHO users. GHO is to be onboarded as a borrow-only asset, similar to the current configurations of USDC and USDS.

The seeded 3M GHO should be sufficient to sustain two months of Merit, with a sufficient buffer to ensure timely fund withdrawals. Allowance will be migrated from Core to Prime market.

### Acquire GHO from spot market and send to the collector

3M GHO is to be acquired from spot market and sent to the Collector.

Within this publication, the Aave Grants DAO GHO Allowance is to be cancelled.

## Specification

The below details the parameter configuration of the GHO Reserve on the Prime instance of Aave v3.

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                      false |
| Supply Cap (GHO)          |                                 20,000,000 |
| Borrow Cap (GHO)          |                                  2,500,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                        0 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                    10.50 % |
| Variable Slope 1          |                                     3.00 % |
| Variable Slope 2          |                                       50 % |
| Uoptimal                  |                                       92 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xD110cac5d8682A3b045D5524a9903E031d70FCCd |

GHO is to be included in the sUSDe and ezETH eMode as shown below:

**sUSDe eMode**

|       Parameter       | Value | Value | Value | Value |
| :-------------------: | :---: | :---: | :---: | :---: |
|         Asset         | sUSDe | USDS  | USDC  |  GHO  |
|      Collateral       |  Yes  |  No   |  No   |  No   |
|      Borrowable       |  No   |  Yes  |  Yes  |  Yes  |
|        Max LTV        |  90%  |   -   |   -   |   -   |
| Liquidation Threshold |  92%  |   -   |   -   |   -   |
|   Liquidation Bonus   | 3.0%  |   -   |   -   |   -   |

**ezETH eMode**

|       Parameter       | Value | Value | Value | Value |
| :-------------------: | :---: | :---: | :---: | :---: |
|         Asset         | ezETH | USDS  | USDC  |  GHO  |
|      Collateral       |  Yes  |  No   |  No   |  No   |
|      Borrowable       |  No   |  Yes  |  Yes  |  Yes  |
|        Max LTV        |  75%  |   -   |   -   |   -   |
| Liquidation Threshold |  80%  |   -   |   -   |   -   |
|   Liquidation Bonus   | 7.5%  |   -   |   -   |   -   |

This proposal includes swap the following asset for GHO:

|  Asset Holding  |
| :-------------: |
|  aUSDT (1.5M)   |
| aEthUSDT (0.5M) |
| aEthUSDC (1.0M) |

Cancel Aave Grants DAO GHO [Allowance](https://governance.aave.com/t/update-from-aave-grants-winding-down-agd-1-0-and-what-s-next/18707).

Migrate Merit allowance from Core to Prime market.

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/2ccea23f34b42c480651aa629f810783e273b83f/src/20241104_AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance/AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/2ccea23f34b42c480651aa629f810783e273b83f/src/20241104_AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance/AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x5c27aa8f1de66a3e56f535d60e4c1666a5617a36f8f81c09df2b0ea184a90290)
- [Discussion](https://governance.aave.com/t/arfc-onboard-gho-and-migrate-streams-to-lido-instance/19686)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
