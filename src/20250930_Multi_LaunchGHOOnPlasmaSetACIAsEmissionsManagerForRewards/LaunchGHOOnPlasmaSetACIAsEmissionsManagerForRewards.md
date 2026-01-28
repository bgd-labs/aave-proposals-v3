---
title: "Add GHO on Aave Plasma and deploy GSM on Plasma."
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-launch-gho-on-plasma-set-aci-as-emissions-manager-for-rewards/22994/6"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xeb3572580924976867073ad9c8012cb9e52093c76dafebd7d3aebf318f2576fb"
---

## Simple Summary

With the GHO lanes now activated on CCIP, this publication defines the launch parameters for GHO on Plasma, as well as the introduction of GSMs on Plasma.

## Motivation

This publicaiton presents the revised GHO parameter configuration for deploying the RemoteGSM and listing GHO on Aave Protocol. A joint collaboration program with Plasma, Maple Finance and Ethena, will be launched on Aave Protocol whilst separate and complimentary rewards programs will commence on Fluid and Balancer.

### GHO Supply

Within the new syrupUSDT and GHO collateral eMode, users who:

- Supply syrupUSDT and GHO (50% syrupUSDT:50% GHO), with a cap of 50% for GHO eligible for rewards (if additional GHO is supplied, it won't be rewarded)
- Borrow USDT and complete at least one leverage loop
- Maintain a health factor of less than 2.0

Will receive GHO incentives (~3.50%) such that the Total Supply yield (Native + Incentives) exceeds the native syrupUSDT yield by approximately 50bps.

The above incentive strategies create GHO Supply on Aave Protocol. Sourcing the GHO is expected to at least partially flow from through the remote GSM, which deposits USDT0 into Aave whereby the DAO earns the Supply yield.

### GHO Demand

With strong GHO supply expected from the GHO incentives, GHO demand is created via the revision of eMode 2 to include GHO as a debt asset. eMode 2 is to offer sUSDe and USDe as collateral with USDT and GHO as debt, the GHO debt will receive a x5 Sats multiplier from the Ethena team that matches what is currently available on the Ethereum Core and Prime instances.

This is expected to stimulate Demand for GHO on Aave Protocol with GHO expected to be a lower cost alternative to USDT0 due to the Borrow Rate configuration (150bps less than USDT at Uoptimal) and additional Sat incentives acting to offset the cost of capital for leverage users.

Furthemore, additional eModes with Pendle PT assets are expected to provide sustained demand for GHO that reduces the reliance on GHO Incentive yield to attract GHO supply.

### Fluid and Balancer

With support from the Aave Liquidity Committee (ALC) concentrated liquidity facilitating swaps will be incentivised on Fluid and Balancer in collaboration with each respective team and the Plasma team. Importantly, this stimulates demand for GHO on secondary markets outside of Aave Protocol and is expected to provide a net counter flow where users are expected to be net acquiring GHO.

## Specification

The table below illustrates the configured risk parameters for **GHO**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (GHO)          |                                 50,000,000 |
| Borrow Cap (GHO)          |                                 20,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                     0.05 % |
| LT                        |                                      0.1 % |
| Liquidation Bonus         |                                      4.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                        5 % |
| Base Variable Borrow Rate |                                     1.25 % |
| Variable Slope 1          |                                      3.5 % |
| Variable Slope 2          |                                     16.5 % |
| Uoptimal                  |                                       92 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for GHO and the corresponding aToken.

### EModes

## eMode Category 2

| Parameter             | sUSDe | USDe | USDT | GHO |
| --------------------- | :---: | :--: | :--: | :-: |
| Collateral            |  Yes  | Yes  |  No  | No  |
| Borrowable            |  No   |  No  | Yes  | Yes |
| Max LTV               |  90%  | 90%  |  -   |  -  |
| Liquidation Threshold |  92%  | 92%  |  -   |  -  |
| Liquidation Bonus     | 4.0%  | 4.0% |  -   |  -  |

## eMode Category - Category 5

| Parameter             | PT-USDe Jan | USDT | USDe | GHO |
| --------------------- | :---------: | :--: | :--: | :-: |
| Collateral            |     Yes     |  No  |  No  | No  |
| Borrowable            |     No      | Yes  | Yes  | Yes |
| Max LTV               |    85.9%    |  -   |  -   |  -  |
| Liquidation Threshold |    87.9%    |  -   |  -   |  -  |
| Liquidation Bonus     |    4.9%     |  -   |  -   |  -  |

## eMode Category - Category 7

| Parameter             | PT-sUSDe Jan | USDT | USDe | GHO |
| --------------------- | :----------: | :--: | :--: | :-: |
| Collateral            |     Yes      |  No  |  No  | No  |
| Borrowable            |      No      | Yes  | Yes  | Yes |
| Max LTV               |    84.4%     |  -   |  -   |  -  |
| Liquidation Threshold |    86.4%     |  -   |  -   |  -  |
| Liquidation Bonus     |     6.0%     |  -   |  -   |  -  |

## eMode Category (new)

| Parameter             | GHO  | USDT |
| --------------------- | :--: | :--: |
| Collateral            | Yes  |  No  |
| Borrowable            |  No  | Yes  |
| Max LTV               | 94%  |  -   |
| Liquidation Threshold | 96%  |  -   |
| Liquidation Bonus     | 2.0% |  -   |

## eMode Category (new)

| Parameter             | syrupUSDT | GHO |
| --------------------- | :-------: | :-: |
| Collateral            |    Yes    | No  |
| Borrowable            |    No     | Yes |
| Max LTV               |    90%    |  -  |
| Liquidation Threshold |    92%    |  -  |
| Liquidation Bonus     |   4.0%    |  -  |

## eMode Category (new)

| Parameter             | syrupUSDT | GHO  | USDT |
| --------------------- | :-------: | :--: | :--: |
| Collateral            |    Yes    | Yes  |  No  |
| Borrowable            |    No     |  No  | Yes  |
| Max LTV               |    90%    | 90%  |  -   |
| Liquidation Threshold |    92%    | 92%  |  -   |
| Liquidation Bonus     |   4.0%    | 4.0% |  -   |

### Facilitator & Bridging

Deploy an **OwnableFacilitator** facilitator on Ethereum to enable GHO issuance for Plasma.

- **OwnableFacilitator Mint Cap**: 50M GHO
- **Initial Mint**: 50M GHO

As required, future Minting of GHO on Ethereum, to be supplied into the RemoteGSM on Plasma (or other networks) will be performed via direct submission of AIPs.

**GhoReserve**

Deploy GhoReserve on Plasma to hold bridged GHO.
Configure stataUSDT RemoteGSM as an entity with a draw capacity of 50M GHO.

### RemoteGSM Parameters (stataUSDT)

| Parameter              | Value  |
| ---------------------- | ------ |
| GHO Cap                | 50M    |
| stataUSDT Exposure Cap | 45M    |
| Freeze Lower Bound     | $0.990 |
| Freeze Upper Bound     | $1.010 |
| Unfreeze Lower Bound   | $0.995 |
| Unfreeze Upper Bound   | $1.005 |
| Mint GHO Fee           | 0.00%  |
| Burn GHO Fee           | 0.10%  |

### GHO Steward Configuration

**GhoAaveSteward**

- `updateGhoBorrowCap`: ±100%
- `updateGhoBorrowRate`: ±5% on optimal usage ratio, base variable rates, slopes
- `updateGhoSupplyCap`: Up to +100%

**GhoGsmSteward**

- `updateGsmExposureCap`: ±100%
- `updateGsmBuySellFees`: ±0.5% per side (FixedFeeStrategy)

### Bridging

Bridge 50M GHO from Mainnet to Plasma utilizing the newly set up AaveGhoCcipBridge.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250930_Multi_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards/AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930.sol), [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250930_Multi_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards/AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250930_Multi_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards/AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930.t.sol), [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250930_Multi_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards/AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xeb3572580924976867073ad9c8012cb9e52093c76dafebd7d3aebf318f2576fb)
- [Discussion](https://governance.aave.com/t/arfc-launch-gho-on-plasma-set-aci-as-emissions-manager-for-rewards/22994/6)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
