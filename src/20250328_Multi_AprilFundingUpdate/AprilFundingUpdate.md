---
title: "April Funding update"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-april-funding-update/21590"
---

## Simple Summary

This publication presents the April Funding Update, consisting of the following key activities:

- Bridge funds to Ethereum;
- Deposit idle funds in Aave v3;
- Fund Sonic incentive campaign;
- Acquire GHO for Operations; and,
- Transfer FLUID to Aave Protocol Embassy.

## Motivation

This publication combines near term operational needs and migrating assets held on Polygon in preparation for funding future incentive campaigns. The below outlines the three objectives of this publication:

- Consolidating funds to Ethereum;
- Fulfilling near term operation requirements; and,
- Deploying idle funds on Base and Arbitrum.

### Bridge Funds to Ethereum

Each month the DAO’s funds held on Polygon are to be bridged to Ethereum where they will be used to support various incentive and buyback programs. With the pending Umbrella, Horizon and AAVE buybacks to start in the near future, consolidating assets on Ethereum ensures sufficient capital is readily available if required.

### Acquire GHO

In the near term we expect several initiatives to request funding from the DAO. This proposal when implemented will acquire sufficient GHO to sustain the DAO until the Finance Steward is deployed ensuring the DAO is well capitalised at all times.

Examples of near term expenses include:

- Service Provider renewal;
- Merit and ALC; and,
- Incentive campaign(s).

### Deploy Idle Capital

To promote capital efficiency, some passive assets held idle on Base and Arbitrum are to be deposited into Aave to earn yield. In the event any incentive program emerge, the DAOs funds are fully allocated and generating cashflow for the DAO.

## Specification

This proposal shall be submitted as several AIPs that align with operational readiness timelines and ease of review given the volume of funds being moved.

### Polygon & Arbitrum - Bridge Assets to Ethereum

Withdraw from respective Aave Protocol and bridge the following assets to Ethereum.

| Polygon v3 | Polygon v2 | Polygon |
| :--------: | :--------: | :-----: |
|  aPolUSDC  |   amUSDC   | USDC.e  |
|  aPolUSDT  |   amUSDT   |  USDT   |
|  aPolWETH  |   amWETH   |  WETH   |
|  aPolDAI   |   amDAI    |   DAI   |

When asset are withdrawn from Aave Protocol, 1 unit will remain to ensure a no zero balance is always maintained.

Upon being received on Ethereum, subject to the Finance Steward being deployed:

### Ethereum - Acquire GHO

Withdraw the following asset from Aave v2 instance on Ethereum, swap to GHO and deposit into Aave v3 Prime instance.

| Ethereum v2 | Amount |
| :---------: | :----: |
|    aUSDT    | 2.00M  |
|    aUSDC    | 2.00M  |

This GHO will provide sufficient runway to cover the next few months of Merit and Service Provider expenses being paid from Aave v3 Prime instance.

### Ethereum - Aave Protocol Embassy & Sonic Incentives

Transfer FLUID held in the Treasury to Aave Protocol Embassy SAFE on Ethereum:

SAFE: `0xa9e777D56C0Ad861f6a03967E080e767ad8D39b6``

Create an Allowance to fund Sonic Incentive Campaign, 0.8M aEthUSDC, from Aave v3 Core instance to Merit address:

SAFE: `0xdeadD8aB03075b7FBA81864202a2f59EE25B312b``

### Base & Arbitrum - Deposit Passively Held Assets into Aave

Deposit the following assets into Aave v3 on Arbitrum and Base respectively.

| Arbitrum | Base  |
| :------: | :---: |
|   USDC   | USDC  |
|   WETH   | WETH  |
|   USDT   | cbBTC |
|   wBTC   | cbETH |
|   ARB    |       |
|  wstETH  |       |
|   GHO    |       |
|   LINK   |       |

By doing this idle capital is deployed and funds are consolidated ahead of any potential funding request.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250328_Multi_AprilFundingUpdate/AaveV3Ethereum_AprilFundingUpdate_20250328.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250328_Multi_AprilFundingUpdate/AaveV3Polygon_AprilFundingUpdate_20250328.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250328_Multi_AprilFundingUpdate/AaveV3Arbitrum_AprilFundingUpdate_20250328.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250328_Multi_AprilFundingUpdate/AaveV3Base_AprilFundingUpdate_20250328.sol),
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250328_Multi_AprilFundingUpdate/AaveV3Ethereum_AprilFundingUpdate_20250328.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250328_Multi_AprilFundingUpdate/AaveV3Polygon_AprilFundingUpdate_20250328.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250328_Multi_AprilFundingUpdate/AaveV3Arbitrum_AprilFundingUpdate_20250328.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250328_Multi_AprilFundingUpdate/AaveV3Base_AprilFundingUpdate_20250328.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-april-funding-update/21590)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
