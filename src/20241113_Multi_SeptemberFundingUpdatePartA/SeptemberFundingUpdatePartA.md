---
title: "September Funding Update - Part A"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-september-funding-update/19162"
snapshot: "Direct-to-AIP"
---

## Simple Summary

This AIP will migrate funds from Aave v2 to v3 on Polygon, withdraw funds from Polygon, Arbitrum and Optimism to Ethereum, rescue Paraswap funds. This AIP also executes for reimbursing for the [funding of Guardian signers](https://governance.aave.com/t/arfc-renewal-of-aave-guardian-2024/17523/32), and create allowances to the Merit and Ahab.

## Motivation

As part of our ongoing Treasury asset rebalancing, this proposal when implemented will continue the migration of assets from v2 instances of Aave to v3. In response to recent events, funds currently locked in the Paraswap adapter contracts will be send to the DAOs Treasury. Due to size of these holding, this will only be performed on Polygon, Optimism, Ethereum and Arbitrum where this proposal is already intending updating the DAOs holdings.

## Specification

### Migrate the following assets from Aave v2 to v3 Polygon.

amUSDT (All-100x10^6)
amDAI (All-1.0x10^18)
amWMATIC (All-1.0x10^18)
amWETH (All-1.0x10^18)
amWBTC (All-1.0x10^8)
amLINK (All-1.0x10^18)

### Transfer the following assets to Ethereum.

| Polygon                 | Arbitrum                 | Optimism                 |
| ----------------------- | ------------------------ | ------------------------ |
| amUSDC.e (All-100x10^6) | aArbUSDC (All-100x10^6)  | aOptUSDC (All-100x10^6)  |
| aPolUSDC (All-100x10^6) | aArbLUSD (All-1.0x10^18) | aOptLUSD (All-1.0x10^18) |

### Rescue Paraswap Funds

Rescue funds held in the Paraswap adapter contracts and send back to Treasury in line with this [PR 454](https://github.com/bgd-labs/aave-proposals-v3/pull/454) on Ethereum.

### Gas Rebate

Transfer 0.264 ETH to 0x818C277dBE886b934e60aa047250A73529E26A99 (karpatkey) reimbursing for the [funding of Guardian signers](https://governance.aave.com/t/arfc-renewal-of-aave-guardian-2024/17523/32).

### Swap funds to GHO

|        Ethereum        |
| :--------------------: |
|     aUSDC (1.25M)      |
|     aUSDT (1.25M)      |
|       DAI (All)        |
| aDAI (All-1.0x10^-18)  |
|     aEthDAI (0.5M)     |
| aLUSD (All-1.0x10^-18) |
|       LUSD (All)       |
|       FRAX (All)       |
| aFRAX (All-1.0x10^-18) |

### Merit + Ahab Programs

Create allowances to the Merit and Ahab, 3M GHO and 800 aEthWETH from Aave v3 Ethereum:
SAFE: 0xdeadD8aB03075b7FBA81864202a2f59EE25B312b

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/1aab63b1461e28bcf74d70844654b968c4aab1b2/src/20241113_Multi_SeptemberFundingUpdatePartA/AaveV3Ethereum_SeptemberFundingUpdatePartA_20241113.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/1aab63b1461e28bcf74d70844654b968c4aab1b2/src/20241113_Multi_SeptemberFundingUpdatePartA/AaveV3Polygon_SeptemberFundingUpdatePartA_20241113.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/1aab63b1461e28bcf74d70844654b968c4aab1b2/src/20241113_Multi_SeptemberFundingUpdatePartA/AaveV3Optimism_SeptemberFundingUpdatePartA_20241113.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/1aab63b1461e28bcf74d70844654b968c4aab1b2/src/20241113_Multi_SeptemberFundingUpdatePartA/AaveV3Arbitrum_SeptemberFundingUpdatePartA_20241113.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/1aab63b1461e28bcf74d70844654b968c4aab1b2/src/20241113_Multi_SeptemberFundingUpdatePartA/AaveV3Ethereum_SeptemberFundingUpdatePartA_20241113.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/1aab63b1461e28bcf74d70844654b968c4aab1b2/src/20241113_Multi_SeptemberFundingUpdatePartA/AaveV3Polygon_SeptemberFundingUpdatePartA_20241113.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/1aab63b1461e28bcf74d70844654b968c4aab1b2/src/20241113_Multi_SeptemberFundingUpdatePartA/AaveV3Optimism_SeptemberFundingUpdatePartA_20241113.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/1aab63b1461e28bcf74d70844654b968c4aab1b2/src/20241113_Multi_SeptemberFundingUpdatePartA/AaveV3Arbitrum_SeptemberFundingUpdatePartA_20241113.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-september-funding-update/19162)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
