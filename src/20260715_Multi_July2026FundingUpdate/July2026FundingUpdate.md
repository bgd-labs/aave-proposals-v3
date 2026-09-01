---
title: "July 2026 Funding Update"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-july-2026-funding-update/25277"
---

## Simple Summary

This publication presents the July Funding Update, consisting of the following key activities:

- Acquire GHO to support the runway; and
- Create Allowances to support Operations.
- Increase Swap Steward allowances
- Pay back audit costs

## Motivation

This publication addresses near-term operational requirements, consolidates asset holdings, and refreshes the MainnetSwapSteward’s Allowances to support operations and future growth opportunities.

The MainnetSwapSteward and Aave Finance Committee (AFC) will continue executing a rolling GHO acquisition strategy to maintain adequate runway and preserve sufficient budget to fund ongoing growth initiatives.

### Reimburse Audit Costs

Reimburse TokenLogic for costs incurred in facilitating the audit of one Chainlink PR that was modified to accommodate the GHO ↔ sGHO two-way swap layer. The value of the Audit performed by Trail of Bits was 50,000 aEthLidoGHO.

## Specification

### Ethereum

#### Runway

Deposit idle ETH on the Collector into the Aave v3 Core instance on Arbitrum, Base and Ethereum.

Use the MainnetSwapSteward to acquire 8M GHO for deposit into the Prime instance.

#### Refresh MainnetSwapSteward Allowances

To support the acquisition of GHO, wETH and AAVE, add missing token swap paths.

| Token | Acquirable Assets |
| ----- | ----------------- |
| ETH   | GHO, AAVE         |
| USDC  | GHO, AAVE, wETH   |
| USDT  | GHO, AAVE, wETH   |
| USDe  | GHO, AAVE, wETH   |
| USDS  | GHO, AAVE, wETH   |
| DAI   | GHO, AAVE, wETH   |
| rlUSD | GHO, AAVE, wETH   |
| pyUSD | GHO, AAVE, wETH   |

Where the path is not configured (i.e., pyUSD → GHO), we’ll add this path as a swappable pair with its respective oracle.
Additionally, increase the pyUSD token budget by 500,000 units.

#### Monad Incentives

To support the launch of GHO on Monad, this publication grants the AFC permission to use GHO and USDC to provide liquidity on DEXs. For the avoidance of doubt, the AFC may use collateral and debt to fund DEX liquidity.

Following through on the Deploy Aave Protocol v3.7 on Monad proposal, create the following Allowance to support the growth and adoption of GHO on the Monad Network.

Asset: aEthLidoGHO `0x18eFE565A5373f430e2F809b97De30335B3ad96A`
Amount: 0.5M
Spender: ALC `0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b`

Method: `approve()` aEthLidoGHO on the Aave Collector contract to the Aave Liquidity Committee (ALC) address.

Note: The destination address of the Allowance has been changed from the Aave Finance Committee to the Aave Liquidity Committee.

#### GHO:USDC DEX Liquidity

To support the launch of GHO on Monad, this publication includes an Allowance to deploy GHO DEX Liquidity on the Monad Network using the Uniswap Protocol.

Network: Ethereum
Asset: aEthWBTC `0x5Ee5bf7ae06D1Be5997A1A72006FE6C607eC6DE8`
Amount: 72
Spender: Ahab `0xAA2461f0f0A3dE5fEAF3273eAe16DEF861cf594e`

Note: This aEthWBTC and other assets held on the Ahab are to be used as Collateral to facilitate providing liquidity on the Monad Network.

#### Hedging

With the treasury holding a large AAVE position and having recently donated to the DeFi United cause, this proposal grants the AFC the ability to participate in the AAVE, ETH and BTC derivative markets to earn yield and/or manage asset exposure throughout the market cycle.

Hedging strategies are to be implemented via the CEX Earn Safe, with the administration performed by TokenLogic and Aave Labs.

### Plasma

Add the following Allowances to facilitate the removal of small balances and the conversion of assets to USDT0.

Asset: aPlaPT_sUSDE_9APR2026 `0x53349cBeD7A3F851f0722Bf3Fa8f1b93fA939BeF`
Asset: aPlaPT_USDe_15JAN2026 `0xEa601A9FECF80bFC529F08A51bD8Cb0d72fc862A`
Asset: aPlaPT_sUSDE_18JUN2026 `0x68ab954Dc705c66506d499963dD1fbB8aFa23d7d`
Asset: aPlaPT_sUSDE_15JAN2026 `0x0b9A412c94f07223752031f75a20DDe542D63d5C`
Asset: aPlaPT_USDe_9APR2026 `0x9326fA5a71C93D5De313c91C3b80D74d0c3a0F5A`
Asset: aPlaPT_USDe_18JUN2026 `0xDEdFF537fCBa1169E673F78EE23D109885741016`
Asset: aPlaWETH `0xf1aB7f60128924d69f6d7dE25A20eF70bBd43d07`
Asset: aPlaweETH `0xAf1a7a488c8348b41d5860C04162af7d3D38A996`
Asset: aPlasUSDe `0xC1A318493fF07a68fE438Cee60a7AD0d0DBa300E`
Amount: Balance at time of execution, plus a 0.10% buffer to cover interest accrued between execution and transfer
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

### Refresh the Following Allowances

Network: Plasma
Asset: aPlaUSDT0 `0x5D72a9d9A9510Cd8cBdBA12aC62593A58930a948`
Amount: 3M
Spender: Ahab `0xAA2461f0f0A3dE5fEAF3273eAe16DEF861cf594e`

Network: Arbitrum
Asset: aArbWETH `0xe50fA9b3c56FfB159cB0FCA61F5c9D750e8128c8`
Amount: 160
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

Network: Arbitrum
Asset: aArbUSDCn `0x724dc807b04555b71ed48a6896b6F41593b8C637`
Amount: 150,000
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

Network: Arbitrum
Asset: aArbUSDT `0x6ab707Aca953eDAeFBc4fD23bA73294241490620`
Amount: 50,000
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

Network: Arbitrum
Asset: aArbGHO `0xeBe517846d0F36eCEd99C735cbF6131e1fEB775D`
Amount: 55,000
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

### Cancel/Remove the Following Allowances

Network: Plasma
Asset: aPlaUSDT0 `0x5D72a9d9A9510Cd8cBdBA12aC62593A58930a948`
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

Network: Arbitrum
Asset: aArbweETH `0x8437d7C167dFB82ED4Cb79CD44B7a32A1dd95c77`
Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

Network: Sonic
Asset: aSonwS `0x6C5E14A212c1C3e4Baf6f871ac9B1a969918c131`
Spender: ACI Incentives `0x565B80842eCEDad88A2564Ea375CE875Ed3bAdeC`

Network: Ethereum
Asset: aEthUSDC `0x98C23E9d8f34FEFb1B7BD6a91B7FF122F4e16F5c`
Spender: Merit `0xdeadD8aB03075b7FBA81864202a2f59EE25B312b`

Network: Gnosis
Asset: aGnoEURe `0xEdBC7449a9b594CA4E053D9737EC5Dc4CbCcBfb2`
Spender: ACI MASiv SAFE `0xdef1FA4CEfe67365ba046a7C630D6B885298E210`

### Reimbursements

Reimburse 50,000 aEthLidoGHO to TokenLogic for GHO ↔ sGHO two-way swap layer audit expenses incurred.

Asset: aEthLidoGHO `0x18eFE565A5373f430e2F809b97De30335B3ad96A`
Amount: 50,000
Spender: TokenLogic `0xAA088dfF3dcF619664094945028d44E779F19894`

### Stable Vaults

Add the following allowances to a new dedicated Stable Vault incentives SAFE as discussed in the launch [proposal](https://governance.aave.com/t/arfc-aave-app-launch/25307). The Snapshot for it can be found [here](https://snapshot.box/#/s:aavedao.eth/proposal/0x2f86020fc038694a5c4738e3982e4fa92eb315aaa4d3ce2fa2be2a5808a9280b).

Network: Mainnet
Asset: aEthLidoGHO `0x18eFE565A5373f430e2F809b97De30335B3ad96A`
Amount: 300,000
Spender: Stable Vault Incentives `0x4cc755fBFAE135933b64865E7D7Ea6ae778A4D43`

Network: Mainnet
Asset: aEthUSDC `0x98C23E9d8f34FEFb1B7BD6a91B7FF122F4e16F5c`
Amount: 100,000
Spender: Stable Vault Incentives `0x4cc755fBFAE135933b64865E7D7Ea6ae778A4D43`

Network: Mainnet
Asset: aEthUSDT `0x23878914EFE38d27C4D67Ab83ed1b93A74D4086a`
Amount: 100,000
Spender: Stable Vault Incentives `0x4cc755fBFAE135933b64865E7D7Ea6ae778A4D43`

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/50d3b7b583e4a1f1a366e91dd6133f510a203852/src/20260715_Multi_July2026FundingUpdate/AaveV3Ethereum_July2026FundingUpdate_20260715.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/50d3b7b583e4a1f1a366e91dd6133f510a203852/src/20260715_Multi_July2026FundingUpdate/AaveV3Arbitrum_July2026FundingUpdate_20260715.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/50d3b7b583e4a1f1a366e91dd6133f510a203852/src/20260715_Multi_July2026FundingUpdate/AaveV3Base_July2026FundingUpdate_20260715.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/50d3b7b583e4a1f1a366e91dd6133f510a203852/src/20260715_Multi_July2026FundingUpdate/AaveV3Gnosis_July2026FundingUpdate_20260715.sol),[AaveV3Sonic](https://github.com/aave-dao/aave-proposals-v3/blob/50d3b7b583e4a1f1a366e91dd6133f510a203852/src/20260715_Multi_July2026FundingUpdate/AaveV3Sonic_July2026FundingUpdate_20260715.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/50d3b7b583e4a1f1a366e91dd6133f510a203852/src/20260715_Multi_July2026FundingUpdate/AaveV3Plasma_July2026FundingUpdate_20260715.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/50d3b7b583e4a1f1a366e91dd6133f510a203852/src/20260715_Multi_July2026FundingUpdate/AaveV3Ethereum_July2026FundingUpdate_20260715.t.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/50d3b7b583e4a1f1a366e91dd6133f510a203852/src/20260715_Multi_July2026FundingUpdate/AaveV3Arbitrum_July2026FundingUpdate_20260715.t.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/50d3b7b583e4a1f1a366e91dd6133f510a203852/src/20260715_Multi_July2026FundingUpdate/AaveV3Base_July2026FundingUpdate_20260715.t.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/50d3b7b583e4a1f1a366e91dd6133f510a203852/src/20260715_Multi_July2026FundingUpdate/AaveV3Gnosis_July2026FundingUpdate_20260715.t.sol),[AaveV3Sonic](https://github.com/aave-dao/aave-proposals-v3/blob/50d3b7b583e4a1f1a366e91dd6133f510a203852/src/20260715_Multi_July2026FundingUpdate/AaveV3Sonic_July2026FundingUpdate_20260715.t.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/50d3b7b583e4a1f1a366e91dd6133f510a203852/src/20260715_Multi_July2026FundingUpdate/AaveV3Plasma_July2026FundingUpdate_20260715.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-july-2026-funding-update/25277)
- Snapshot: Direct-to-AIP

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
