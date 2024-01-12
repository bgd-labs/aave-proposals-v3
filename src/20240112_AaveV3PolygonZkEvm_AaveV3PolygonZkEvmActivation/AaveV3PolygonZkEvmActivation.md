---
title: "Aave v3 Polygon ZkEvm activation"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-aave-v3-deployment-on-zkevm-l2/12615"
---

## Simple Summary

This proposal allows the Aave governance to activate the Aave V3 Polygon ZkEVM pool (3.0.2) by completing all the initial setup and listing WETH, USDC, MATIC as suggested by the service providers (ACI, Gauntlet and Chaos Labs) on the [governance forum](https://governance.aave.com/t/arfc-aave-v3-deployment-on-zkevm-l2/12615/32). All the Aave Polygon ZkEVM V3 addresses can be found in the [aave-address-book](https://github.com/bgd-labs/aave-address-book/blob/main/src/AaveV3PolygonZkEvm.sol).

## Motivation

All the governance procedures for the expansion of Aave v3 to Polygon ZkEVM have been finished, said:

- Positive signaling and approval regarding the expansion on the [governance forum](https://governance.aave.com/t/arfc-temp-check-mvp-v3-deployment-on-zkevm-mainnet/12145), [temp check snapshot](https://snapshot.org/#/aave.eth/proposal/0x0777eb4701023508c03825e2779e6189326ed9b3d1eb6e187d1f6e0f8d154605), and [final snapshot](https://snapshot.org/#/aave.eth/proposal/0x8fd34012029bec536f779b7bf46813beb57f42705b24acaf239e42353ddf7b8c).
- Positive technical evaluation done by BGD Labs of the Polygon ZkEVM chain network, as described in the [forum](https://governance.aave.com/t/bgd-aave-polygon-zkevm-infrastructure-technical-evaluation/14901) in detail.
- Positive risk analysis and assets/parameters recommendation by the service providers ACI, Gauntlet and Chaos Labs as commented on the forum.

## Specification

The proposal will do the following:

- Set risk steward and freezing steward as the risk admin by executing `ACL_MANAGER.addRiskAdmin()`.
- Set the guardian address as the pool admin by executing `ACL_MANAGER.addPoolAdmin()`.
  This is following the standard procedure of keeping pool admin on the Aave Guardian during the bootstrap period, for security.
- List the following assets on Aave V3 Polygon ZkEVM: WETH, USDC, MATIC.

The table below illustrates the initial suggested risk parameters for each asset.

| Risk Parameter                     | USDC                                                                                     |                                                                                     WETH |                                                                                    MATIC |
| ---------------------------------- | ---------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------: | ---------------------------------------------------------------------------------------: |
| Isolation Mode                     | false                                                                                    |                                                                                    false |                                                                                     true |
| Borrowable                         | ENABLED                                                                                  |                                                                                  ENABLED |                                                                                  ENABLED |
| Collateral Enabled                 | true                                                                                     |                                                                                     true |                                                                                     true |
| Supply Cap                         | 525,000                                                                                  |                                                                                      350 |                                                                                  700,000 |
| Borrow Cap                         | 500,000                                                                                  |                                                                                      280 |                                                                                  525,000 |
| Debt Ceiling                       | USD 0                                                                                    |                                                                                    USD 0 |                                                                                    USD 0 |
| LTV                                | 77 %                                                                                     |                                                                                     75 % |                                                                                     68 % |
| LT                                 | 80 %                                                                                     |                                                                                     78 % |                                                                                     73 % |
| Liquidation Bonus                  | 5 %                                                                                      |                                                                                      5 % |                                                                                    7.5 % |
| Liquidation Protocol Fee           | 10 %                                                                                     |                                                                                     10 % |                                                                                     10 % |
| Reserve Factor                     | 10 %                                                                                     |                                                                                     15 % |                                                                                     20 % |
| Base Variable Borrow Rate          | 0 %                                                                                      |                                                                                      0 % |                                                                                      0 % |
| Variable Slope 1                   | 6 %                                                                                      |                                                                                    3.3 % |                                                                                      5 % |
| Variable Slope 2                   | 80 %                                                                                     |                                                                                     80 % |                                                                                    100 % |
| Uoptimal                           | 90 %                                                                                     |                                                                                     80 % |                                                                                     75 % |
| Stable Borrowing                   | DISABLED                                                                                 |                                                                                 DISABLED |                                                                                 DISABLED |
| Stable Slope1                      | 6 %                                                                                      |                                                                                    3.3 % |                                                                                      5 % |
| Stable Slope2                      | 80 %                                                                                     |                                                                                     80 % |                                                                                    100 % |
| Base Stable Rate Offset            | 1 %                                                                                      |                                                                                      2 % |                                                                                      2 % |
| Stable Rate Excess Offset          | 8 %                                                                                      |                                                                                      8 % |                                                                                      8 % |
| Optimal Stable To Total Debt Ratio | 20 %                                                                                     |                                                                                     20 % |                                                                                     20 % |
| Flashloanable                      | ENABLED                                                                                  |                                                                                  ENABLED |                                                                                  ENABLED |
| Siloed Borrowing                   | DISABLED                                                                                 |                                                                                 DISABLED |                                                                                 DISABLED |
| Borrowable in Isolation            | ENABLED                                                                                  |                                                                                 DISABLED |                                                                                 DISABLED |
| Oracle                             | [LINK](https://zkevm.polygonscan.com/address/0x0167D934CB7240e65c35e347F00Ca5b12567523a) | [LINK](https://zkevm.polygonscan.com/address/0x97d9F9A00dEE0004BE8ca0A8fa374d486567eE2D) | [LINK](https://zkevm.polygonscan.com/address/0x7C85dD6eBc1d318E909F22d51e756Cf066643341) |

## References

- Implementation: [AaveV3PolygonZkEvm](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240112_AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation/AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112.sol)
- Tests: [AaveV3PolygonZkEvm](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240112_AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation/AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x8fd34012029bec536f779b7bf46813beb57f42705b24acaf239e42353ddf7b8c)
- [Discussion](https://governance.aave.com/t/arfc-aave-v3-deployment-on-zkevm-l2/12615)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
