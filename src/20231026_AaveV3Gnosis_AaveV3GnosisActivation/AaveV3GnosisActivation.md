---
title: "Aave v3 Gnosis Activation"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-aave-v3-deployment-on-gnosischain/14695"
---

## Simple Summary

This proposal allows the Aave governance to activate the Aave V3 Gnosis pool (3.0.2) by completing all the initial setup and listing WETH, wstETH, GNO, USDC, wXDAI, EURe and sDAI as suggested by the service providers (ACI, Gauntlet and Chaos Labs) on the [governance forum](https://governance.aave.com/t/arfc-aave-v3-deployment-on-gnosischain/14695/7). All the Aave Gnosis V3 addresses can be found in the [aave-address-book](https://github.com/bgd-labs/aave-address-book/blob/main/src/AaveV3Gnosis.sol).

## Motivation

All the governance procedures for the expansion of Aave v3 to Gnosis have been finished, said:

- Positive signaling and approval regarding the expansion on the [governance forum](https://governance.aave.com/t/temp-check-aave-v3-deployment-on-gnosischain/14514), [temp check snapshot](https://snapshot.org/#/aave.eth/proposal/0x659d9d54c19fb6b00e1b6061331d3d7d5d5ceab552c76e24dc1a6fe9a15d2c8d), and [final snapshot](https://snapshot.org/#/aave.eth/proposal/0xb62c93a8b3590dc46eed92b223da5fcbbf6b52f1f79a0c2fcd80bbc0afea59d8).
- Positive technical evaluation done by BGD Labs of the Gnosis chain network, as described in the [forum](https://governance.aave.com/t/bgd-aave-gnosischain-infrastructure-technical-evaluation/14915) in detail.
- Positive risk analysis and assets/parameters recommendation by the service providers ACI, Gauntlet and Chaos Labs as commented on the forum.
- Additionally listing sDAI as approved separately on the [forum](https://governance.aave.com/t/arfc-sdai-onboarding-on-aave-v3-gnosis-pool/15111) and [snapshot](https://snapshot.org/#/aave.eth/proposal/0x31703294f1129b579e98f9384fc95ad39e13eafca127f036d0cc20e927d98f56).

## Specification

The proposal will do the following:

- Set risk steward and freezing steward as the risk admin by executing `ACL_MANAGER.addRiskAdmin()`.
- Set the guardian address as the pool admin by executing `ACL_MANAGER.addPoolAdmin()`.
  This is following the standard procedure of keeping pool admin on the Aave Guardian during the bootstrap period, for security.
- List the following assets on Aave V3 Gnosis: wETH, wstETH, GNO, USDC, wXDAI, sDAI, EURe.

The table below illustrates the initial suggested risk parameters for each asset, as passed via the snapshot.

|                                    | wETH           | wstETH         | GNO       | USDC    | wxDAI     | EURe      | sDAI      |
| ---------------------------------- | -------------- | -------------- | --------- | ------- | --------- | --------- | --------- |
| Loan To Value                      | 75%            | 75%            | 31%       | 77%     | 77%       | 0%        | 77%       |
| Liquidation Threshold              | 78%            | 78%            | 36%       | 80%     | 80%       | 0%        | 80%       |
| Liquidation Protocol Fee           | 10%            | 10%            | 10%       | 20%     | 20%       | 10%       | 20%       |
| Liquidation Bonus                  | 6%             | 6%             | 10%       | 5%      | 5%        | 0%        | 5%        |
| Reserve Factor                     | 15%            | 15%            | 15%       | 10%     | 10%       | 15%       | 10%       |
| Enable Borrow                      | Yes            | Yes            | No        | Yes     | Yes       | Yes       | No        |
| Enable Collateral                  | Yes            | Yes            | Yes       | Yes     | Yes       | No        | Yes       |
| Supply Cap                         | 4000 wETH      | 4000 wstETH    | 30000 GNO | 1M USDC | 1.5M xDAI | 0.5M EURe | 1.5M sDAI |
| Borrow Cap                         | 3500 wETH      | 400 wstETH     | 0 GNO     | 1M USDC | 1.5M xDAI | 0.5M EURe | 0 sDAI    |
| E-mode category                    | ETH Correlated | ETH Correlated | None      | None    | None      | None      | None      |
| Isolation Mode                     | No             | No             | Yes       | No      | No        | No        | No        |
| Flashloanable                      | Yes            | Yes            | Yes       | Yes     | Yes       | Yes       | Yes       |
| Siloed Borrowing                   | No             | No             | No        | No      | No        | No        | No        |
| Debt Ceiling                       | 0              | 0              | $1M       | 0       | 0         | 0         | 0         |
| Stable Borrow                      | No             | No             | No        | No      | No        | No        | No        |
| uOptimal                           | 80%            | 45%            | 45%       | 90%     | 90%       | 90%       | 90%       |
| Base Variable Borrow Rate          | 0%             | 0%             | 0%        | 0%      | 0%        | 0%        | 0%        |
| Variable Rate Slope1               | 3.3%           | 7%             | 7%        | 5%      | 5%        | 4%        | 4%        |
| Variable Rate Slope 2              | 80%            | 300%           | 300%      | 75%     | 75%       | 75%       | 75%       |
| Stable Rate Slope 1                | 4%             | 7%             | 7%        | 5%      | 5%        | 4%        | 4%        |
| Stable Rate Slope 2                | 80%            | 300%           | 300%      | 75%     | 75%       | 75%       | 75%       |
| Base Stable Rate Offset            | 2%             | 2%             | 2%        | 1%      | 1%        | 1%        | 1%        |
| Stable Rate Excess Offset          | 8%             | 8%             | 8%        | 8%      | 8%        | 8%        | 8%        |
| Optimal Stable To Total Debt Ratio | 20%            | 20%            | 20%       | 20%     | 20%       | 20%       | 20%       |

<br/>

**E-Mode:**

| Category Id | Category Label | Assets included | LT  | LTV | Liquidation Bonus |
| ----------- | -------------- | --------------- | --- | --- | ----------------- |
| 1           | ETH Correlated | WETH, wstETH    | 93% | 90% | 1%                |

<br/>

sDAI adapter: [0x1D0f881Ce1a646E2f27Dec3c57Fa056cB838BCC2](https://gnosisscan.io/address/0x1D0f881Ce1a646E2f27Dec3c57Fa056cB838BCC2)

wstETH adapter: [0xcb0670258e5961cca85d8f71d29c1167ef20de99](https://gnosisscan.io/address/0xcb0670258e5961cca85d8f71d29c1167ef20de99)

Risk Steward: [0x33AE1f41546a2e05368Bf789b3d868813c0Ae658](https://gnosisscan.io/address/0x33AE1f41546a2e05368Bf789b3d868813c0Ae658)

Freezing Steward: [0x3Ceaf9b6CAb92dFe6302D0CC3F1BA880C28d35e5](https://gnosisscan.io/address/0x3Ceaf9b6CAb92dFe6302D0CC3F1BA880C28d35e5)

## Security

The proposal execution is simulated within the tests and the resulting pool configuration is tested for correctness.

The deployed pool and other permissions have been programmatically verified.

In addition, we have also checked the code diffs of the deployed base contracts with the deployed contracts on Ethereum and other networks.

As a matter of caution, the `POOL_ADMIN` role will be given for the first weeks to the Aave Guardian multisig.

## References

- Implementation: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/1450026743363bc47be00702fd058a6dda9c841b/src/20231026_AaveV3Gnosis_AaveV3GnosisActivation/AaveV3Gnosis_AaveV3GnosisActivation_20231026.sol)
- Tests: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/1450026743363bc47be00702fd058a6dda9c841b/src/20231026_AaveV3Gnosis_AaveV3GnosisActivation/AaveV3Gnosis_AaveV3GnosisActivation_20231026.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb62c93a8b3590dc46eed92b223da5fcbbf6b52f1f79a0c2fcd80bbc0afea59d8)
- [Discussion](https://governance.aave.com/t/arfc-aave-v3-deployment-on-gnosischain/14695)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
