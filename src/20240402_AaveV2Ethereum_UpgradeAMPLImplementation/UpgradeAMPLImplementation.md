---
title: "Upgrade AMPL implementation"
author: "BGD Labs"
discussions: "https://governance.aave.com/t/arfc-aampl-interim-distribution/17184"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xb7226dd6441b67225924082215f7a512bfd98252897ee43a879084e07ab53607"
---

## Simple Summary

Disable withdrawals and transfers for aAMPL so a distribution snapshot can be taken.

## Motivation

Due to a problem in the aAMPL custom implementation, the supply and balances don't correspond to the claims of AMPL suppliers.
While work is being made to determined the exact claims, there has been a proposal for the distribution of an initial 300'000 USD. As there are still active AMPL borrow positions, a situation could occur in which a user repays his debt and another user withdraws their aAMPL, causing issues in for a fair distribution.

Therefore transfers aAMPL and withdrawals of AMPL will be disabled, while repayments and liquidations will stay intact.

In addition, after validating there is no impact of it on the borrow side, the interest rate strategy of AMPL is reverted to the one that was configured before [proposal 16](https://vote.onaave.com/proposal/?proposalId=16), when parameters where lowered for pre-caution.
The goal of this is to, as intended, still apply growth on the borrow side, specially for currently healthy positions (non-liquidated).

## Specification

The proposal will call:

- `AaveV2Ethereum.POOL_CONFIGURATOR.updateAToken(AaveV2EthereumAssets.AMPL_UNDERLYING, A_TOKEN_IMPL);` to replace the aToken implementation
- Change the AMPL interest rate strategy to the previous one, with the following configuration:

| Parameter      | Current | Recommended |
| -------------- | ------- | ----------- |
| Base           | 20%     | No Change   |
| Slope1         | 0%      | No Change   |
| Slope2         | 0%      | 300%        |
| Uoptimal       | 80%     | No Change   |
| Reserve Factor | 99.00%  | No Change   |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240402_AaveV2Ethereum_UpgradeAMPLImplementation/AaveV2Ethereum_UpgradeAMPLImplementation_20240402.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240402_AaveV2Ethereum_UpgradeAMPLImplementation/AaveV2Ethereum_UpgradeAMPLImplementation_20240402.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb7226dd6441b67225924082215f7a512bfd98252897ee43a879084e07ab53607)
- [Discussion](https://governance.aave.com/t/arfc-aampl-interim-distribution/17184)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
