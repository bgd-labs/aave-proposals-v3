---
title: "Onboard USDe to Aave V3 X Layer"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-asset-listing-usde-x-layer/25688"
---

## Simple Summary

This publication proposes to onboard USDe as a supported asset on the Aave V3 X Layer Instance.

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

In line with the [LlamaRisk recommendation](https://governance.aave.com/t/direct-to-aip-asset-listing-usde-x-layer/25688/4), USDe is not enabled as collateral in the general market. It can be used as collateral within the new USDe Stablecoin E-Mode.

## Specification

USDe Contract Address

| **Asset** | **Address**                                                                                                                      |
| --------- | -------------------------------------------------------------------------------------------------------------------------------- |
| USDe      | [`0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34`](https://www.oklink.com/xlayer/address/0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34) |

The address above represents Ethena's USDe deployment on X Layer.

### Proposed Market Configuration

The parameters below follow the [recommendation of LlamaRisk](https://governance.aave.com/t/direct-to-aip-asset-listing-usde-x-layer/25688/4).

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
| Liquidation Bonus        | 0.00%         |
| Liquidation Protocol Fee | 10%           |
| Variable Base            | 6.30%         |
| Variable Slope 1         | 0.25%         |
| Variable Slope 2         | 45.00%        |
| Uoptimal                 | 85.00%        |
| Reserve Factor           | 25%           |
| Stable Borrowing         | Disabled      |
| Flashloanable            | Yes           |
| Siloed Borrowing         | No            |
| Borrowable in Isolation  | No            |
| eModes                   | 1, 2, 3, 4, 9 |

USDe is not enabled as collateral outside E-Mode.

## E-Mode Configuration

We propose adding USDe as a borrowable asset to the four existing stablecoin borrowing E-Mode categories on X Layer, and creating a new USDe Stablecoin E-Mode.

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

**eMode #9 (new)**

| **Parameter**         | **Value** | **Value** | **Value** | **Value** | **Value** |
| --------------------- | --------- | --------- | --------- | --------- | --------- |
| Asset                 | USDe      | USDT0     | USDG      | USDC      | GHO       |
| Collateral            | Yes       | No        | No        | No        | No        |
| Borrowable            | No        | Yes       | Yes       | Yes       | Yes       |
| Isolated              | No        | \-        | \-        | \-        | \-        |
| Max LTV               | 91.00%    | \-        | \-        | \-        | \-        |
| Liquidation Threshold | 93.00%    | \-        | \-        | \-        | \-        |
| Liquidation Bonus     | 2.00%     | \-        | \-        | \-        | \-        |

eMode #1 to #4 are existing X Layer E-Mode categories. USDT0, USDG, USDC and GHO are currently configured as borrowable stablecoins within each category, and this proposal extends the same functionality to USDe. eMode #9 is a new category with USDe as its only collateral.

## Oracle

In line with the [LlamaRisk recommendation](https://governance.aave.com/t/direct-to-aip-asset-listing-usde-x-layer/25688/4), USDe will be priced using the existing Capped USDT/USD adapter on X Layer, consistent with the approach used for USDe across Aave instances. The adapter is already used for the USDT0 reserve on this instance.

| **Parameter** | **Value**                                                                                                                        |
| ------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Price Feed    | Capped USDT / USD                                                                                                                |
| Adapter       | [`0x7ec7E5497EAf312FE82F8307D05eb0E5f0f157D3`](https://www.oklink.com/xlayer/address/0x7ec7e5497eaf312fe82f8307d05eb0e5f0f157d3) |
| Price Cap     | 1.04 USD                                                                                                                         |
| Network       | X Layer Mainnet                                                                                                                  |

## Next Steps

1. Gather feedback from the community.
2. Confirm that at least $5M of USDe DEX liquidity is available on X Layer, as LlamaRisk requires before launch.
3. Deposit at least 100 USDe into the Aave X Layer Short Executor to seed the reserve.
4. Escalate this proposal to the AIP Voting stage.

## References

- Implementation: [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20261013_AaveV3XLayer_AaveV3XLayerUSDeListing/AaveV3XLayer_AaveV3XLayerUSDeListing_20261013.sol)
- Tests: [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20261013_AaveV3XLayer_AaveV3XLayerUSDeListing/AaveV3XLayer_AaveV3XLayerUSDeListing_20261013.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-asset-listing-usde-x-layer/25688)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
