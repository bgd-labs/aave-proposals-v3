---
title: "Add CoW Factories to flashBorrowers"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-whitelist-cow-protocol-adapters-as-flash-borrowers-on-aave-v3/24467"
---

## Simple Summary

This proposal seeks to register Aave Swap Adapter factories as approved flash borrowers across relevant Aave V3 instances, enabling them to access flash liquidity with zero flash loan fees.

This change improves execution quality for users interacting through Aave’s swap flows by removing an internal protocol fee that currently adds avoidable cost to adapter-based routing.

## Motivation

Aave swap adapters support collateral swaps and related position management flows inside the Aave experience. When a route requires flash liquidity, the flash loan premium is embedded directly in execution. That reduces output on collateral and debt swaps, and prolongs the payback period of debt swaps, which weakens the Aave route against external alternatives.

Whitelisting the CoW Swap Adapter factory removes that cost across the covered Aave V3 instances. CoW Swap Adapter routes that rely on flash liquidity will execute without a flash loan fee. Users will experience improved collateral and debt swap pricing on Aave V3. With better swap pricing, the Aave interface should retain more swap flow, especially debt swaps, within the Aave experience. Under the Aave Will Win Framework, the DAO is positioned to capture all revenue from that activity.

## Specification

The Aave DAO would authorize the registration of the relevant Aave swap adapter contracts as approved flash borrowers through the ACLManager.addFlashBorrower function on the applicable Aave V3 deployments.

Once registered, these adapters would be exempt from flash loan fees when using flash liquidity through the approved path.

The proposal payload would:

identify the swap adapter factory contract addresses to be registered

call addFlashBorrower for each factory on the relevant markets

CoW Swap Adapter Factory address

The CoW Swap Adapter Factory address to whitelist is: 0xdeCC46a4b09162F5369c5C80383AAa9159bCf192

Aave V3 instances included in scope

The payload will register 0xdeCC46a4b09162F5369c5C80383AAa9159bCf192 as an approved flash borrower on the following Aave V3 instances:

| Market        | Adapter Factory Address                    |
| ------------- | ------------------------------------------ |
| Ethereum Core | 0xdeCC46a4b09162F5369c5C80383AAa9159bCf192 |
| Base          | 0xdeCC46a4b09162F5369c5C80383AAa9159bCf192 |
| Arbitrum      | 0xdeCC46a4b09162F5369c5C80383AAa9159bCf192 |
| Gnosis        | 0xdeCC46a4b09162F5369c5C80383AAa9159bCf192 |
| Avalanche     | 0xdeCC46a4b09162F5369c5C80383AAa9159bCf192 |
| BNB Chain     | 0xdeCC46a4b09162F5369c5C80383AAa9159bCf192 |
| Polygon       | 0xdeCC46a4b09162F5369c5C80383AAa9159bCf192 |
| Linea         | 0xdeCC46a4b09162F5369c5C80383AAa9159bCf192 |
| Plasma        | 0xdeCC46a4b09162F5369c5C80383AAa9159bCf192 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Ethereum_AddCoWFactoriesToFlashBorrowers_20260506.sol), [AaveV3Polygon](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Polygon_AddCoWFactoriesToFlashBorrowers_20260506.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Avalanche_AddCoWFactoriesToFlashBorrowers_20260506.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Arbitrum_AddCoWFactoriesToFlashBorrowers_20260506.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Base_AddCoWFactoriesToFlashBorrowers_20260506.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Gnosis_AddCoWFactoriesToFlashBorrowers_20260506.sol), [AaveV3BNB](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3BNB_AddCoWFactoriesToFlashBorrowers_20260506.sol), [AaveV3Linea](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Linea_AddCoWFactoriesToFlashBorrowers_20260506.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Plasma_AddCoWFactoriesToFlashBorrowers_20260506.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Ethereum_AddCoWFactoriesToFlashBorrowers_20260506.t.sol), [AaveV3Polygon](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Polygon_AddCoWFactoriesToFlashBorrowers_20260506.t.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Avalanche_AddCoWFactoriesToFlashBorrowers_20260506.t.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Arbitrum_AddCoWFactoriesToFlashBorrowers_20260506.t.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Base_AddCoWFactoriesToFlashBorrowers_20260506.t.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Gnosis_AddCoWFactoriesToFlashBorrowers_20260506.t.sol), [AaveV3BNB](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3BNB_AddCoWFactoriesToFlashBorrowers_20260506.t.sol), [AaveV3Linea](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Linea_AddCoWFactoriesToFlashBorrowers_20260506.t.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Plasma_AddCoWFactoriesToFlashBorrowers_20260506.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-whitelist-cow-protocol-adapters-as-flash-borrowers-on-aave-v3/24467)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
