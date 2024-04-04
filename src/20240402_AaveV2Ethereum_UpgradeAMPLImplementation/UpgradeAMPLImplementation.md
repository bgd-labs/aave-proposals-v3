---
title: "Upgrade AMPL implementation"
author: "BGD Labs"
discussions: "https://governance.aave.com/t/arfc-aampl-interim-distribution/17184"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xb7226dd6441b67225924082215f7a512bfd98252897ee43a879084e07ab53607"
---

## Simple Summary

Disable withdrawals and transfers for aAMPL so a distribution snapshot can be taken.

## Motivation

Due to a problem in the aAMPL implementation there are currently aAMPL tokens that are not backed by underlying AMPL.
To make the users whole, a proposal was created to distribute an initial 300k USDC to compensate users proportionally, why working out the exact numbers for a final compensation. As there are still active AMPL borrow positions, a situation could occur in which a user repays there debt and another user withdrawing their aAMPL, causing issues in for a fair distribution.

Therefore transfers and withdrawals will be permanently disabled, while repayments and liquidations will stay intact.

## Specification

The proposal will call:

- `AaveV2Ethereum.POOL_CONFIGURATOR.updateAToken(AaveV2EthereumAssets.AMPL_UNDERLYING, A_TOKEN_IMPL);` to replace the aToken implementation

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240402_AaveV2Ethereum_UpgradeAMPLImplementation/AaveV2Ethereum_UpgradeAMPLImplementation_20240402.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240402_AaveV2Ethereum_UpgradeAMPLImplementation/AaveV2Ethereum_UpgradeAMPLImplementation_20240402.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb7226dd6441b67225924082215f7a512bfd98252897ee43a879084e07ab53607)
- [Discussion](https://governance.aave.com/t/arfc-aampl-interim-distribution/17184)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
