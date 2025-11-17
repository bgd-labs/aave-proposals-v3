---
title: "November Funding Update"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-november-2025-funding-update/23339"
---

## Simple Summary

This publication presents the November Funding Update, consisting of the following key activities:

- Bridge funds to Ethereum;
- Acquire GHO to support runway;
- Consolidate asset holdings; and,
- Create Allowances to support Operations.

## Motivation

This publication balances near-term operational needs, consolidates asset holdings and extends some Allowances to the MainnetSwapSteward to support optimising the DAO's stablecoin holdings.

Fund Ongoing Initiatives
As with every funding update, our goal is to ensure that all ongoing initiatives and service provider streams remain adequately funded. Since most activities have now transitioned to GHO, specifically aEthLidoGHO, this update focuses on maintaining sufficient liquidity within the Prime instance.

To meet upcoming funding requirements, we plan to repurchase 8 million GHO from the market over the next month and deposit it into the Prime instance. This allocation will support existing streams, including ACI, TokenLogic, ALC, Chaos Labs, and LlamaRisk, as well as the upcoming renewal of Certora and BGD contracts, the continuation of the Merit initiative, and the payment for Aave v4 audits.

Bridge Assets to Ethereum
For this cycle, funds held across several networks will be bridged back to Ethereum to continue supporting the DAO’s operational needs. Some assets will be swapped on the respective network prior to being bridged by the AFC, such as sUSD on Optimism. Once received on Ethereum, all assets will be deposited into the Aave Protocol to generate yield and ensure efficient treasury management.

## Specification

#### Bridge Assets to Ethereum

Transfer the following assets to Ethereum via AIP using the bridge adapter contracts.

| Polygon |
| ------- |
| DAI     |
| USDC.e  |
| WBTC    |
| WETH    |
| AAVE    |

#### Approvals

_Polygon_

Amount: 130,000 USDCn
Amount: 230,000 USDT
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`
Method: `approve()` above assets on the Aave Collector contract to the AFC address

_Binance_

Amount: 123,000 USDC
Amount: 323,000 USDT
Amount: 27 ETH
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`
Method: `approve()` above assets on the Aave Collector contract to the AFC address

_Sonic_

Amount: 12 WETH
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`
Method: `approve()` above assets on the Aave Collector contract to the AFC address

_Optimism_
To be swapped to USDC, bridged from Optimism to Ethereum and sent to the treasury.

Amount: 55,000 sUSD
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`
Method: `approve()` above assets on the Aave Collector contract to the AFC address)

To be bridged manually as it cannot be bridged programmatically.

Amount: 195 ETH
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`
Method: `approve()` above assets on the Aave Collector contract to the AFC address)

#### Fund Ongoing Initiatives

_Runway_

Amount: 200k SYND
Amount: All SPK
Amount: All SAFE
Amount: All POL
Spender: AFC SAFE `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

_Aave v4 Security Audits_

Asset: aEthLidoGHO
Amount: 1.5M
Spender: v4 Audits `0xAAf400e4Bbc38B5E2136C1a36946Bf841A357307`
Method: `approve()` aEthLidoGHO on the Aave Collector contract to the Aave v4 Audits address

_Reimbursements_

Asset: aEthLidoGHO
Amount: 71,698
Spender: TokenLogic `0xAA088dfF3dcF619664094945028d44E779F19894`
Method: `approve()` aEthLidoGHO on the Aave Collector contract to the TokenLogic address.

_Ecosystem Reserve_

Send all AAVE on the collector to the Ecosystem Reserve.

_Swaps_

Approve stablecoins to be swapped to `pyUSD` and `rlUSD`.
Increase USDC token budget by 2.0M.
Increase DAI token budget BY 1.0M.

#### Emissions

Increase allowance of stkAAVE and stkBPT for 14 days of emissions between end and restart as per mentioned [here](https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640/37)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251110_Multi_NovemberFundingUpdate/AaveV3Ethereum_NovemberFundingUpdate_20251110.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251110_Multi_NovemberFundingUpdate/AaveV3Polygon_NovemberFundingUpdate_20251110.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251110_Multi_NovemberFundingUpdate/AaveV3Optimism_NovemberFundingUpdate_20251110.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251110_Multi_NovemberFundingUpdate/AaveV3BNB_NovemberFundingUpdate_20251110.sol), [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251110_Multi_NovemberFundingUpdate/AaveV3Sonic_NovemberFundingUpdate_20251110.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251110_Multi_NovemberFundingUpdate/AaveV3Ethereum_NovemberFundingUpdate_20251110.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251110_Multi_NovemberFundingUpdate/AaveV3Polygon_NovemberFundingUpdate_20251110.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251110_Multi_NovemberFundingUpdate/AaveV3Optimism_NovemberFundingUpdate_20251110.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251110_Multi_NovemberFundingUpdate/AaveV3BNB_NovemberFundingUpdate_20251110.t.sol), [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251110_Multi_NovemberFundingUpdate/AaveV3Sonic_NovemberFundingUpdate_20251110.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-november-2025-funding-update/23339)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
