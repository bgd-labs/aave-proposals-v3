---
title: "February Funding Update - Part B"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-february-funding-update/20712"
---

## Simple Summary

This publication presents the February funding update, which consists of performing the following key activities:

- Funding FLUID incentive campaign;
- Migrating funds from Aave Protocol v2 to v3;
- Transferring BAL & CRV to ALC;
- Acquiring GHO for Merit Phase V;
- Reimbursing EURA Bad Debt Expense; and,
- Reimbursing Gas & Merkl deployment Costs.

## Motivation

As part of our ongoing Treasury asset rebalancing strategy, this proposal when implemented will continue to:

- Fund upcoming GHO incentive campaigns with FLUID;
  - Follow up action to this proposal;
- Fund Merit Phase V;
  - Swap USDC and USDT to GHO;
- Reimburse ACI of costs incurred from;
  - Repaying EURA bad debt;
  - Administering the PYUSD incentives;
  - Gas costs related to AIP submissions;
- Deposit passively held assets into Aave v3;
  - Optimising capital efficiency;
- Migrating assets from Aave v2 to v3;
  - Ensuring improved capital efficiency and enhanced risk management;

Additionally, to further consolidate and mitigate risk, certain assets will be reallocated to the Core market from various Layer 2 instances. This adjustment aims to progressively consolidate liquidity into the latest instance of Aave, where it can continue to generate returns.

To promote capital efficiency, some passive assets held idle are to be deployed into Aave to earn yield.

Several smaller asset holdings are be converted to aEthETH to reduce the DAO’s exposure to thinly traded long tail assets (or products being sunset) to ensure a more resilient treasury structure.

Finally, as part of the revamping of SKY, certain DAI-correlated assets will be swapped into aEthUSDS.

## Specification

### Bridge Assets to Ethereum Mainnet

Withdraw from respective Aave Protocol and bridge the following assets to Ethereum mainnet.

| Polygon v2 & Passive |     Polygon v3      |   Arbitrum v3    |   Optimism v3    |
| :------------------: | :-----------------: | :--------------: | :--------------: |
|   amUSDC.e (All-1)   |   aPolDAI (All-1)   | aArbLUSD (All-1) |   USDC.e (All)   |
|    amBAL (All-1)     |  aPolWETH (All-1)   | aArbUSDC (All-1) | aOptLUSD (All-1) |
|      BAL (All)       |   aPolBAL (All-1)   |                  | aOptUSDC (All-1) |
|     USDC.e (All)     | aPolUSDC.e (All-1)  |                  |                  |
|      AAVE (All)      |  aPolAAVE (All-1)   |                  |                  |
|    amWETH (All-1)    | aPolstMATIC (All-1) |                  |                  |
|    amDAI (All-1)     |   aPolDPI (All-1)   |                  |                  |
|      wETH (All)      | aPolwstETH (All-1)  |                  |                  |
|      CRV (All)       |   aPolCRV (All-1)   |                  |                  |

Upon being received on Ethereum:

DAI swapped to USDS, deposited into Core instance;
wstETH deposited into Prime instance;
DPI swapped to ETH, deposited into Core instance;
ETH deposited into Core instance;
AAVE transfer to Economic Reserve;
BAL and CRV assets are to be transferred to the ALC; and,
LUSD and FRAX swapped to ETH, deposited into Core instance.
ALC SAFE: `0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b`

The remaining assets where applicable will be deposited into the Core instance.

### Acquire ETH and deposit into Aave v3 (Core)

Withdraw and swap the following assets to ETH. ETH to be deposited into Aave in a follow up proposal.

|     Ethereum     |
| :--------------: |
| aEthLUSD (All-1) |
|   aDPI (All-1)   |

### Acquire GHO and deposit into Aave v3 (Prime)

Both withdrawn above from Aave V2 Ethereum. GHO to be deposited into Aave in a follow up proposal.

|   Ethereum   |
| :----------: |
| USDT (1.50M) |
| USDC (1.50M) |

### Acquire USDS and deposit into Aave V3 (Core)

Withdraw and swap the following assets to USDS. USDS to be deposited into Aave in a follow up proposal.

|    Ethereum     |
| :-------------: |
|    DAI (All)    |
|  aDAI (All-1)   |
| aEthDAI (All-1) |

USDS deposits on Core benefit from USDS liquidity mining and SPK airdrop rewards.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Ethereum_FebruaryFundingUpdatePartB_20250207.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Polygon_FebruaryFundingUpdatePartB_20250207.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Optimism_FebruaryFundingUpdatePartB_20250207.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Arbitrum_FebruaryFundingUpdatePartB_20250207.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Ethereum_FebruaryFundingUpdatePartB_20250207.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Polygon_FebruaryFundingUpdatePartB_20250207.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Optimism_FebruaryFundingUpdatePartB_20250207.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Arbitrum_FebruaryFundingUpdatePartB_20250207.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-february-funding-update/20712)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
