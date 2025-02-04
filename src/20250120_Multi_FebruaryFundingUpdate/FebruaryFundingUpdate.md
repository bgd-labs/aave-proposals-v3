---
title: "February Funding Update (Part 1)"
author: "@TokenLogic"
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

### Transfer FLUID

Transfer an initial 25% of the 1/3 FLUID holdings assigned to support GHO's growth and adoption on Fluid.

Specifically, Transfer 95,417 $FLUID to Merit SAFE `0xdeadD8aB03075b7FBA81864202a2f59EE25B312b`

Reference this prior [proposal](https://governance.aave.com/t/arfc-fluid-alignment-with-inst-purchase/19921) for more information.

### Gas Reimbursement and EURA Bad Debt Clearing Reimbursement

Transfer 26,500 USDC, 3.404 ETH and 149 PYUSD to ACI to reimburse expenses incurred.

This reimburses associated expenses with clearing EURA bad debt, gas costs linked to AIP submissions and administering the PYUSD rewards program respectively.

ACI Receiving Address: `0xac140648435d03f784879cd789130F22Ef588Fcd`

### Migrate funds from Aave v2 to v3

Migrate the following assets from Aave v2 to v3 on the respective network.

Where it says All-1, it refers to all available liquidity minus 1 unit as to not drain the pool where possible. In other pools, it will be as much as is available to withdraw.

|   Ethereum    |    Avalanche    |     Polygon     |
| :-----------: | :-------------: | :-------------: |
| aWETH (All-1) | avWETH (All-1)  | amWMATIC (All-1)|
| aWBTC (All-1) |  avDAI (All-1)  | amUSDT (All-1)  |
| aLINK (All-1) | avWAVAX (All-1) |                 |
| aMKR (All-1)  |                 |                 |
| aUSDC (1.5M)  |                 |                 |
| aUSDT (2.0M)  |                 |                 |

Funds are to be deposited into the Core deployment on Ethereum and Aave v3 on the respective networks.

Note: Not all USDC and USDT on v2 Ethereum can be migrated due to high utilisation. This publication proposes a partial migration of 1.5M and 2.0M respectively.

### Deposit Passively Held Assets into Aave

Deposit the following assets into their respective V3 Pools.

| Ethereum v3 (Core) | Optimism v3 | Avalanche v3 | Polygon v3 |
| :----------------: | :---------: | :----------: | :--------: |
|        USDC        |    USDC     |     USDC     |   wMATIC   |
|        USDT        |    wETH     |     USDT     |    wBTC    |
|                    |    USDT     |    wAVAX     |    USDT    |
|                    |             |    wETH.e    |    LINK    |
|                    |             |    BTC.d     |            |

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

### Transfer Assets to Aave Liquidity Committee (ALC)

Withdraw and transfer the following assets to the ALC.

|    Ethereum     |
| :-------------: |
|    BAL (All)    |
|  aBAL (All-1)   |
| aEthBAL (All-1) |
|    CRV (All)    |
|  aCRV (All-1)   |
| aEthCRV (All-1) |

ALC SAFE: `0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b`

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250120_Multi_FebruaryFundingUpdate/AaveV3Ethereum_FebruaryFundingUpdate_20250120.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250120_Multi_FebruaryFundingUpdate/AaveV3Polygon_FebruaryFundingUpdate_20250120.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250120_Multi_FebruaryFundingUpdate/AaveV3Optimism_FebruaryFundingUpdate_20250120.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250120_Multi_FebruaryFundingUpdate/AaveV3Avalanche_FebruaryFundingUpdate_20250120.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250120_Multi_FebruaryFundingUpdate/AaveV3Ethereum_FebruaryFundingUpdate_20250120.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250120_Multi_FebruaryFundingUpdate/AaveV3Polygon_FebruaryFundingUpdate_20250120.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250120_Multi_FebruaryFundingUpdate/AaveV3Optimism_FebruaryFundingUpdate_20250120.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250120_Multi_FebruaryFundingUpdate/AaveV3Avalanche_FebruaryFundingUpdate_20250120.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-february-funding-update/20712)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
