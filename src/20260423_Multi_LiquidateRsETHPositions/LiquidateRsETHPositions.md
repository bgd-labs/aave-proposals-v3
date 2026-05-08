---
title: "rsETH Incident: Liquidate rsETH attacker positions"
author: "Aave Labs"
discussions: https://governance.aave.com/t/rseth-incident-report-april-20-2026/24580
---

## Simple Summary

As part of the Defi United recovery effort and [technical plan](https://x.com/aave/status/2048958367658332413), this proposal executes liquidations against the identified rsETH attacker’s positions on Aave V3 Ethereum Core and Aave V3 Arbitrum, subject to each position being eligible for liquidation at execution time.

The proposal is intended to reduce outstanding bad debt risk, recover available rsETH collateral through normal Aave liquidation mechanics, and route any recovered value according to the DAO-approved rsETH incident recovery process.

## Motivation

On April 18, 2026, an external incident affecting Kelp’s LayerZero V2 Unichain–Ethereum rsETH route released 116,500 rsETH from the Ethereum-side OFT adapter to the attacker without a corresponding burn on the source chain. The incident was external to Aave. Aave’s smart contracts, oracles, repayment, and liquidation logic continued to function as designed. However, the attacker supplied 89,567 rsETH into Aave V3 and borrowed WETH and wstETH across Ethereum Core and Arbitrum markets.

These positions introduce direct protocol exposure backed by compromised rsETH. As rsETH accounting, backing, and redemption depend on external parties (Kelp, LayerZero, and others), the DAO should leverage protocol mechanisms to reduce risk. Executing standard Aave V3 liquidations on the attacker positions is the most straightforward path to recover rsETH collateral and contain bad debt exposure. This path prevents the attacker from withdrawing rsETH collateral, and allows the protocol to secure the collateral and halt further risk accumulation.

## Specification

This proposal authorizes and executes liquidation calls against the known rsETH exploit attacker positions on Aave V3 Ethereum Core and Aave V3 Arbitrum.

### Target Positions

| Market        | Attacker Address                             | Collateral Supplied |                 Debt Borrowed | Action                |
| ------------- | -------------------------------------------- | ------------------: | ----------------------------: | --------------------- |
| Ethereum Core | `0x1f4c1c2e610f089d6914c4448e6f21cb0db3adef` |     53,000.00 rsETH |                52,460.33 WETH | Liquidate if eligible |
| Ethereum Core | `0x8d11aeac74267dd5c56d371bf4ae1afa174c2d49` |        400.00 rsETH |                   394.06 WETH | Liquidate if eligible |
| Arbitrum      | `0xeba786c9517a4823a5cfd9c72e4e80bf8168129b` |     12,573.80 rsETH |                12,385.93 WETH | Liquidate if eligible |
| Arbitrum      | `0xcbb24a6b4dafaaa1a759a2f413ea0eb6ae1455cc` |      9,299.00 rsETH | 4,309.21 WETH and 8.13 wstETH | Liquidate if eligible |
| Arbitrum      | `0x1b748b680373a1dd70a2319261328cab2a6f644c` |      8,000.00 rsETH |                 7,880.48 WETH | Liquidate if eligible |
| Arbitrum      | `0xbb6a6006eb71205e977eceb19fcad1c8d631c787` |        770.00 rsETH |                   758.50 WETH | Liquidate if eligible |
| Arbitrum      | `0x8d11aeac74267dd5c56d371bf4ae1afa174c2d49` |      1,024.43 rsETH |  28.69 WETH and 813.12 wstETH | Liquidate if eligible |
| Arbitrum      | `0xe9e2f48bb0018276391aec240abb46e8c3cad181` |      4,500.00 rsETH |                 4,432.77 WETH | Liquidate if eligible |

### Aggregate Attacker Exposure

| Collateral Supplied | WETH Borrowed | wstETH Borrowed |
| ------------------: | ------------: | --------------: |
|        89,567 rsETH |   82,650 WETH |      821 wstETH |

Debt balances may differ slightly at proposal submission because borrow balances accrue continuously.

### Payload Actions

The main objective of the payload is to seize the rsETH collateral from the attacker’s positions while ensuring no impact to the rest of users. The recovered rsETH will be transferred to a newly created multisig wallet, the Recovery Guardian ([0x53cb4BB8F61fa45405dC75F476FaDAd801e653D9](https://etherscan.io/address/0x53cb4BB8F61fa45405dC75F476FaDAd801e653D9)), which will act on behalf of the DAO to manage and resolve the rsETH incident. This Safe wallet is composed of DAO Service Providers and will hold the collateral and execute the necessary actions for resolution.

The proposal also grants temporary permissions to the Recovery Guardian to update Umbrella parameters if needed. However, Umbrella is already configured within this proposal to account for the potential increase in deficit (up to the total attacker debt at the time of the exploit), ensuring that Umbrella stakers are not impacted (e.g., no slashing can occur) by this proposal. Additionally, the Recovery Guardian is granted permission to eliminate deficits on Aave V3 Ethereum Core and Arbitrum markets, enabling the protocol to clear bad debt and prevent further risk. Both permissions are intended to be revoked once the incident is resolved.

For each attacker position, the proposal executes the following steps:

1. Fetch position data and involved assets.
2. Adjust risk parameters to make the position eligible for liquidation.
3. Execute liquidations for rsETH/WETH or rsETH/wstETH on the relevant Aave V3 markets.
4. Convert WETH or wstETH debt into deficit (no longer accruing interest).
5. Transfer the seized rsETH collateral to the Recovery Guardian.

## References

- Implementation: [Ethereum User 1](https://github.com/aave-dao/aave-proposals-v3/blob/ade09504074d1e2ed0cc0b21f1cfc73a685e4bcb/src/20260423_Multi_LiquidateRsETHPositions/mainnet/AaveV3Ethereum_LiquidateRsETHPositionUser1_20260423.sol), [Ethereum User 2](https://github.com/aave-dao/aave-proposals-v3/blob/ade09504074d1e2ed0cc0b21f1cfc73a685e4bcb/src/20260423_Multi_LiquidateRsETHPositions/mainnet/AaveV3Ethereum_LiquidateRsETHPositionUser2_20260423.sol), [Arbitrum User 1](https://github.com/aave-dao/aave-proposals-v3/blob/ade09504074d1e2ed0cc0b21f1cfc73a685e4bcb/src/20260423_Multi_LiquidateRsETHPositions/arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser1_20260423.sol), [Arbitrum User 2](https://github.com/aave-dao/aave-proposals-v3/blob/ade09504074d1e2ed0cc0b21f1cfc73a685e4bcb/src/20260423_Multi_LiquidateRsETHPositions/arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser2_20260423.sol), [Arbitrum User 3](https://github.com/aave-dao/aave-proposals-v3/blob/ade09504074d1e2ed0cc0b21f1cfc73a685e4bcb/src/20260423_Multi_LiquidateRsETHPositions/arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser3_20260423.sol), [Arbitrum User 4](https://github.com/aave-dao/aave-proposals-v3/blob/ade09504074d1e2ed0cc0b21f1cfc73a685e4bcb/src/20260423_Multi_LiquidateRsETHPositions/arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser4_20260423.sol), [Arbitrum User 5](https://github.com/aave-dao/aave-proposals-v3/blob/ade09504074d1e2ed0cc0b21f1cfc73a685e4bcb/src/20260423_Multi_LiquidateRsETHPositions/arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser5_20260423.sol), [Arbitrum User 6](https://github.com/aave-dao/aave-proposals-v3/blob/ade09504074d1e2ed0cc0b21f1cfc73a685e4bcb/src/20260423_Multi_LiquidateRsETHPositions/arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser6_20260423.sol)
- Tests: [Ethereum User 1](https://github.com/aave-dao/aave-proposals-v3/blob/ade09504074d1e2ed0cc0b21f1cfc73a685e4bcb/src/20260423_Multi_LiquidateRsETHPositions/mainnet/AaveV3Ethereum_LiquidateRsETHPositionUser1_20260423.t.sol), [Ethereum User 2](https://github.com/aave-dao/aave-proposals-v3/blob/ade09504074d1e2ed0cc0b21f1cfc73a685e4bcb/src/20260423_Multi_LiquidateRsETHPositions/mainnet/AaveV3Ethereum_LiquidateRsETHPositionUser2_20260423.t.sol), [Arbitrum User 1](https://github.com/aave-dao/aave-proposals-v3/blob/ade09504074d1e2ed0cc0b21f1cfc73a685e4bcb/src/20260423_Multi_LiquidateRsETHPositions/arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser1_20260423.t.sol), [Arbitrum User 2](https://github.com/aave-dao/aave-proposals-v3/blob/ade09504074d1e2ed0cc0b21f1cfc73a685e4bcb/src/20260423_Multi_LiquidateRsETHPositions/arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser2_20260423.t.sol), [Arbitrum User 3](https://github.com/aave-dao/aave-proposals-v3/blob/ade09504074d1e2ed0cc0b21f1cfc73a685e4bcb/src/20260423_Multi_LiquidateRsETHPositions/arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser3_20260423.t.sol), [Arbitrum User 4](https://github.com/aave-dao/aave-proposals-v3/blob/ade09504074d1e2ed0cc0b21f1cfc73a685e4bcb/src/20260423_Multi_LiquidateRsETHPositions/arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser4_20260423.t.sol), [Arbitrum User 5](https://github.com/aave-dao/aave-proposals-v3/blob/ade09504074d1e2ed0cc0b21f1cfc73a685e4bcb/src/20260423_Multi_LiquidateRsETHPositions/arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser5_20260423.t.sol), [Arbitrum User 6](https://github.com/aave-dao/aave-proposals-v3/blob/ade09504074d1e2ed0cc0b21f1cfc73a685e4bcb/src/20260423_Multi_LiquidateRsETHPositions/arbitrum/AaveV3Arbitrum_LiquidateRsETHPositionUser6_20260423.t.sol)
- Snapshot: Direct-To-AIP
- [Discussion](https://governance.aave.com/t/rseth-incident-report-april-20-2026/24580)
- [DeFi United’s Restoration of rsETH Backing: Technical Implementation Plan](https://x.com/aave/status/2048958367658332413)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
