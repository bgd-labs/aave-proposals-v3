---
title: "Aave v2 Deprecation - Update"
author: "@TokenLogic & BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-aave-v2-deprecation-update/23008/2"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x0c5427caf17d21b321a3b62362d085e580446b136b0eccf7f4dc377856025486"
---

## Simple Summary

This proposal presents the next round of parameter updates to be implemented as we work towards deprecating v2 instances of Aave Protocol across Polygon, Ethereum and Avalanche.

## Motivation

This proposal builds on previous efforts that froze both Polygon v2 and Avalanche v2, supporting the deprecation of Aave v2 and ensuring a smooth, controlled, and secure transition to Aave v3.

The proposed changes are designed to increase borrowing costs through adjustments to the interest rate curve parameters, creating stronger incentives for users to migrate to Aave v3. Where practical, a standardized approach of reducing the Uoptimal parameter has been applied, alongside adjustments to the Base and Slope1 parameters to raise borrow rates. At the same time, the Slope2 parameter has been reduced to avoid excessive borrowing costs at near-full utilization. Overall, these changes raise borrow rates without exposing users to extreme costs.

The updated Uoptimal parameter now exceeds current reserve utilization levels and is expected to be progressively lowered toward a 25% target.

For commonly borrowed assets, the Base parameter is increased to 5%, with further increases planned as reserve liquidity decreases. This gradual adjustment ensures a minimum borrow rate is always maintained.

Additionally, the Reserve Factor is increased to 85%, resulting in lower deposit rates that discourage idle capital remaining in v2.

These changes represent a coordinated effort among several service providers to align incentives and ensure the long-term health of the Aave ecosystem.

---

As a follow up to the [previous deprecation proposal](https://vote.onaave.com/proposal/?proposalId=378&ipfsHash=0x81a22e1d8c05b3061c45954cc83c807553fed9fae55cb6e074edf8f8557f5f8b) this proposal includes the following changes:

- In proposal 378, the metadata(symbol & name) was incorrectly configured on the aWBTC implementation due to minor technical differences between the different v2 versions. Therefore, this proposal will update the aWBTC implementation on mainnet `Core`, with a code-wise identical but correctly initialized version.
- In proposal 378, the clinic steward was configured with estimated budgets based on the existing bad debt following the same practice as on [v3 activation](https://vote.onaave.com/proposal/?proposalId=270&ipfsHash=0x4043001b72316afa6b6728772941bfa08f127b66c1c006316a3f20510b6738ab) - namely taking the current deficit and adding a minor(5%) buffer on top.
  While on v3 this worked fine, on v2 this estimation fell short. The `ClinicSteward` overestimated debt whenever a position is not clean, meaning when there is residual collateral. On v2 mainnet, this situation is far more common than on v3, which was not considered in the budget planning. Therefore this proposal sets the available budget to 1M$ on `Core` and 2.5k on `AMM`, respectively so the remaining bad debt can be covered. It's important to note that the configured "budget" does not directly reflect the amount spent, but is just a safety net on the clinic steward. The overall funds spent will not exceed the total bad debt.

## Specification

### Ethereum v2

RF / Base / Uoptimal

| Asset | RF Current | RF Proposed | Base Current | Base Proposed | Uoptimal Current | Uoptimal Proposed |
| ----- | ---------- | ----------- | ------------ | ------------- | ---------------- | ----------------- |
| wETH  | 85.00%     | 85.00%      | 0.00%        | 5.00%         | 80.00%           | 25.00%            |
| wBTC  | 90.00%     | 90.00%      | 0.00%        | 20.00%        | 65.00%           | 25.00%            |
| USDC  | 70.00%     | 85.00%      | 0.00%        | 5.00%         | 90.00%           | 60.00%            |
| USDT  | 70.00%     | 85.00%      | 0.00%        | 5.00%         | 80.00%           | 40.00%            |
| DAI   | 70.00%     | 85.00%      | 0.00%        | 5.00%         | 80.00%           | 50.00%            |

Slopes

| Asset | Slope1 Current | Slope1 Proposed | Slope2 Current | Slope2 Proposed |
| ----- | -------------- | --------------- | -------------- | --------------- |
| wETH  | 3.80%          | 5.00%           | 80.00%         | 40.00%          |
| wBTC  | 0.00%          | 0.00%           | 300.00%        | 40.00%          |
| USDC  | 12.50%         | 12.50%          | 60.00%         | 40.00%          |
| USDT  | 12.50%         | 12.50%          | 60.00%         | 40.00%          |
| DAI   | 12.50%         | 12.50%          | 60.00%         | 40.00%          |

Additionally:

- freeze all reserves on Ethereum V2 `Core` via `ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).freezeReserve(asset)`.
- updates the aWBTC impl on `Core` via `AaveV2Ethereum.POOL_CONFIGURATOR.updateAToken(AaveV2EthereumAssets.WBTC_UNDERLYING, WBTC_IMPL)`.
- renews the budget for `Core`via `IClinicSteward(AaveV2Ethereum.CLINIC_STEWARD).setAvailableBudget(1_000_000e8)`.
- renews the budget for `AMM` via `IClinicSteward(AaveV2EthereumAMM.CLINIC_STEWARD).setAvailableBudget(2_500e8)`.

### Polygon v2

RF / Base / Uoptimal

| Asset  | RF Current | RF Proposed | Base Current | Base Proposed | Uoptimal Current | Uoptimal Proposed |
| ------ | ---------- | ----------- | ------------ | ------------- | ---------------- | ----------------- |
| wETH   | 99.99%     | 99.99%      | 0.00%        | 5.00%         | 40.00%           | 25.00%            |
| wBTC   | 99.99%     | 99.99%      | 0.00%        | 20.00%        | 37.00%           | 25.00%            |
| USDC.e | 99.99%     | 99.99%      | 0.00%        | 5.00%         | 77.00%           | 65.00%            |
| DAI    | 99.99%     | 99.99%      | 0.00%        | 5.00%         | 71.00%           | 45.00%            |
| USDT   | 99.99%     | 99.99%      | 0.00%        | 5.00%         | 52.00%           | 35.00%            |
| POL    | 99.99%     | 99.99%      | 0.00%        | 5.00%         | 48.00%           | 25.00%            |

Slopes

| Asset  | Slope1 Current | Slope1 Proposed | Slope2 Current | Slope2 Proposed |
| ------ | -------------- | --------------- | -------------- | --------------- |
| wETH   | 10.00%         | 15.00%          | 134.00%        | 40.00%          |
| wBTC   | 0.00%          | 0.00%           | 134.00%        | 40.00%          |
| USDC.e | 15.00%         | 15.00%          | 134.00%        | 40.00%          |
| DAI    | 15.00%         | 15.00%          | 134.00%        | 40.00%          |
| USDT   | 15.00%         | 15.00%          | 134.00%        | 40.00%          |
| POL    | 12.00%         | 15.00%          | 134.00%        | 40.00%          |

### Avalanche v2

RF / Base / Uoptimal

| Asset  | RF Current | RF Proposed | Base Current | Base Proposed | Uoptimal Current | Uoptimal Proposed |
| ------ | ---------- | ----------- | ------------ | ------------- | ---------------- | ----------------- |
| wBTC.e | 99.99%     | 99.99%      | 20.00%       | 20.00%        | 45.00%           | 25.00%            |
| wETH   | 80.00%     | 85.00%      | 0.00%        | 5.00%         | 45.00%           | 25.00%            |
| USDC.e | 80.00%     | 85.00%      | 0.00%        | 5.00%         | 80.00%           | 25.00%            |
| AVAX   | 80.00%     | 85.00%      | 0.00%        | 5.00%         | 45.00%           | 25.00%            |
| USDT.e | 80.00%     | 85.00%      | 0.00%        | 5.00%         | 80.00%           | 45.00%            |
| DAI    | 80.00%     | 85.00%      | 0.00%        | 5.00%         | 80.00%           | 80.00%            |

Slopes

| Asset  | Slope1 Current | Slope1 Proposed | Slope2 Current | Slope2 Proposed |
| ------ | -------------- | --------------- | -------------- | --------------- |
| wBTC.e | 0.00%          | 0.00%           | 300.00%        | 40.00%          |
| wETH   | 10.00%         | 15.00%          | 300.00%        | 40.00%          |
| USDC.e | 0.00%          | 0.00%           | 75.00%         | 40.00%          |
| AVAX   | 5.00%          | 15.00%          | 300.00%        | 40.00%          |
| USDT.e | 9.00%          | 15.00%          | 75.00%         | 40.00%          |
| DAI    | 9.00%          | 15.00%          | 75.00%         | 40.00%          |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250925_Multi_AaveV2DeprecationUpdate/AaveV2Ethereum_AaveV2DeprecationUpdate_20250925.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250925_Multi_AaveV2DeprecationUpdate/AaveV2Polygon_AaveV2DeprecationUpdate_20250925.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250925_Multi_AaveV2DeprecationUpdate/AaveV2Avalanche_AaveV2DeprecationUpdate_20250925.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250925_Multi_AaveV2DeprecationUpdate/AaveV2Ethereum_AaveV2DeprecationUpdate_20250925.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250925_Multi_AaveV2DeprecationUpdate/AaveV2Polygon_AaveV2DeprecationUpdate_20250925.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250925_Multi_AaveV2DeprecationUpdate/AaveV2Avalanche_AaveV2DeprecationUpdate_20250925.t.sol)
- [AToken code diff](https://github.com/bgd-labs/aave-proposals-v3/blob/main/diffs/1_0x9ff58f4ffb29fa2266ab25e75e2a8b3503311656_0xA33eCc2125f6FD0b900945b149176D46f0474Ac4_0x5c7b3F858F8fBb4d1Fc525d51f82Cb5715c68c27.diff)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x0c5427caf17d21b321a3b62362d085e580446b136b0eccf7f4dc377856025486)
- [Discussion](https://governance.aave.com/t/arfc-aave-v2-deprecation-update/23008/2)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
