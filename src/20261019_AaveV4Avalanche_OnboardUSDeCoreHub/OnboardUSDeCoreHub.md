---
title: "Onboard USDe to Aave V4 Core Instance on Avalanche"
author: "@AaveLabs"
date: "2026-10-19"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-usde-to-aave-v4-core-instance-on-avalanche/25576"
---

## Simple Summary

This proposal onboards USDe to the Aave V4 Core Instance on Avalanche. It configures the new Ethena Ecosystem Spoke, where USDe is collateral only and USDt and USDC are borrowable, grants the Governance Level 1 Executor the role required to configure spokes, raises the USDt add cap on the Main Spoke, and updates the USDt and USDC interest rate parameters on the Core Hub.

## Motivation

USDe is Ethena Labs' synthetic dollar. It targets a value of one US dollar by pairing staked collateral with offsetting perpetual futures positions, held largely offchain. Ethena Labs has extended USDe and its staked form to Avalanche, where spot and lending venues across the network support it.

Onboarding USDe to the Aave V4 Core Instance on Avalanche:

- Adds a synthetic dollar stablecoin to the Aave V4 Core Instance on Avalanche.
- Supports demand from Ethena's expansion of USDe to Avalanche.
- Extends USDe's collateral footprint within the Aave protocol, where it is already listed on other Aave instances.

## Specification

This proposal lists USDe on the Core Hub of the Aave V4 Core Instance on Avalanche, and configures USDe, USDt and USDC reserves on the new Ethena Ecosystem Spoke.

**USDe**: [`0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34`](https://snowscan.xyz/address/0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34)

The Ethena Ecosystem Spoke is deployed at [`0xaf22446124e566e54845f65b722E4dCbf12b650A`](https://snowscan.xyz/address/0xaf22446124e566e54845f65b722E4dCbf12b650A). The payload wires it to the Aave V4 Access Manager on Avalanche [`0xe069096bDAfF9bAD15b2f1079EaF0f1685a24522`](https://snowscan.xyz/address/0xe069096bDAfF9bAD15b2f1079EaF0f1685a24522), sets its liquidation configuration, and enables the Giver, Taker and Config Position Managers and the Signature Gateway on it.

USDe is listed on the Core Hub as a non-borrowable asset, with a 0.00% liquidity fee, the Core Hub's interest rate strategy [`0x446eb3913b3fd3a9219A07B0f6AbE98BD0fAeed4`](https://snowscan.xyz/address/0x446eb3913b3fd3a9219A07B0f6AbE98BD0fAeed4), and no Tokenization Spoke. USDt and USDC are already listed on the Core Hub.

This proposal grants the `SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE` on the Aave V4 Access Manager on Avalanche to the Governance Level 1 Executor. The role is required to configure spokes through the Spoke Configurator. The grant is permanent and aligns Avalanche with Aave V4 on Ethereum.

**Spoke configuration**

| Hub  | Spoke                  | Reserve | Collateral Factor | Max Liquidation Bonus | Borrowable | Collateral Risk | Liquidation Fee | Risk Premium Threshold | Receive Shares |
| ---- | ---------------------- | ------- | ----------------: | --------------------: | ---------- | --------------: | --------------: | ---------------------: | -------------- |
| Core | Ethena Ecosystem Spoke | USDe    |            93.00% |                 2.00% | FALSE      |          16.50% |          10.00% |                      0 | TRUE           |
| Core | Ethena Ecosystem Spoke | USDt    |             0.00% |                     - | TRUE       |               - |               - |                  1100% | TRUE           |
| Core | Ethena Ecosystem Spoke | USDC    |             0.00% |                     - | TRUE       |               - |               - |                  1100% | TRUE           |

**Dynamic liquidation configuration**

| Parameter                   |  Value |
| --------------------------- | -----: |
| Target Health Factor        | 1.0277 |
| Health Factor for Max Bonus |   0.99 |
| Liquidation Bonus Factor    |   1.00 |

**Caps**

| Hub  | Spoke                  | Reserve |    Add Cap |   Draw Cap |
| ---- | ---------------------- | ------- | ---------: | ---------: |
| Core | Ethena Ecosystem Spoke | USDe    | 60,000,000 |          0 |
| Core | Ethena Ecosystem Spoke | USDt    |          0 | 50,000,000 |
| Core | Ethena Ecosystem Spoke | USDC    |          0 |  3,000,000 |

**Main Spoke cap update**

| Hub  | Spoke | Reserve |    Add Cap |
| ---- | ----- | ------- | ---------: |
| Core | Main  | USDt    | 60,000,000 |

**Interest Rate Strategy**

| Hub  | Reserve | Rate Growth Before Optimal | Rate Growth After Optimal | Optimal Usage Ratio |
| ---- | ------- | -------------------------: | ------------------------: | ------------------: |
| Core | USDt    |                      4.90% |                    20.00% |              94.00% |
| Core | USDC    |                      4.50% |                    20.00% |                   - |

**Oracle configuration**

USDe and USDt are priced with the Capped USDt/USD feed:

| Parameter       | Value                                                                                                                              |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| Price feed      | [`0x5b7810a910B4a878AaA4800a824E5E5796838009`](https://snowscan.xyz/address/0x5b7810a910B4a878AaA4800a824E5E5796838009)            |
| Base aggregator | USDT / USD [`0xEBE676ee90Fe1112671f19b6B7459bC678B67e8a`](https://snowscan.xyz/address/0xEBE676ee90Fe1112671f19b6B7459bC678B67e8a) |
| Price cap       | 1.04 USD                                                                                                                           |

USDC is priced with the Capped USDC/USD feed:

| Parameter       | Value                                                                                                                              |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| Price feed      | [`0xb0D7A8bbDcdb1203850b742bB4d7f57a1F1C8483`](https://snowscan.xyz/address/0xb0D7A8bbDcdb1203850b742bB4d7f57a1F1C8483)            |
| Base aggregator | USDC / USD [`0xF096872672F44d6EBA71458D74fe67F9a77a23B9`](https://snowscan.xyz/address/0xF096872672F44d6EBA71458D74fe67F9a77a23B9) |
| Price cap       | 1.04 USD                                                                                                                           |

USDe is priced with the Capped USDt/USD feed rather than a USDe market feed or a CAPO adapter, consistent with the approach adopted across all Aave instances for USDe-denominated assets.

## Disclaimer

This proposal was prepared by Aave Labs in its capacity as a contributor to the Aave ecosystem. Aave Labs has no financial relationship with Ethena Labs or any of its affiliates and has not received compensation from Ethena in connection with this proposal.

## References

- Implementation: [AaveV4Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20261019_AaveV4Avalanche_OnboardUSDeCoreHub/AaveV4Avalanche_OnboardUSDeCoreHub_20261019.sol)
- Tests: [AaveV4Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20261019_AaveV4Avalanche_OnboardUSDeCoreHub/AaveV4Avalanche_OnboardUSDeCoreHub_20261019.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-usde-to-aave-v4-core-instance-on-avalanche/25576)
