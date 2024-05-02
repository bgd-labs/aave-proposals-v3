---
title: "Updating weETH Risk Parameters"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-updating-weeth-risk-parameters/17402"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xf01d857c392a5d3efcd69725cdee5a5d8e94e5cbe952791d24ff26a26f2b83fa"
---

## Simple Summary

This proposal aims to update the risk parameters and interest rate strategy of the weETH asset on the Ethereum pool to boost Aave DAO revenue and encourage collateral adoption.

## Motivation

The successful onboarding of EtherFI into Aave has demonstrated significant demand for weETH usage as both collateral and a borrowing asset, with both initial supply caps reached in minutes and second cap increases filled under similar conditions. To accommodate this demand and facilitate protocol growth, this proposal suggests increasing the supply cap of weETH on the Ethereum pool and the borrow cap at 35% of the new supply cap amount. This proposal also aims at changing the interestRate Strategy to place the optimal ratio at 35% of liquidity.

Expanding borrow capacity will result in a higher collateral yield, which in turn creates a positive flywheel effect on supply and demand. By maintaining the borrow cap at an optimal ratio (35%) of the supply cap, we can balance risk, available liquidity, and LP yield effectively.

We also propose to increase weETH RF to 45% to contribute to Aave DAO revenue.

## Specification

The following changes will be made to the **weETH** asset on Aave EthereumV3:

| Parameters     | Current | Recommended |
| -------------- | ------- | ----------- |
| Supply Cap     | 48,000  | 84,000      |
| Borrows Caps   | 3,200   | 29,500      |
| UOpt           | 45%     | 35%         |
| Reserve Factor | 15%     | 45%         |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240426_AaveV3Ethereum_UpdatingWeETHRiskParameters/AaveV3Ethereum_UpdatingWeETHRiskParameters_20240426.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240426_AaveV3Ethereum_UpdatingWeETHRiskParameters/AaveV3Ethereum_UpdatingWeETHRiskParameters_20240426.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xf01d857c392a5d3efcd69725cdee5a5d8e94e5cbe952791d24ff26a26f2b83fa)
- [Discussion](https://governance.aave.com/t/arfc-updating-weeth-risk-parameters/17402)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
