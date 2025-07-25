---
title: "July 2025 - Funding Update"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-july-2025-funding-update/22555"
---

## Simple Summary

This publication presents the July Funding Update, consisting of the following key activities:

- Bridge funds to Ethereum from Arbitrum and Polygon;
- Extend EURe incentive campaign and,
- Swap LUSD, PYUSD and DAI to USDC.
- Gas costs reimbursement to ACI.
- Orbit renewal program.
- Continue AAVE Buybacks for 4 weeks.

## Motivation

This publication combines near term operational needs and migrating assets held on L2s and side chains to Ethereum.

The below outlines the objectives of this publication:

- Consolidating funds to Ethereum; and,
- Support near term operational requirements.

### Orbit Renewal

Orbit recognizes the added value of the Delegates in the decentralization & diversity of the Aave DAO. This compensation allows them to focus on Aave and keep their contribution efforts to our governance. The ACI proposes the extension of Orbit for a new quarter, Q2 2025, from 2025-04-01 to 2025-06-30.

The snapshot for Orbit can be found [here](https://snapshot.box/#/s:aavedao.eth/proposal/0x2b497f613d426aa0f641fcd445132148b4faa81ad0c9c054e1062be886f45cdd).
The governance discussion can be found [here](https://governance.aave.com/t/arfc-orbit-program-renewal-q2-2025/22497/1).

## Specification

### Bridge the following assets to Ethereum.

| Network  | Token  | Amount |
| -------- | ------ | ------ |
| Polygon  | USDT   | All    |
| Polygon  | DAI    | All    |
| Polygon  | USDC.e | All    |
| Polygon  | LINK   | All    |
| Polygon  | wETH   | All    |
| Arbitrum | DAI    | All    |
| Arbitrum | USDC.e | All    |

### Swap the following assets as outlined in the table below on Mainnet:

| Token | Amount | Swap |
| ----- | ------ | ---- |
| DAI   | All    | USDS |
| LUSD  | All    | USDC |
| PYUSD | All    | USDC |

### Ahab Budget Extension

Asset: aEthUSDT `0x23878914EFE38d27C4D67Ab83ed1b93A74D4086a`
Amount: 0.25M

Asset: aEthUSDC `0x98C23E9d8f34FEFb1B7BD6a91B7FF122F4e16F5c`
Amount: 0.25M

Asset: aEthLidoUSDS `0x09AA30b182488f769a9824F15E6Ce58591Da4781`
Amount: 0.25M

Asset: aEthLidoGHO: `0x18eFE565A5373f430e2F809b97De30335B3ad96A`
Amount: 0.25M

Spender: Ahab `0xAA2461f0f0A3dE5fEAF3273eAe16DEF861cf594e`

### Gnosis Liquidity Mining Rewards

GnosisV3Collector Approval
Asset: aGnoEURe: `0x3e652E97ff339B73421f824F5b03d75b62F1Fb51`
Amount: 6,000
Spender: ACI `0xdef1FA4CEfe67365ba046a7C630D6B885298E210`

### AAVE Buybacks

Create a 2M aEthUSDT and 2M aEthUSDC allowance for the Aave Finance Committee to perform 6 weeks of AAVE buybacks.

Asset: aEthUSDT `0x23878914EFE38d27C4D67Ab83ed1b93A74D4086a`
Amount: 2M

Asset: aEthUSDC `0x98C23E9d8f34FEFb1B7BD6a91B7FF122F4e16F5c`
Amount: 2M

Spender: AFC [0x22740deBa78d5a0c24C58C740e3715ec29de1bFa](https://etherscan.io/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa)

Method: approve() aEthUSDT and aEthUSDC on the Aave Collector contract to the AFC address.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250721_Multi_July2025FundingUpdate/AaveV3Ethereum_July2025FundingUpdate_20250721.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250721_Multi_July2025FundingUpdate/AaveV3Polygon_July2025FundingUpdate_20250721.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250721_Multi_July2025FundingUpdate/AaveV3Arbitrum_July2025FundingUpdate_20250721.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250721_Multi_July2025FundingUpdate/AaveV3Gnosis_July2025FundingUpdate_20250721.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250721_Multi_July2025FundingUpdate/AaveV3Ethereum_July2025FundingUpdate_20250721.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250721_Multi_July2025FundingUpdate/AaveV3Polygon_July2025FundingUpdate_20250721.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250721_Multi_July2025FundingUpdate/AaveV3Arbitrum_July2025FundingUpdate_20250721.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250721_Multi_July2025FundingUpdate/AaveV3Gnosis_July2025FundingUpdate_20250721.t.sol)
- Snapshot: Direct-to-AIP
- [SnapshotOrbit](https://snapshot.box/#/s:aavedao.eth/proposal/0x2b497f613d426aa0f641fcd445132148b4faa81ad0c9c054e1062be886f45cdd)
- [Discussion](https://governance.aave.com/t/direct-to-aip-july-2025-funding-update/22555)
- [DiscussionOrbit](https://governance.aave.com/t/arfc-orbit-program-renewal-q2-2025/22497/1)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
