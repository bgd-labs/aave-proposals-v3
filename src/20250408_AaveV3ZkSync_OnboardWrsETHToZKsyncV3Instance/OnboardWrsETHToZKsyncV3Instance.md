---
title: "Onboard wrsETH to ZKsync V3 Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-wrseth-to-zksync-v3-instance/20727"
snapshot: Direct-to-AIP
---

## Simple Summary

This is a proposal to onboard wrsETH to the Aave V3 ZKsync Instance allowing Aave users to supply wrsETH as collateral. This proposal will be under Direct to AIP, as there are already on other Aave Instances.

Additionally, this AIP will update the rsETH LST E-Mode of the Prime instance.

## Motivation

In order to benefit from the ongoing ZKsync Ignite incentives program, we propose onboarding assets which have proven popular on other Aave instances and are either whitelisted for Ignite incentives, or are good candidates for future whitelisting.

wrsETH is currently the only whitelisted liquid restaking token on ZKsync and has proven popular on the Aave Prime instance, therefore we believe should be onboarded to the Aave Instance on ZKsync too.

## Specification

The table below illustrates the configured risk parameters for **wrsETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (wrsETH)       |                                        700 |
| Borrow Cap (wrsETH)       |                                          1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                     0.05 % |
| LT                        |                                      0.1 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                       10 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x8d25c9de6DBAd9a9eadfB2CA4706034F6721d555 |

**Pricefeed details**

| Parameter            |                                                                                                      Value |
| -------------------- | ---------------------------------------------------------------------------------------------------------: |
| Oracle               | [Capped rsETH / ETH / USD ](https://era.zksync.network/address/0x8d25c9de6DBAd9a9eadfB2CA4706034F6721d555) |
| BASE/USD Oracle      |         [Chainlink ETH/USD](https://era.zksync.network/address/0x6D41d1dc818112880b40e26BD6FD347E41008eDA) |
| Ratio Provider       |                     [rsETH](https://era.zksync.network/address/0x7024c64Ad30Ebf224e417CfDE4438606d2b9B690) |
| Oracle Latest Answer |                                                                             (2025-05-27) USD 2726.41712463 |
| min snapshot         |                                                                                                    14 days |
| max yearly growth    |                                                                                                      9.83% |

### wrsETH/wstETH E-Mode

| Parameter           | Value  | Value  |
| ------------------- | ------ | ------ |
| Asset               | wrsETH | wstETH |
| Collateral          | Yes    | No     |
| Borrowable          | No     | Yes    |
| LTV                 | 92.50% | -      |
| LT                  | 94.50% | -      |
| Liquidation Penalty | 1.00%  | -      |

Additionally [0x95Cbff6e45C499d45dd8627f3ce179057B5Fbfcc](https://era.zksync.network/address/0x95Cbff6e45C499d45dd8627f3ce179057B5Fbfcc) has been set as the emission admin for wrsETH and the corresponding aToken.

### Prime rsETH LST E-Mode Update

| Parameter           | Value          | Value  |
| ------------------- | -------------- | ------ |
| Asset               | rsETH          | wstETH |
| Collateral          | Yes            | No     |
| Borrowable          | No             | Yes    |
| LTV                 | ~~92.50%~~ 93% | -      |
| LT                  | ~~94.50%~~ 95% | -      |
| Liquidation Penalty | 1.00%          | -      |

This E-Mode update come from this [AIP](https://governance.aave.com/t/arfc-lrt-and-wsteth-unification/21739#p-55276-rseth-ltv-lt-update-4). It wasn’t included in the AIP itself because it could be executed via the Risk Steward. However, since the new version of the Risk Steward has not yet been deployed on the Ethereum Prime instance, we’re currently unable to update the E-mode through it. As a result, we are proposing to bundle this change into the current rsETH ZkSync onboarding AIP.

## References

- Implementation: [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/1adee2dd31ea242f53628752df3184646e931ab7/zksync/src/20250408_AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance/AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance_20250408.sol)
- Tests: [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/1adee2dd31ea242f53628752df3184646e931ab7/zksync/src/20250408_AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance/AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance_20250408.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-onboard-wrseth-to-zksync-v3-instance/20727)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
