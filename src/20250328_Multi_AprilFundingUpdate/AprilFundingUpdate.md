---
title: "April Funding update"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-april-funding-update/21590"
---

## Simple Summary

This publication presents the April Funding Update, consisting of the following key activities:

- Bridge funds to Ethereum;
- Fund Sonic incentive campaign;
- Acquire GHO for Operations; and,
- Transfer FLUID to Aave Protocol Embassy.
- Fund to [CrossChainController](https://etherscan.io/address/0xEd42a7D8559a463722Ca4beD50E0Cc05a386b0e1)
- Update stataUSDT GSM Exposure Cap as it has successfully drawn swaps from aggregators

## Motivation

This publication combines near term operational needs and migrating assets held on Polygon in preparation for funding future incentive campaigns. The below outlines the three objectives of this publication:

- Consolidating funds to Ethereum;
- Fulfilling near term operation requirements; and,

### Bridge Funds to Ethereum

Each month the DAO’s funds held on Polygon are to be bridged to Ethereum where they will be used to support various incentive and buyback programs. With the pending Umbrella, Horizon and AAVE buybacks to start in the near future, consolidating assets on Ethereum ensures sufficient capital is readily available if required.

### Acquire GHO

In the near term we expect several initiatives to request funding from the DAO. This proposal when implemented will acquire sufficient GHO to sustain the DAO until the Finance Steward is deployed ensuring the DAO is well capitalised at all times.

Examples of near term expenses include:

- Service Provider renewal;
- Merit and ALC; and,
- Incentive campaign(s).

## Specification

This proposal shall be submitted as several AIPs that align with operational readiness timelines and ease of review given the volume of funds being moved.

### Polygon - Bridge Assets to Ethereum

Bridge the following assets to Ethereum.

| Polygon |
| :-----: |
| USDC.e  |
|  USDT   |
|  WETH   |
|   DAI   |

### Ethereum - Acquire GHO

Swap to GHO and deposit into Aave v3 Prime instance.

| Ethereum v2 | Amount |
| :---------: | :----: |
|    aUSDT    | 2.00M  |
|    aUSDC    | 2.00M  |

This GHO will provide sufficient runway to cover the next few months of Merit and Service Provider expenses being paid from Aave v3 Prime instance.

### Ethereum - Aave Protocol Embassy & Sonic Incentives

Transfer FLUID held in the Treasury to Aave Protocol Embassy SAFE on Ethereum:

SAFE: `0xa9e777D56C0Ad861f6a03967E080e767ad8D39b6`

Create an Allowance to fund Sonic Incentive Campaign, 0.8M aEthUSDC, from Aave v3 Core instance to Merit address:

SAFE: `0xdeadD8aB03075b7FBA81864202a2f59EE25B312b`

### Fund to [CrossChainController](https://etherscan.io/address/0xEd42a7D8559a463722Ca4beD50E0Cc05a386b0e1)

Funding to [CrossChainController](https://etherscan.io/address/0xEd42a7D8559a463722Ca4beD50E0Cc05a386b0e1) on mainnet with 50 LINK and 1 native ETH

### Update stataUSDT GSM Exposure Cap

Set the stataUSDT GSM exposure cap to 25M units.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/a80115e1f957060534c1a4237eb0c50b42279ce6/src/20250328_Multi_AprilFundingUpdate/AaveV3Ethereum_AprilFundingUpdate_20250328.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/a80115e1f957060534c1a4237eb0c50b42279ce6/src/20250328_Multi_AprilFundingUpdate/AaveV3Polygon_AprilFundingUpdate_20250328.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/a80115e1f957060534c1a4237eb0c50b42279ce6/src/20250328_Multi_AprilFundingUpdate/AaveV3Ethereum_AprilFundingUpdate_20250328.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/a80115e1f957060534c1a4237eb0c50b42279ce6/src/20250328_Multi_AprilFundingUpdate/AaveV3Polygon_AprilFundingUpdate_20250328.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-april-funding-update/21590)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
