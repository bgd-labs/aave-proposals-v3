---
title: "September Funding Update"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-september-2025-funding-update/22915"
---

## Simple Summary

This publication presents the September Funding Update, consisting of the following key activities:

Bridge funds to Ethereum;
Create 2M USD Allowance for AAVE buybacks;
Consolidate asset holdings; and,
Create Allowances to support Operations.

## Motivation

This publication balances near term operational needs and consolidates assets holdings, whilst ensuring various incentives programs are adequately funded.

### Ethereum

With @bgdlabs upgrading the GHO reserve on the Core instance, GHO’s revenue is now received more frequently instead of when users repaid debt. As a result, accrued fees were realised resulting in 2,965,399.19 aEthGHO being received by the Treasury.

The Aave DAO is able to fund the next Merit Allowance from existing GHO holdings and therefore, within this proposal does not need to acquire any GHO from secondary markets. Merit is $275k per week at 14.3M GHO per year. A new Allowance is to be created ensuring the ACI team has sufficient funding to continue distributing rewards to sGHO holders.

As part on routine operations, certain asset holdings are to be converted to USDC. In this months update, several smaller holdings are to be exchanged for USDC and deposited into Aave.

The CRV held within the Treasury are to be sent to the ALC safe and converted to sdCRV.

### Optimism

For Optimism, where lower deposit yield is available relative to Avalanche, funds are to be bridged back to Ethereum to support the DAO’s operations. sUSD will be exchanged for USDCn and bridged back to Ethereum via the AFC whilst other assets will be bridged directly via the AIP implementation. All assets are then deposited into Aave Protocol on Ethereum to earn yield.

The OP rewards (1,185.24 OP) accrued by the DAO are to be claimed with an Allowance created to enable the AFC to receive all OP tokens which are then to be swapped to USDC and transferred to Base in support of the ongoing incentive campaign.

### Polygon

Similar to previous months, assets are to be bridged to Ethereum to support the broader business. The image below shows the DAO’s asset holdings on Polygon. For assets that are not able to pass via the canonical
bridge, such as USDCn, the AFC will support bridging the asset(s) to Ethereum where they are to be deposited into Aave v3.

### Arbitrum

In support of the Aave Protocol Embassy (APE), the ARB currently held in the Treasury is to be transferred to the APE Safe where it will be used to participate in the governance of the Arbitrum ecosystem.

## Specification

### Arbitrum - Aave Protocol Embassy

Create an Allowance to transfers ARB from the Treasury on Arbitrum to the Aave Protocol Embassy SAFE to enable participation in Arbitrum’s governance.

Amount: 234,000 ARB

Spender: APE `0xAA43203167317DeeF8288095C44b84a686918d2E`

Method: `approve()` ARB on the Aave Collector contract to the APE SAFE address

### Ethereum

##### Aave Buybacks

Create a 2M aEthUSDT and 2M aEthUSDC allowance for the Aave Finance Committee to support the AAVE Buybacks program.

Asset: aEthUSDT `0x23878914EFE38d27C4D67Ab83ed1b93A74D4086a`

Amount: 2M

Asset: aEthUSDC `0x98C23E9d8f34FEFb1B7BD6a91B7FF122F4e16F5c`

Amount: 2M

Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

Method: approve() aEthUSDT and aEthUSDC on the Aave Collector contract to the AFC address

###### Aave Liquidity Committee

Asset: aEthCRV `0x7B95Ec873268a6BFC6427e7a28e396Db9D0ebc65`

Amount: 30,000

Spender: ALC `0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b`

Method: approve() aEthCRV on the Aave Collector contract to the ALC address

###### Merit Program

Create allowance for Merit, 3M aEthLidoGHO from Aave v3 Prime on Ethereum:

Asset: aEthLidoGHO: `0x18eFE565A5373f430e2F809b97De30335B3ad96A`

Amount: 3M

Spender: Merit `0xdeadD8aB03075b7FBA81864202a2f59EE25B312b`

Method: approve() aEthLidoGHO on the Aave Collector contract to the Merit address

###### Swaps

| Asset  | Amount | To   |
| ------ | ------ | ---- |
| crvUSD | All    | USDC |

Retrieve POL migrated to MATIC.
Deposit raw ETH into wETH to earn yield by later depositing into aEthWETH.

###### Reimbursements

Asset: aEthWETH `0x4d5F47FA6A74757f35C14fD3a6Ef8E3C9BC514E8`

Amount: 0.2415

Spender: ACI `0xac140648435d03f784879cd789130F22Ef588Fcd`

Method: transfer() aEthWETH on the Aave Collector contract to the ACI address.

This reimburses legal opinion costs incurred in supporting GHO’s first CEX listing.

Asset: aEthLidoGHO `0x18eFE565A5373f430e2F809b97De30335B3ad96A`

Amount: 9,000

Spender: TokenLogic `0xAA088dfF3dcF619664094945028d44E779F19894`

Method: transfer() aEthLidoGHO on the Aave Collector contract to the TokenLogic address.

#### Gnosis - Liquidity Mining Rewards

Asset: aGnoEURe: `0xEdBC7449a9b594CA4E053D9737EC5Dc4CbCcBfb2`

Amount: 15,000

Spender: MASIV SAFE `0xdef1FA4CEfe67365ba046a7C630D6B885298E210`

Method: approve() aGnoEURe on the Aave Collector contract to the ACI address

#### Optimism

Create an Allowance for the AFC to receive the sUSD and USDCn from the Collector Contract.

Amount: All USDCn, sUSD

Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

Method: approve() above assets on the Aave Collector contract to the AFC address

The AFC is to swap sUSD to USDC and bridge USDCn via CCTP to Ethereum where it will be deposited into the Core instance.

Claim outstanding OP rewards and create an Allowance for the AFC to receive OP from the Collector Contract.

Amount: All OP

Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

Method: approve() above assets on the Aave Collector contract to the AFC address

The AFC is to exchange the OP for USDC to be used in support of the ongoing Base incentive campaign.

Bridge all the balance of the following assets:

USDT
USDC.e
wBTC

#### Polygon

To support bridging the USDC.n, an Allowance will be created enabling the USDCn to be bridged by the AFC from Polygon to Ethereum using Circles CCTP bridge.

Amount: 557,125 USDCn

Spender: AFC `0x22740deBa78d5a0c24C58C740e3715ec29de1bFa`

Method: `approve()` above assets on the Aave Collector contract to the AFC address

Bridge all the balance of the following assets:

DAI
USDC.e
wBTC

#### Sonic - Liquidity Mining Rewards

Asset: aSonwS `0x6C5E14A212c1C3e4Baf6f871ac9B1a969918c131`

Amount: 300,000

Spender: MASiv nested safe `0x565B80842eCEDad88A2564Ea375CE875Ed3bAdeC`

Method: approve() aSonwS on the Aave Collector contract to the Masiv address.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/ab580518907b247ee8ee08f872f5a9cb6cebb28d/src/20250826_Multi_SeptemberFundingUpdate/AaveV3Ethereum_SeptemberFundingUpdate_20250826.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/ab580518907b247ee8ee08f872f5a9cb6cebb28d/src/20250826_Multi_SeptemberFundingUpdate/AaveV3Polygon_SeptemberFundingUpdate_20250826.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/ab580518907b247ee8ee08f872f5a9cb6cebb28d/src/20250826_Multi_SeptemberFundingUpdate/AaveV3Avalanche_SeptemberFundingUpdate_20250826.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/ab580518907b247ee8ee08f872f5a9cb6cebb28d/src/20250826_Multi_SeptemberFundingUpdate/AaveV3Optimism_SeptemberFundingUpdate_20250826.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/ab580518907b247ee8ee08f872f5a9cb6cebb28d/src/20250826_Multi_SeptemberFundingUpdate/AaveV3Arbitrum_SeptemberFundingUpdate_20250826.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/ab580518907b247ee8ee08f872f5a9cb6cebb28d/src/20250826_Multi_SeptemberFundingUpdate/AaveV3Gnosis_SeptemberFundingUpdate_20250826.sol), [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/ab580518907b247ee8ee08f872f5a9cb6cebb28d/src/20250826_Multi_SeptemberFundingUpdate/AaveV3Sonic_SeptemberFundingUpdate_20250826.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/ab580518907b247ee8ee08f872f5a9cb6cebb28d/src/20250826_Multi_SeptemberFundingUpdate/AaveV3Ethereum_SeptemberFundingUpdate_20250826.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/ab580518907b247ee8ee08f872f5a9cb6cebb28d/src/20250826_Multi_SeptemberFundingUpdate/AaveV3Polygon_SeptemberFundingUpdate_20250826.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/ab580518907b247ee8ee08f872f5a9cb6cebb28d/src/20250826_Multi_SeptemberFundingUpdate/AaveV3Avalanche_SeptemberFundingUpdate_20250826.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/ab580518907b247ee8ee08f872f5a9cb6cebb28d/src/20250826_Multi_SeptemberFundingUpdate/AaveV3Optimism_SeptemberFundingUpdate_20250826.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/ab580518907b247ee8ee08f872f5a9cb6cebb28d/src/20250826_Multi_SeptemberFundingUpdate/AaveV3Arbitrum_SeptemberFundingUpdate_20250826.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/ab580518907b247ee8ee08f872f5a9cb6cebb28d/src/20250826_Multi_SeptemberFundingUpdate/AaveV3Gnosis_SeptemberFundingUpdate_20250826.t.sol), [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/ab580518907b247ee8ee08f872f5a9cb6cebb28d/src/20250826_Multi_SeptemberFundingUpdate/AaveV3Sonic_SeptemberFundingUpdate_20250826.t.sol)
- [Snapshot] Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-september-2025-funding-update/22915)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
