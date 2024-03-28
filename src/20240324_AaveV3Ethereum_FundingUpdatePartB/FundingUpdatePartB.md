---
title: "Funding Update (Part B)"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-funding-update/16675/4"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x4dd4dff7096bf7ab8c4c071975d40f4cf709c41b4b6b7c60777a6dd50d2ecd09"
---

## Simple Summary

This publication mainly proposes consolidating DAO assets in preparation of foreseeable DAO expenses. It is a continuation of governance proposal 44 which was executed in early March of 2024.

## Motivation

This proposal combined with the previously executed one aim to:

- Consolidate the DAOs smaller holdings to GHO
- Swap larger stablecoins holdings for GHO
- Replenish the stablecoins Reserves in Aave v3
- Migrate funds from Aave v2 to v3
- Transfer BAL and CRV to the ALC SAFE

## Specification

- Transer all available BAL in the collector to the ALC [SAFE](https://etherscan.io/address/0x205e795336610f5131Be52F09218AF19f0f3eC60)
- Transer all available CRV in the collector to the ALC [SAFE](https://etherscan.io/address/0x205e795336610f5131Be52F09218AF19f0f3eC60)
- Deposit all existing ETH in the collector into WETH, and deposit into Aave V3 Ethereum
- Deposit all DAI in the collector into Aave V3 Ethereum
- Withdraw 640,000 USDC aToken from Aave V2 Ethereum
- Swap withdrawn 640,000 USDC into GHO
- Swap all available DPI in the collector into GHO (previously a failed swap because of slippage)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_AaveV3Ethereum_FundingUpdatePartB/AaveV3Ethereum_FundingUpdatePartB_20240324.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_AaveV3Ethereum_FundingUpdatePartB/AaveV3Ethereum_FundingUpdatePartB_20240324.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x4dd4dff7096bf7ab8c4c071975d40f4cf709c41b4b6b7c60777a6dd50d2ecd09)
- [Discussion](https://governance.aave.com/t/arfc-funding-update/16675/4)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
