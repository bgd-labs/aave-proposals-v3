---
title: "Aave V3 LTV and E-Mode Update"
author: "Llama Risk (implemented by Aave Labs)"
discussions: "https://governance.aave.com/t/direct-to-aip-aave-v3-ltv-and-e-mode-update/25067"
---

## Simple Summary

LlamaRisk recommends the following changes:

- Decrease LTV for PYUSD on Ethereum Core from 75% to 0%.

- Decrease LTV for AUSD on Avalanche from 69% to 0%.

- Decrease LTV for wstETH on Gnosis from 75% to 0%.

- Decrease LTV for WETH on Mantle from 80.5% to 0%.

- Decrease LTV for WMNT on Mantle from 40% to 0%.

- Introduce a new WMNT Stablecoins E-Mode.

- Increase borrow cap for wstETH on Ethereum Core from 1 to 7,000.

- Increase borrow cap for wstETH on Ethereum Prime from 1 to 18,000.

## Motivation

As per Llamarisk:

### PYUSD Ethereum Core

PYUSD can be used as collateral on the Ethereum Core market, where currently 17M PYUSD is being supplied. Assets worth $3.3M are currently being borrowed against it, with the majority consisting of USDe debt at $2.49M (73.8%), followed by USDC at $367K and cbBTC at $142K. Together, these three assets account for roughly 89% of total borrowings.

Given the low demand for PYUSD as collateral and the broader strategy to maintain collateral utility only for blue-chip stablecoins, we recommend disabling PYUSD’s collateralization.

#### Recommendation

We recommend decreasing PYUSD LTV on Ethereum Core from 75% to 0%.

### AUSD Avalanche

AUSD on Avalanche has a total supply of ~$200K with collateral currently enabled. However, similar to PYUSD, it has seen very limited use as collateral, with just $39.4K in debt borrowed against it. The majority of this debt is DAI at 44%, followed by AUSD (self-loop) at 19.5%. Therefore, we also recommend disabling AUSD collateralization for similar reasons.

#### Recommendation

We recommend decreasing AUSD LTV on Avalanche from 69% to 0%.

### wstETH Gnosis

wstETH liquidity on Gnosis has declined, with currently only 154 wstETH worth ~$317K available to be swapped against stables. Given the utility of wstETH, where a total of $12.3M in debt has been borrowed against wstETH collateral, the majority comprising EURe, we recommend decreasing the wstETH LTV to 0% outside E-Mode until liquidity conditions improve.

#### Recommendation

To address wstETH liquidity concerns on Gnosis, we recommend decreasing the wstETH LTV outside E-Mode from 75% to 0%.

### WETH Mantle

Currently, only 7.7 WETH ($14.6K) is available for WETH-to-USDT0 swaps at a 5.5% price impact, reflecting relatively shallow market depth. At the same time, there is ~$11M stablecoin debt, meaning Aave is already significantly exposed to illiquidity risk stemming from stablecoin borrows against WETH collateral. With the removal of the debt ceiling in v3.7, there is a risk of further unchecked debt accumulation.

#### Recommendation

To mitigate this risk, we recommend reducing the LTV for WETH to 0%, effectively disabling its use as collateral. Should liquidity conditions on Mantle improve, a dedicated WETH-stablecoin E-Mode can be introduced in the future.

### WMNT Mantle

Compared to WETH, WMNT liquidity on Mantle is significantly deeper, with up to 2M WMNT ($1.23M) swappable to USDT0 within a 10% price impact. The observed intended use case is stablecoin borrowing against WMNT collateral, as shown below.

#### Recommendation

To prevent the growth of non-stablecoin borrows, given the volatile nature of WMNT collateral, we recommend reducing WMNT LTV to 0% and setting up a new stablecoin E-Mode.

### wstETH Ethereum

Following the oracle misconfiguration incident, the wstETH borrow caps on the Ethereum Core and Prime instances were temporarily reduced to 1 as a precautionary measure. Since the issue was resolved, these borrow caps have remained unchanged. We recommend restoring the wstETH borrow caps to operational levels.

## Specification

### LTV Update

| Instance      | Asset  | Current LTV | Recommended LTV |
| ------------- | ------ | ----------- | --------------- |
| Ethereum Core | PYUSD  | 75%         | 0%              |
| Avalanche     | AUSD   | 69%         | 0%              |
| Gnosis        | wstETH | 75%         | 0%              |
| Mantle        | WETH   | 80.5%       | 0%              |
| Mantle        | WMNT   | 40%         | 0%              |

### WMNT Stablecoin E-Mode

| Parameter             | Value | Value | Value | Value |
| --------------------- | ----- | ----- | ----- | ----- |
| Asset                 | WMNT  | USDT0 | USDC  | GHO   |
| Collateral            | Yes   | No    | No    | No    |
| Borrowable            | No    | Yes   | Yes   | Yes   |
| Isolated              | Yes   | -     | -     | -     |
| Max LTV               | 40%   | -     | -     | -     |
| Liquidation Threshold | 45%   | -     | -     | -     |
| Liquidation Bonus     | 10%   | -     | -     | -     |

### wstETH Borrow Cap Restoration

| Instance       | Asset  | Current Borrow Cap | Recommended Borrow Cap |
| -------------- | ------ | ------------------ | ---------------------- |
| Ethereum Core  | wstETH | 1                  | 7,000                  |
| Ethereum Prime | wstETH | 1                  | 18,000                 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3Ethereum_AaveV3LTVAndEModeUpdate_20260707.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3Avalanche_AaveV3LTVAndEModeUpdate_20260707.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3Gnosis_AaveV3LTVAndEModeUpdate_20260707.sol), [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3Mantle_AaveV3LTVAndEModeUpdate_20260707.sol), [AaveV3EthereumLido](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3EthereumLido_AaveV3LTVAndEModeUpdate_20260707.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3Ethereum_AaveV3LTVAndEModeUpdate_20260707.t.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3Avalanche_AaveV3LTVAndEModeUpdate_20260707.t.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3Gnosis_AaveV3LTVAndEModeUpdate_20260707.t.sol), [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3Mantle_AaveV3LTVAndEModeUpdate_20260707.t.sol), [AaveV3EthereumLido](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260707_Multi_AaveV3LTVAndEModeUpdate/AaveV3EthereumLido_AaveV3LTVAndEModeUpdate_20260707.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-aave-v3-ltv-and-e-mode-update/25067)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
