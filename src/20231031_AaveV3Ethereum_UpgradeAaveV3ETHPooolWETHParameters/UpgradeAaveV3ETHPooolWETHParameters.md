---
title: "Upgrade Aave V3 ETH Poool wETH parameters"
author: "Gauntlet, ACI"
discussions: "https://governance.aave.com/t/arfc-upgrade-aave-v3-eth-pool-weth-parameters/15110"
---

## Summary

The current yields of stETH and reth are 3.30% and 3.07% respectively. By adjusting the slope1 parameter of WETH, we aim to:

- Enhance Profitability in Leverage Loops: The proposed adjustment will make leverage loops more profitable for users.
- Align with stETH and reth Yields: The proposed adjustment aims to set the slope1 slightly below the current yields of stETH and reth, ensuring Aave remains competitive.

Increased utilization of ETH reserve is expected to partly compensate for the slight loss of protocol revenue due to lower interest rate equilibrium.

## Specification

| Chain       | Asset | Current Uopt | Recommended Uopt | Current Variable Slope 1 | Recommended Variable Slope 1 |
| ----------- | ----- | ------------ | ---------------- | ------------------------ | ---------------------------- |
| Ethereum v3 | WETH  | 90%          | 80%              | 3.8%                     | 2.8%                         |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/41f231cff476ad2c1c290b65e3577af9e2708f0c/src/20231031_AaveV3Ethereum_UpgradeAaveV3ETHPooolWETHParameters/AaveV3Ethereum_UpgradeAaveV3ETHPooolWETHParameters_20231031.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/41f231cff476ad2c1c290b65e3577af9e2708f0c/src/20231031_AaveV3Ethereum_UpgradeAaveV3ETHPooolWETHParameters/AaveV3Ethereum_UpgradeAaveV3ETHPooolWETHParameters_20231031.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x192a24fd2b3e1860ce4570c0773d82ab895d27cabf48dddd9bafba7e4e13851e)
- [Discussion](https://governance.aave.com/t/arfc-upgrade-aave-v3-eth-pool-weth-parameters/15110)

## Disclaimer

Gauntlet and ACI have not received any compensation from any third-party in exchange for recommending any of the actions contained in this proposal.

By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

_By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos._
