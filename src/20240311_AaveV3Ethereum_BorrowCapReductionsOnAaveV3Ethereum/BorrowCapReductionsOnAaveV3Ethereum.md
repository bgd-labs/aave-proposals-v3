---
title: "Borrow Cap Reductions on Aave V3 Ethereum"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-borrow-cap-reductions-on-aave-ethereum-03-11-24/16918"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x9fb23244675bb07e1b5406fa4276aeeb712a80026721e2321ce41bd0e612de73"
---

## Simple Summary

Reduce Borrow Caps for long-tailed assets on Aave V3 Ethereum

## Motivation

As part of our ongoing 2 strategy to minimize theoretical exposure to long-tailed debt on Aave, this proposal aims to mitigate the impact of volatility in debt assets further by implementing a substantial reduction in Borrow Cap values. Borrowing these assets typically yields minimal revenue but can pose significant risks, particularly in scenarios where liquidating these positions necessitates obtaining the underlying asset during a large pump. Given the recent upward volatility in asset prices, we propose a refined methodology for determining and implementing these Borrow Cap reductions. This approach aims to enhance the protocol’s resilience and stability amidst dynamic market conditions, safeguarding the interests of Aave users and stakeholders.

## Specification

| Asset | Current Borrow Cap | Recommended Borrow Cap |
| ----- | ------------------ | ---------------------- |
| MKR   | 3k                 | 1.98k                  |
| LDO   | 3m                 | 1.5m                   |
| UNI   | 500k               | 330k                   |
| RPL   | 480k               | 316.8k                 |
| SNX   | 1.1m               | 150k                   |
| FXS   | 500k               | 330k                   |
| CRV   | 5m                 | 2.75m                  |
| STG   | 5.5m               | 3.2m                   |
| KNC   | 650k               | 350k                   |
| 1INCH | 720k               | 475.2k                 |
| BAL   | 370k               | 244.2k                 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/97030c4c8003fdb898abe9ab1e8b5a99882692c4/src/20240311_AaveV3Ethereum_BorrowCapReductionsOnAaveV3Ethereum/AaveV3Ethereum_BorrowCapReductionsOnAaveV3Ethereum_20240311.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/97030c4c8003fdb898abe9ab1e8b5a99882692c4/src/20240311_AaveV3Ethereum_BorrowCapReductionsOnAaveV3Ethereum/AaveV3Ethereum_BorrowCapReductionsOnAaveV3Ethereum_20240311.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x9fb23244675bb07e1b5406fa4276aeeb712a80026721e2321ce41bd0e612de73)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-borrow-cap-reductions-on-aave-ethereum-03-11-24/16918)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
