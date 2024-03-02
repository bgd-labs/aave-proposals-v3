---
title: "Funding Update"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-funding-update/16675"
---

## Simple Summary

This publication mainly proposes consolidating DAO assets in preparation of foreseeable DAO expenses. There are additional small treasury management actions included in this proposal for house-keeping.

## Motivation

In preparation for the upcoming launch of the Merit program and the expected renewal of DAO service providers, this proposal intends to:

- Consolidate the DAOs smaller holdings to GHO
- Swap larger stablecoins holdings for GHO
- Replenish the stablecoins Reserves in Aave v3
- Migrate funds from Aave v2 to v3
- Bridge funds from Polygon to Mainnet

To reduce governance burden, this proposal also includes withdrawing BAL and CRV from mainnet Aave v3 and v2, as well as withdrawing and bridging them from Polygon Aave v3 to Ethereum. All the BAL and CRV included in this proposal will then be transferred to the Aave Liquidity Committee (ALC) for its future allocation on behalf of the DAO.

In addition to the above, this proposal seeks to enable @karpatkey_TokenLogic to submit proposals via the Direct-to-AIP process which include actions similar to the above:

- Consolidate treasury holdings to GHO
- Migrate funds from v2 to v3 deployments
- Move funds from Polygon to Ethereum

## Specification

This is Part 1 of the specified proposal and it will do as follows:

| Withdraw & Swap to GHO | Migrate ETH v2 to v3 | Polygon to ETH   |
| ---------------------- | -------------------- | ---------------- |
| aEthLUSD (All-1)\*     | awBTC (All-1)        | aPolwETH (All-1) |
| aEthUSDC (1.25M)       | awETH (All-1)        | aPolDAI (All-1)  |
| aEthUSDT (1.2M) \*     | aUSDC (300k)         | aPolBAL (All-1)  |
| LUSD (All)             |                      | aPolCRV (All-1)  |
| aLUSD (All-1)          |                      |                  |
| aBUSD (50k)            |                      |                  |
| aTUSD (All-1)          |                      |                  |
| aAMPL (All-1)\*        |                      |                  |
| aUSDT (200k)           |                      |                  |
| aDAI (All-1)           |                      |                  |
| aDPI (All-1)           |                      |                  |
| aFRAX (All-1)          |                      |                  |

_Note_

The forum post specified withdrawing 1.5M from Aave V3 USDT, but it cannot be done at the moment so we are withdrawing 1.2M instead.
The forum post also asks to withdraw from Aave V3 LUSD but that pool is currently paused.
The forum post also asks to withdraw all from Aave V2 AMPL, but the pool has no AMPL available.

Withdraw aCRV, aEthCRV, aBAL and aEthBAL and transfer BAL and CRV to ALC SAFE.

Enable @karpatkey_Tokenlogic so submit funding proposals consisting of the following via the Direct-to-AIP process:

1. Consolidate the treasury to GHO
2. Migrate funds from v2 to v3 on respective networks
3. Move funds from Polygon to Ethereum

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240224_Multi_FundingUpdate/AaveV3Ethereum_FundingUpdate_20240224.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240224_Multi_FundingUpdate/AaveV3Polygon_FundingUpdate_20240224.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240224_Multi_FundingUpdate/AaveV3Ethereum_FundingUpdate_20240224.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240224_Multi_FundingUpdate/AaveV3Polygon_FundingUpdate_20240224.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x4dd4dff7096bf7ab8c4c071975d40f4cf709c41b4b6b7c60777a6dd50d2ecd09)
- [Discussion](https://governance.aave.com/t/arfc-funding-update/16675)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
