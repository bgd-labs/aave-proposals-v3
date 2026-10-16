---
title: "Onboard USDe to Aave V3 X Layer"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-asset-listing-usde-x-layer/25688"
---

## Simple Summary

This ARFC proposes to onboard USDe as a supported asset on the Aave V3 X Layer Instance.

## Motivation

USDe is Ethena's synthetic dollar, designed to maintain a value referenced to the US dollar through a combination of protocol held backing assets and offsetting derivatives positions.

USDe has developed significant adoption across DeFi and is currently supported across several Aave markets as both a supplied and borrowed asset.

USDe is deployed on X Layer using Ethena's LayerZero OFT infrastructure, enabling USDe to move across supported networks through Ethena's canonical cross-chain deployment.

Onboarding USDe to Aave V3 X Layer would:

- Expand the range of stablecoin assets available to Aave users on X Layer.
- Provide an additional asset for lending and borrowing alongside USDT0, USDG, USDC and GHO.
- Enable USDe to be used as collateral within a dedicated USDe Stablecoin E-Mode.
- Increase the available stablecoin borrowing liquidity for the existing xBTC, xETH, xSOL, and WOKB E-Mode categories.
- Expand the range of cross-margin and stablecoin strategies available to users on X Layer.

Per LlamaRisk's recommendation, USDe is not enabled as collateral in the general market. Users can use it as collateral within the new USDe Stablecoin E-Mode.

## Specification

USDe Contract Address

| **Asset** | **Address**                                  |
| --------- | -------------------------------------------- |
| USDe      | `0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34` |

The address above represents Ethena's USDe deployment on X Layer.

### Proposed Market Configuration

We propose initially configuring USDe with the following parameters, subject to final recommendations from Aave Risk Service Providers.

| **Parameter**            | **Value**     |
| ------------------------ | ------------- |
| Asset                    | USDe          |
| Isolation Mode           | No            |
| Borrowable               | Yes           |
| Collateral Enabled       | No            |
| Supply Cap               | 100,000,000   |
| Borrow Cap               | 20,000,000    |
| Debt Ceiling             | -             |
| LTV                      | 0.00%         |
| LT                       | 0.00%         |
| Liquidation Bonus        | 0.0%          |
| Liquidation Protocol Fee | 10%           |
| Variable Base            | 6.30%         |
| Variable Slope 1         | 0.25%         |
| Variable Slope 2         | 45.00%        |
| Uoptimal                 | 85.00%        |
| Reserve Factor           | 25%           |
| Flashloanable            | Yes           |
| Siloed Borrowing         | No            |
| Borrowable in Isolation  | No            |
| eModes                   | 1, 2, 3, 4, 9 |

The proposed collateral parameters do not allow USDe to be enabled as collateral outside E-Mode.

Final onboarding parameters remain subject to review and recommendations from Aave's Risk Service Providers.

## E-Mode Configuration

We propose adding USDe as a borrowable asset to the four existing stablecoin borrowing E-Mode categories on X Layer.

**eMode #1**

| **Parameter**         | **Value** | **Value** | **Value** | **Value** | **Value** | **Value** |
| --------------------- | --------- | --------- | --------- | --------- | --------- | --------- |
| Asset                 | xBTC      | USDT0     | USDe      | USDG      | USDC      | GHO       |
| Collateral            | Yes       | No        | No        | No        | No        | No        |
| Borrowable            | No        | Yes       | Yes       | Yes       | Yes       | Yes       |
| Max LTV               | 78.00%    | \-        | \-        | \-        | \-        | \-        |
| Liquidation Threshold | 81.00%    | \-        | \-        | \-        | \-        | \-        |
| Liquidation Bonus     | 6.00%     | \-        | \-        | \-        | \-        | \-        |

**eMode #2**

| **Parameter**         | **Value** | **Value** | **Value** | **Value** | **Value** | **Value** |
| --------------------- | --------- | --------- | --------- | --------- | --------- | --------- |
| Asset                 | xETH      | USDT0     | USDe      | USDG      | USDC      | GHO       |
| Collateral            | Yes       | No        | No        | No        | No        | No        |
| Borrowable            | No        | Yes       | Yes       | Yes       | Yes       | Yes       |
| Max LTV               | 78.00%    | \-        | \-        | \-        | \-        | \-        |
| Liquidation Threshold | 80.00%    | \-        | \-        | \-        | \-        | \-        |
| Liquidation Bonus     | 6.00%     | \-        | \-        | \-        | \-        | \-        |

**eMode #3**

| **Parameter**         | **Value** | **Value** | **Value** | **Value** | **Value** | **Value** |
| --------------------- | --------- | --------- | --------- | --------- | --------- | --------- |
| Asset                 | xSOL      | USDT0     | USDe      | USDG      | USDC      | GHO       |
| Collateral            | Yes       | No        | No        | No        | No        | No        |
| Borrowable            | No        | Yes       | Yes       | Yes       | Yes       | Yes       |
| Max LTV               | 65.00%    | \-        | \-        | \-        | \-        | \-        |
| Liquidation Threshold | 70.00%    | \-        | \-        | \-        | \-        | \-        |
| Liquidation Bonus     | 7.50%     | \-        | \-        | \-        | \-        | \-        |

**eMode #4**

| **Parameter**         | **Value** | **Value** | **Value** | **Value** | **Value** | **Value** |
| --------------------- | --------- | --------- | --------- | --------- | --------- | --------- |
| Asset                 | wOKB      | USDT0     | USDe      | USDG      | USDC      | GHO       |
| Collateral            | Yes       | No        | No        | No        | No        | No        |
| Borrowable            | No        | Yes       | Yes       | Yes       | Yes       | Yes       |
| Max LTV               | 50.00%    | \-        | \-        | \-        | \-        | \-        |
| Liquidation Threshold | 55.00%    | \-        | \-        | \-        | \-        | \-        |
| Liquidation Bonus     | 10.00%    | \-        | \-        | \-        | \-        | \-        |

**eMode #9**

| **Parameter**         | **Value** | **Value** | **Value** | **Value** | **Value** |
| --------------------- | --------- | --------- | --------- | --------- | --------- |
| Asset                 | USDe      | USDT0     | USDG      | USDC      | GHO       |
| Collateral            | Yes       | No        | No        | No        | No        |
| Borrowable            | No        | Yes       | Yes       | Yes       | Yes       |
| Max LTV               | 91.00%    | \-        | \-        | \-        | \-        |
| Liquidation Threshold | 93.00%    | \-        | \-        | \-        | \-        |
| Liquidation Bonus     | 2.00%     | \-        | \-        | \-        | \-        |

These are the four existing X Layer E-Mode configurations. USDT0, USDG, USDC and GHO are currently configured as borrowable stablecoins within each category. This proposal would extend the same functionality to USDe.

## Oracle

A Chainlink **USDT/USD Price Feed** is available on X Layer Mainnet.

Consistent with the oracle architecture used for USDe across Aave markets, we propose pricing USDe using the Chainlink USDT/USD reference feed together with a Stable Price Cap Adapter.

| **ParameterValue**    |                                     |
| --------------------- | ----------------------------------- |
| Reference Feed        | USDT / USD                          |
| Network               | X Layer Mainnet                     |
| Chainlink Product     | `USDT/USD-RefPrice-DF-XLayer-001`   |
| Pricing               | USDT/USD + Stable Price Cap Adapter |
| Upper Price Deviation | 4%                                  |

The Stable Price Cap Adapter would cap upward price deviation at 4%, consistent with the configuration used for USDe and other stablecoin assets across Aave markets.

The final oracle contract, adapter deployment, and configuration remain subject to confirmation by the relevant Aave Risk and Technical Service Providers.

## Next Steps

1. Gather feedback from the community.
2. Using the Direct-to-AIP process, incorporate feedback from the Risk Service Provider.
3. Escalate this proposal to the AIP Voting stage.

## References

- Implementation: [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/5c8df860e31ae70714d681e8e197486c2a6ecfd1/src/20261013_AaveV3XLayer_AaveV3XLayerUSDeListing/AaveV3XLayer_AaveV3XLayerUSDeListing_20261013.sol)
- Tests: [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/5c8df860e31ae70714d681e8e197486c2a6ecfd1/src/20261013_AaveV3XLayer_AaveV3XLayerUSDeListing/AaveV3XLayer_AaveV3XLayerUSDeListing_20261013.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-asset-listing-usde-x-layer/25688)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
