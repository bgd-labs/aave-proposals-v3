---
title: "GHO Stability Module"
author: "Aave Labs @aave"
discussions: "https://governance.aave.com/t/gho-stability-module-update/14442"
---

## Simple Summary

This AIP proposes the deployment of the GHO Stability Module (GSM), a system facilitating the conversion between GHO and two governance-accepted stablecoins, USDC and USDT, at a predetermined ratio.

The GSM has undergone thorough iterations of design, development, testing, and implementation with Aave Labs driving this process and actively seeking community feedback. Additionally, the security aspect was carefully addressed through collaboration with DAO service providers SigmaPrime and Certora for code reviews. Furthermore, an extra layer of security was added by commissioning an independent review from a security researcher (Emanuele Ricci [@stermi](https://governance.aave.com/u/stermi/summary)).

Following extensive community discussion and multiple phases of Aave DAO governance, this AIP suggests deploying two GSM contracts for seamless conversions between GHO and USDC as well as GHO and USDT.

## Motivation

The GHO Stability Module (GSM) is a contract designed to facilitate conversions between two tokens with its primary purpose being to help further maintain GHO's peg. The module allows swaps between GHO and other governance-accepted stablecoins, offering a variety of functionalities that make it paramount in the fields of security and risk management.

Summarizing the functionality offered by the GHO Stability Module (GSM), here is a list of these features and their planned implementation for this proposal:

- **Exposure Cap**: Denominated in token units, it limits exposure to the exogenous asset.
- **Price Strategies**: Utilizing a fixed price strategy with a 1:1 ratio for stablecoins.
- **Fee Strategies**: Employing a flat basis point (bps) approach, differentiated by direction (sell/buy).
- **Last Resort Liquidation**: Aave DAO is the exclusive entity granted with the role of last resort liquidation, empowering it to take control of GSM funds in worst-case scenarios.
- **Swap Freeze**: Aave DAO and a chainlink-automated keeper contract have the authority to freeze the swap functionality. The chainlink-automated keeper contract bases its actions on the price of the exogenous asset, freezing if the price is outside the range and unfreezing if inside the range.
- **Capital Allocation**: Supporting this feature by allowing ERC4626 assets as underlying assets. This enables redirecting the yield generated by the ERC4626 asset, while residing in the GSM contract, to the GHO Treasury.

## Specification

The proposed payload entails the comprehensive activation of GSM USDC and GSM USDT, involving the following steps:

1. Incorporate GSM USDC and GSM USDT as facilitators of the GHO Token on Ethereum.
2. Adjust the Fee Strategy for both GSMs to implement a 0.2% flat fee for both directions (buy/sell).
3. Add both GSMs to the GSM Registry.
4. Designate OracleSwapFreezer contracts and Aave DAO as SwapFreezer entities in each GSM contract, respectively.
5. Activate these OracleSwapFreezer contracts as keepers of the Aave DAO through AaveRobot with a funding of 80 LINK for each.

The table below outlines the initially proposed risk parameters for each GSM contract, as approved through the snapshot:

**GSM USDC**

| Parameter                                | Value           |
| ---------------------------------------- | --------------- |
| Underlying Price Range for Swap Freeze   | [0.99 - 1.01]   |
| Underlying Price Range for Swap Unfreeze | [0.995 - 1.005] |
| Buy Fee                                  | 0.2%            |
| Sell Fee                                 | 0.2%            |
| Exposure Cap                             | 500,000 USDC    |
| Facilitator Bucket Capacity              | 500,000 GHO     |
| Swap Active                              | True            |

**GSM USDT**

| Parameter                                | Value           |
| ---------------------------------------- | --------------- |
| Underlying Price Range for Swap Freeze   | [0.99 - 1.01]   |
| Underlying Price Range for Swap Unfreeze | [0.995 - 1.005] |
| Buy Fee                                  | 0.2%            |
| Sell Fee                                 | 0.2%            |
| Exposure Cap                             | 500,000 USDT    |
| Facilitator Bucket Capacity              | 500,000 GHO     |
| Swap Active                              | True            |

## References

- Implementation: [Gho](https://github.com/bgd-labs/aave-proposals-v3/blob/805130c7b383084accaf4aaa29ffeb4c3a3c53e7/src/20240119_Gho_GHOStabilityModule/Gho_GHOStabilityModule_20240119.sol)
- Tests: [Gho](https://github.com/bgd-labs/aave-proposals-v3/blob/805130c7b383084accaf4aaa29ffeb4c3a3c53e7/src/20240119_Gho_GHOStabilityModule/Gho_GHOStabilityModule_20240119.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xe9b62e197a98832da7d1231442b5960588747f184415fba4699b6325d7618842)
- [Discussion](https://governance.aave.com/t/gho-stability-module-update/14442)
- [GSM Repository](https://github.com/aave/gho-core/tree/main/src/contracts/facilitators/gsm)
- [GSM Audit Reports](https://github.com/aave/gho-core/tree/main/audits)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
