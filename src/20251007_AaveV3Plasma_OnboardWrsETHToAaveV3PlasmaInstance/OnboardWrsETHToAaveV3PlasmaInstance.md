---
title: "Onboard wrsETH to Aave v3 Plasma Instance"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-wrseth-to-aave-v3-plasma-instance/23183"
---

## Simple Summary

This publication proposes adding **wstETH** and **wrsETH** as collateral to the Aave v3 instance on the **Plasma** network using the Direct-to-AIP process.

## Motivation

### wrsETH

rsETH is a liquid staking token issued by Kelp DAO, offering users access to rewards from ETH staking while maintaining liquidity and DeFi composability.

Following the strong adoption of wrsETH on Linea, where it is the largest LRT, this publication proposes onboarding wrsETH to Plasma. wrsETH has established a reliable track record across Aave markets, with users deposits of ~$1B on Core, ~$370M on Linea and smaller balances on other networks.

Given that:

- rsETH has already passed governance and risk assessments for Ethereum, Arbitrum, and Base;
- Plasma is a supported Aave V3 deployment with growing activity and integration potential; and,
- A precedent has been set for using the Direct-to-AIP path when onboarding previously approved assets to new instances.

By bringing wrsETH to Plasma, users will benefit from an additional network where they can utilize the asset under consistent risk parameters.

### wstETH

**wstETH** (wrapped stETH) is issued by **Lido Finance** and represents a non-rebasing version of stETH. By eliminating rebasing mechanics, wstETH is straightforward to use across lending markets, DEXes, and structured DeFi applications.

Its longstanding presence in Aave makes it a fundamental collateral asset for borrowers and a reliable source of liquidity. Introducing wstETH to Plasma serves several objectives:

- Broadening the collateral set for users on Plasma;
- Strengthening network adoption by adding a blue-chip staking derivative;
- Aligning Plasma with other Aave V3 deployments where wstETH is already active under well-defined parameters; and,
- Offering access to cheap stablecoin debt to Lido users.

## Specification

The table below illustrates the configured risk parameters

| Parameter                 |   wstETH |   wrsETH |
| ------------------------- | -------: | -------: |
| Isolation Mode            |    false |    false |
| Borrowable                |  ENABLED | DISABLED |
| Collateral Enabled        |     true |     true |
| Supply Cap (wstETH)       |   20,000 |   20,000 |
| Borrow Cap (wstETH)       |    5,000 |        1 |
| Debt Ceiling              |    USD 0 |    USD 0 |
| LTV                       |   78.5 % |   0.05 % |
| LT                        |     81 % |    0.1 % |
| Liquidation Bonus         |      6 % |      7 % |
| Liquidation Protocol Fee  |     10 % |     10 % |
| Reserve Factor            |     35 % |     45 % |
| Base Variable Borrow Rate |      0 % |      0 % |
| Variable Slope 1          |   0.55 % |     10 % |
| Variable Slope 2          |     40 % |    300 % |
| Uoptimal                  |     90 % |     45 % |
| Flashloanable             |  ENABLED |  ENABLED |
| Siloed Borrowing          | DISABLED | DISABLED |
| Borrowable in Isolation   | DISABLED | DISABLED |

**Pricefeed details**

| Parameter            |                                                                                                        wstETH |                                                                                                wrsETH |
| -------------------- | ------------------------------------------------------------------------------------------------------------: | ----------------------------------------------------------------------------------------------------: |
| Oracle               | [Capped stETH / stETH (ETH) / USD ](https://plasmascan.to/address/0xd6ff49B650550ce2452e0fCCa101Ab7CE206d851) | [Capped rsETH / ETH / USD ](https://plasmascan.to/address/0x3acFddf27b85B5f773B610c6F7e4420aeB1Df8dD) |
| BASE/USD Oracle      |                 [Chainlink ETH/USD](https://plasmascan.to/address/0x43A7dd2125266c5c4c26EB86cd61241132426Fe7) |         [Chainlink ETH/USD](https://plasmascan.to/address/0x43A7dd2125266c5c4c26EB86cd61241132426Fe7) |
| Ratio Provider       |        [WSTETH-STETH Exchange Rate](https://plasmascan.to/address/0xd64d26cAd5f672463c33f91cE5b243d24cF7a903) |  [WRSETH-ETH Exchange Rate](https://plasmascan.to/address/0xee3d5f65B03fabA5B2bF2eCE893399EA88b18e78) |
| Oracle Latest Answer |                                                                                (2025-10-15) USD 5016.55868936 |                                                                        (2025-09-30) USD 4388.18307326 |
| min snapshot         |                                                                                                        7 days |                                                                                               14 days |
| max yearly growth    |                                                                                                         9.68% |                                                                                                 9.83% |

### wrsETH/WETH Emode

| Parameter             | wrsETH | WETH | WSTETH |
| --------------------- | ------ | ---- | ------ |
| Collateral            | Yes    | No   | No     |
| Borrowable            | No     | Yes  | Yes    |
| Max LTV               | 93%    | -    | -      |
| Liquidation Threshold | 95%    | -    | -      |
| Liquidation Bonus     | 1.0%   | -    | -      |

### wstETH/WETH E-Mode

| Parameter             | wstETH | WETH |
| --------------------- | ------ | ---- |
| Collateral            | Yes    | No   |
| Borrowable            | Yes    | Yes  |
| Max LTV               | 94%    | -    |
| Liquidation Threshold | 96%    | -    |
| Liquidation Bonus     | 1.0%   | -    |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for wstETH, wrsETh and the corresponding aTokens.

## References

- Implementation: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/9247697ff4e69fb84944b6d7709cf15e301f86a7/src/20251007_AaveV3Plasma_OnboardWrsETHToAaveV3PlasmaInstance/AaveV3Plasma_OnboardWrsETHToAaveV3PlasmaInstance_20251007.sol)
- Tests: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/9247697ff4e69fb84944b6d7709cf15e301f86a7/src/20251007_AaveV3Plasma_OnboardWrsETHToAaveV3PlasmaInstance/AaveV3Plasma_OnboardWrsETHToAaveV3PlasmaInstance_20251007.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-wrseth-to-aave-v3-plasma-instance/23183)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
