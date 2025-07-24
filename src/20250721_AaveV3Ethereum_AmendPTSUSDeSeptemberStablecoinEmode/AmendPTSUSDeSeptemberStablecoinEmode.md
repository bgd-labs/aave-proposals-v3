---
title: "amend PT-sUSDe september stablecoin emode"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-adjustment-of-pt-susde-september-e-mode-and-usdtb-ir-curve/22615"
---

## Simple Summary

This proposal recommends enabling USDtb as a borrowable asset within the e-mode configuration for USDe PTs and adding sUSDe and PT-sUSDE-31JUL2025 as a collateral asset to the stablecoin e-mode configuration of PT-sUSDe-25SEP2025.

The integration of USDtb as a borrowable asset in the USDe PT e-mode is expected to drive borrowing demand and increase Aave protocol revenue. However, this setup introduces risks related to the rehypothecation of stablecoin backing used for USDe redemptions. These must be managed through careful parameterization.

## **USDtb**

USDtb is a 1:1 USD-pegged stablecoin issued by Pallas (BVI) Ltd. and managed by Athene Management, an affiliate of Ethena Labs. It is primarily backed by BlackRock’s BUIDL, a tokenized U.S. Treasury fund, with a portion held in USDC to support redemption liquidity.

Minting and redemption of USDtb are restricted to whitelisted addresses.

USDtb plays a central role in USDe’s stablecoin backing, enabling fast redemptions and real-world yield through U.S. Treasuries. It functions as a strategic reserve and yield-bearing asset within the Ethena ecosystem

## **USDe Backing**

Ethena’s USDe is a synthetic dollar whose collateral mix dynamically adjusts based on funding rate conditions in the market. Its backing can consist of delta-neutral short perp positions and stablecoin reserves.

Historically, the stablecoin share of USDe’s backing has varied significantly, ranging from a low of 6% to a peak of 76%, and currently stands at approximately 45%.

The stablecoin portion (including USDtb) provides fast redemption liquidity. When redemptions occur, Ethena prefers using liquid stablecoin reserves rather than unwinding short perp positions, which may be labor intensive and costly in volatile market conditions.

## Risks

Enabling USDtb as a borrowable asset within USDe PT e-modes introduces several important risk vectors that should be carefully considered.

### **Rehypothecation and Liquidity Risk in Stress Scenarios**

USDtb serves as a redemption reserve in the Ethena ecosystem, ensuring timely and reliable USDe redemptions. Allowing it to be borrowed by PT loopers introduces a reflexive dynamic: low borrow rates incentivize PT looping, which drives further new USDe minting and results in more USDtb being minted and deposited into Aave. This increases supply side liquidity, keeps borrow rates low, and reinforces the loop. If left unchecked, this rehypothecation cycle can lead to unsustainable expansion of USDe supply, amplifying systemic risk during periods of market stress or liquidity shocks.

This structure presents a significant risk in stress scenarios. In the event of large-scale redemptions, such as those triggered by a centralized exchange failure, Ethena requires immediate access to its USDtb reserves to honor redemptions and to rehedge or unwind short positions.

However, if a substantial portion of USDtb is borrowed out by PT loopers, Ethena may be unable to retrieve its liquidity. As shown in our recent analysis [Stress Testing Ethena: A Quantitative Look at Protocol Stability](https://governance.aave.com/t/stress-testing-ethena-a-quantitative-look-at-protocol-stability/22558), under such conditions, PT leverage loopers may be unable to unwind their positions due to a lack of available onchain liquidity, preventing repayment of borrowed USDtb. This results in a liquidity mismatch that can delay or block redemptions, undermining Ethena’s ability to respond effectively and increasing the risk of instability in the USDe peg during periods of market stress.

It is also important to note that USDtb generates real world yield through its exposure to tokenized U.S. Treasuries. If Ethena is both earning this yield and simultaneously supplying USDtb to Aave to earn additional supply side returns, while Aave bears the counterparty and liquidation risks from borrowers, it creates an asymmetry in risk and reward. Without adjustments to reserve factors or appropriate risk parameters, Aave may be exposed to these risks without being adequately compensated.

## **Benefits to Aave**

Despite the associated risks, enabling USDtb borrowing for PT-based strategies offers several important benefits for Aave.

### **Increased Borrowing Demand and Protocol Revenue**

USDtb is expected to become one of the preferred borrowing asset for users engaging in USDe PT looping strategies. This will drive significant borrowing activity, increasing the utilization of USDtb deposits on Aave. As a result, the protocol stands to benefit from higher interest rate income.
Below, we outline the expected revenue derived from the borrowing of USDtb in relation to the amount of USDtb borrowed against PT collaterals and aUSDtb’s share of the total USDe backing.

### **Potential Indirect Contribution to Risk Reduction**

As highlighted in our [_Stress Testing Ethena: A Quantitative Look at Protocol Stability_](https://governance.aave.com/t/stress-testing-ethena-a-quantitative-look-at-protocol-stability/22558/1) analysis, the proportion of stablecoin backing in USDe plays a key role in determining how much USDe must depeg before Aave incurs bad debt. We observed that an increased stablecoin share significantly reduces Aave’s exposure to losses through USDe base assets in the event of exchange failure scenario. If USDtb becomes borrowable on Aave, it creates an additional income stream for Ethena, allowing them to earn both U.S. Treasury yield and Aave supply yield. This additional yield may incentivize Ethena to maintain a higher stablecoin allocation in USDe’s backing, indirectly reducing risk to Aave.

However, this effect is difficult to predict, as it introduces a new dynamic into the system. While our analysis shows that the stablecoin share in USDe’s reserve has historically been driven primarily by market funding rates, not by onchain stablecoin yield opportunities. Enabling USDtb to generate additional onchain yield may influence reserve allocation behavior in ways not previously observed.

## **Risk Mitigations on Aave**

To safely support USDtb as a borrowable asset within USDe PT e-modes, Aave can adopt several mitigation strategies to limit protocol risk and preserve market stability.

### **Borrow Cap Controls**

Aave can limit rehypothecation risk by applying a conservative borrow cap on USDtb, ensuring that only a portion of the supply is made available for borrowing. The goal is to prevent the borrow cap from growing beyond a prudent fraction of Ethena’s stablecoin reserves, helping ensure that a meaningful portion of USDtb remains accessible for redemptions and liquidity management during periods of stress.

### **Interest Rate Adjustments**

Aave can adjust interest rate parameters not only to mitigate systemic risks but also to optimize the protocol’s risk-reward profile. We recommend two complementary mechanisms: dynamic adjustments based on USDe reserve composition and proactive curve optimization to improve the protocol’s risk-reward profile.

#### **Dynamic Adjustments Based on USDe Stablecoin Reserve Composition**

In scenarios where borrowing demand for USDtb exceeds safe thresholds, Aave can dynamically adjust the variable interest rate curve to discourage further exposure. Here, _safe thresholds_ refer to the level at which the amount of USDtb borrowed on Aave begins to represent an outsized share of the stablecoin portion of USDe backing. Steepening the slope parameters at or beyond the optimal utilization point can effectively reduce excessive borrowing activity and help maintain balanced market dynamics.
Interest rate adjustments are particularly useful in the following cases:

1. **Declining Stablecoin Backing:** If Ethena reduces the stablecoin portion of USDe’s backing while USDtb borrowing on Aave remains elevated at the borrow cap, interest rates can be raised to keep borrowed USDtb within a prudent share of the reduced stablecoin reserve.
2. **Shrinking USDe Supply:** If USDe supply is contracting but borrowed USDtb does not decrease accordingly, interest rate hikes can be used to dampen excessive exposure and ensure that borrowing demand remains proportionate to the size of the stablecoin reserve.

This approach gives Aave a flexible tool to align borrowing rates with underlying liquidity conditions and systemic safety.

#### **Interest Rate Curve Optimization**

To better align revenue generation with Aave’s risk exposure, we also recommend updating the USDtb interest rate model by introducing a 2% base rate and reducing slope-1 from 6% to 4%. This adjustment enables Aave to begin accruing protocol income earlier in the utilization curve, improving yield efficiency while keeping borrowing costs competitive for users.

By shifting more revenue generation into the sub-optimal utilization range, Aave can enhance protocol earnings without disincentivizing strategic borrowing behavior. Slope-2 and Uoptimal remain unchanged, maintaining tail risk protection in high utilization scenarios.

This proactive optimization improves the protocol’s risk-reward balance, and ensures Aave captures more value from growing borrowing demand.

### **Reserve Factor Optimization**

Aave can increase the reserve factor on USDtb to better align risk and reward. Given that Ethena may capture yield from both the underlying U.S. Treasuries and Aave’s supply rate, the protocol should retain a larger portion of interest payments as a buffer against potential losses. This improves the risk-reward profile for Aave and allows the protocol to accumulate reserves proportional to its exposure.
Together, these controls provide Aave with levers to manage systemic risk, support healthy market behavior, and ensure that enabling USDtb borrowing does not come at the cost of protocol resilience.

## sUSDe E-Mode Collateral

The PT-sUSDE-31JUL2025 is scheduled to expire on 31 July, just 13 days from now. To ensure a smooth migration path for existing suppliers of PT-sUSDE-31JUL2025, we propose including the base asset sUSDe and the PT relative to the expiring E-Mode in the stablecoin E-Mode of PT-sUSDE-25SEP2025 as collateral.

This modification provides a smooth path for users to roll over their existing positions to the new expiry, should they choose to do so.

This change aligns with the approach outlined in the following ARFC:

[ARFC Addendum – Modify E-Modes for PT Token Collateral](https://governance.aave.com/t/arfc-addendum-modify-e-modes-for-pt-token-collateral/22128)

## Specification

Thefollowing assets will be added to **PT-sUSDE September Stablecoins E-mode**

| **Asset**  | **PT-sUSDE-31JUL2025** | **sUSDe** | **USDtb** |
| ---------- | ---------------------- | --------- | --------- |
| Collateral | Yes                    | Yes       | No        |
| Borrowable | No                     | No        | Yes       |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/0d3197966d3fa18914f5242d983c9d9d774f5bcf/src/20250721_AaveV3Ethereum_AmendPTSUSDeSeptemberStablecoinEmode/AaveV3Ethereum_AmendPTSUSDeSeptemberStablecoinEmode_20250721.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/0d3197966d3fa18914f5242d983c9d9d774f5bcf/src/20250721_AaveV3Ethereum_AmendPTSUSDeSeptemberStablecoinEmode/AaveV3Ethereum_AmendPTSUSDeSeptemberStablecoinEmode_20250721.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-adjustment-of-pt-susde-september-e-mode-and-usdtb-ir-curve/22615)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
