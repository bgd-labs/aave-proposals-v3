---
title: "Remove Frax from Isolation Mode"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-remove-frax-from-isolation-mode-and-onboard-sfrax-to-aave-v3-mainnet/18506"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x89f056f633646ee0676e226da41e2c6a7df756a7087204a96db8c3d74427244a"
---

## Simple Summary

This AIP proposes to remove FRAX from isolation mode and align its parameters with USDC

## Motivation

FRAX and Aave DAO have found more synergies over the last months. The FRAX team has responded with major updates to security on sfrxETH in response to BGD Labs feedback. FRAX has also initated governance proposals to add GHO to Frax Lend. There are ongoing conversations to have a FRAX AMO included into Aave v3. sFRAX was [previously accepted ](https://governance.aave.com/t/arfc-add-sfrax-on-ethereum-v3/16303) for onboarding in a previous [ARFC vote ](https://snapshot.org/#/aave.eth/proposal/0xdba99e9c8da24424447d7c7b70eff93ad5b6055714b5f34cf9859c923fb3a38a) before the introduction of CAPO feeds.

This proposal suggests removing FRAX from isolation mode to facilitate further AMO deployments.

## Specification

### Ethereum

| FRAX                    | value before | value after     |
| ----------------------- | ------------ | --------------- |
| Debt Ceiling            | 10,000,000 $ | no debt ceiling |
| ltv                     | 0 %          | 75 %            |
| Liquidation Threshold   | 72 %         | 78 %            |
| Liquidation Bonus       | 6 %          | 4.5 %           |
| Liquidation ProtocolFee | 10 %         | 20 %            |
| Reserve Factor          | 20 %         | 15 %            |
| Optimal UsageRatio      | 90 %         | 92 %            |
| Slope2                  | 75 %         | 60 %            |

### Arbitrum

| FRAX                  | value before | value after |
| --------------------- | ------------ | ----------- |
| debtCeiling           | 1,000,000 $  | 0 $         |
| ltv                   | 0 %          | 75 %        |
| liquidationThreshold  | 72 %         | 78 %        |
| liquidationBonus      | 6 %          | 5 %         |
| reserveFactor         | 20 %         | 15 %        |
| maxVariableBorrowRate | 80.5 %       | 65.5 %      |
| variableRateSlope2    | 75 %         | 60 %        |

### Avalanche

| FRAX                  | value before | value after |
| --------------------- | ------------ | ----------- |
| Debt Ceiling          | 1,000,000 $  | 0 $         |
| ltv                   | 0 %          | 75 %        |
| Liquidation Threshold | 77 %         | 81 %        |
| Liquidation Bonus     | 5 %          | 4 %         |
| Reserve Factor        | 20 %         | 15 %        |
| Slope2                | 75 %         | 60 %        |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240926_Multi_RemoveFraxFromIsolationMode/AaveV3Ethereum_RemoveFraxFromIsolationMode_20240926.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240926_Multi_RemoveFraxFromIsolationMode/AaveV3Avalanche_RemoveFraxFromIsolationMode_20240926.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240926_Multi_RemoveFraxFromIsolationMode/AaveV3Arbitrum_RemoveFraxFromIsolationMode_20240926.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240926_Multi_RemoveFraxFromIsolationMode/AaveV3Ethereum_RemoveFraxFromIsolationMode_20240926.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240926_Multi_RemoveFraxFromIsolationMode/AaveV3Avalanche_RemoveFraxFromIsolationMode_20240926.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240926_Multi_RemoveFraxFromIsolationMode/AaveV3Arbitrum_RemoveFraxFromIsolationMode_20240926.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x89f056f633646ee0676e226da41e2c6a7df756a7087204a96db8c3d74427244a)
- [Discussion](https://governance.aave.com/t/arfc-remove-frax-from-isolation-mode-and-onboard-sfrax-to-aave-v3-mainnet/18506)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
