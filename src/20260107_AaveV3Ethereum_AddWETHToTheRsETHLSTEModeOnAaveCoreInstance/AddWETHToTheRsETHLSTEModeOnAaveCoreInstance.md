---
title: "Add WETH to the rsETH LST E-Mode on Aave Core Instance "
author: "Kelp DAO (implemented by Aavechan Initiative @aci via Skyward)"
discussions: "https://governance.aave.com/t/direct-to-aip-add-weth-to-the-rseth-lst-e-mode-on-aave-core-instance/23425"
---

## Simple Summary

This proposal seeks to extend utility for rsETH on the Aave V3 Core market by adding WETH debt to the current rsETH/LST E-Mode category.

## Motivation

The Aave Core market has recently experienced significant ETH inflows, increasing the available supply and lowering utilization. Maintaining a healthy utilization rate on WETH is crucial for protocol revenue and lender incentives.

rsETH is a liquid staking token issued by Kelp, already proven across Aave deployments as a robust collateral asset. Currently, rsETH suppliers on the Core instance can only borrow stablecoins and access the LST E-Mode, which limits their leverage strategies.

By adding WETH to the rsETH/LST E-Mode, the protocol unlocks classical rsETH/WETH yield maximising loops, historically one of the largest sources of borrowing demand on Aave.

Given the strong demand on the sidelines and proven growth potential of Kelp’s LRT ecosystem, we expect up to $1B in rsETH inflows, absorbing idle ETH liquidity on the Core market and restoring optimal utilization.

## Specification

**E-mode (rsETH LST Main) - Core**

| **Parameter**         | **rsETH** | **wstETH** | **ETHx** | **ETH** |
| --------------------- | --------- | --------- | --------- | ----- |
| Collateral            | Yes       | No        | No        | No    |
| Borrowable            | No        | Yes       | Yes       | Yes   |
| Max LTV               | 93.0%     | -         | -         | -     |
| Liquidation Threshold | 95.0%     | -         | -         | -     |
| Liquidation Bonus     | 1.0%      | -         | -         | -     |

## Useful Links

[[ARFC] Add rsETH to Aave V3 Ethereum](https://governance.aave.com/t/arfc-add-rseth-to-aave-v3-ethereum/17696)

[[Direct to AIP] Onboard rsETH to Aave V3 Avalanche Instance](https://governance.aave.com/t/direct-to-aip-onboard-rseth-to-aave-v3-avalanche-instance/23313)

rsETH Documentation: https://docs.kelpdao.xyz/

## Disclaimer

This proposal is powered by Skywards. The Aave Chan Initiative is not directly affiliated with Kelp DAO and did not receive compensation for creation of this proposal.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260107_AaveV3Ethereum_AddWETHToTheRsETHLSTEModeOnAaveCoreInstance/AaveV3Ethereum_AddWETHToTheRsETHLSTEModeOnAaveCoreInstance_20260107.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260107_AaveV3Ethereum_AddWETHToTheRsETHLSTEModeOnAaveCoreInstance/AaveV3Ethereum_AddWETHToTheRsETHLSTEModeOnAaveCoreInstance_20260107.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-add-weth-to-the-rseth-lst-e-mode-on-aave-core-instance/23425)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
