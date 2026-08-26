---
title: "Onboard PAXG to Global Dollar Hub"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-onboard-paxg-to-the-global-dollar-hub-in-aave-v4-ethereum/25340"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0x65be5cb5922bc73d14ba16b13d4e7ee5eaae2c6d9518c27b7ab9721fd2f637b1"
---

## Simple Summary

This proposal seeks to onboard Pax Gold (PAXG) to the Global Dollar Hub on the Aave V4 Ethereum instance. Final asset configuration will be determined by the Risk Service Providers.

## Motivation

PAXG is an ERC-20 token issued by Paxos Trust Company, where each unit represents one fine troy ounce of a London Good Delivery gold bar held in professional vaults. Redemption and custody are administered by a regulated issuer, and holdings are subject to periodic third-party attestations.

Onboarding PAXG to the Global Dollar Hub is aligned with the DAO's long-term objectives in several ways:

- It introduces a gold-backed, real-world asset to the Aave V4 Ethereum instance, broadening the range of collateral and liquidity available beyond dollar-denominated exposures.
- It gives users access to a regulated, physically-backed representation of gold within the Aave ecosystem, supporting demand from institutional participants and DeFi protocols seeking commodity exposure.
- It complements the Global Dollar Hub's existing composition, adding a non-correlated asset that strengthens the instance's position as a venue for diversified liquidity strategies.

## Specification

This proposal adds PAXG to Aave V4 Global Dollar Hub in Ethereum.

Token Address: [0x45804880De22913dAFE09f4980848ECE6EcbAf78](https://etherscan.io/address/0x45804880De22913dAFE09f4980848ECE6EcbAf78)

Likewise, adds PAXG as a collateral-only asset to a new Spoke named Gold Spoke. In parallel, to avoid additional governance proposals, enables native USDG as a borrowable reserve on the Pendle Spoke with a 4,000,000 USDG Draw Cap.

The Gold Spoke is already deployed at implementation time, so the payload configures the existing address-book deployment rather than deploying another Spoke.

At Hub level, PAXG uses the Treasury Spoke as fee receiver, a 0% liquidity fee, the existing Global Dollar interest-rate strategy with non-borrowable interest-rate data, and no Tokenization Spoke.

Execution should only proceed after the PAXG proxy-admin timelock migration required by the LlamaRisk assessment has been verified onchain.

### Dynamic Liquidation Bonus Configuration

As a non-crypto open-market spoke, it merits more conservative liquidation restoration parameters. Draw Caps will be set conservatively to reflect the Gold Spoke's still-developing borrow-side liquidity profile.

Spoke-level liquidation parameters:

| Parameter               | Value | Rationale                                                                                                                                      |
| ----------------------- | ----- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| targetHealthFactor      | 1.20  | Open-market non-crypto collateral dynamics require more conservative post-liquidation restoration than that of other Global Dollar Hub Spokes. |
| healthFactorForMaxBonus | 0.90  | Lower trigger avoids overpaying incentives too early while still reaching max LB before the deficit zone.                                      |
| liquidationBonusFactor  | 0.80  | Matches the Main Spoke baseline and preserves V3-equivalent Gold correlated asset bonus at HF~1 with a 1.25x max LB cap.                       |

### Spoke Parameters

| Hub               | Spoke        | Reserve | Collateral Factor | Max Liquidation Bonus | Borrowable | Collateral Risk | Liquidation Fee | riskPremiumThreshold | receiveShares |
| ----------------- | ------------ | ------- | ----------------: | --------------------: | ---------- | --------------: | --------------: | -------------------: | ------------- |
| Global Dollar Hub | Gold Spoke   | PAXG    |            75.00% |                 6.50% | FALSE      |               0 |          10.00% |                    0 | TRUE          |
| Global Dollar Hub | Gold Spoke   | USDG    |             0.00% |                     - | TRUE       |               - |               - |                    0 | TRUE          |
| Global Dollar Hub | Pendle Spoke | USDG    |             0.00% |                     - | TRUE       |               - |               - |                    0 | TRUE          |

`riskPremiumThreshold` is set to 0 for all reserves, in line with other assets across V4, as risk premiums are not currently in use. `receiveShares` is enabled for all reserves.

For required onchain fields, the `-` values in the table resolve to zero.

### Add and Draw Caps

| Hub               | Spoke        | Reserve |   Add Cap |  Draw Cap |
| ----------------- | ------------ | ------- | --------: | --------: |
| Global Dollar Hub | Gold Spoke   | PAXG    |      2500 |         0 |
| Global Dollar Hub | Gold Spoke   | USDG    | 5,000,000 | 9,500,000 |
| Global Dollar Hub | Pendle Spoke | USDG    |         - | 4,000,000 |

### Oracle

List PAXG against the Chainlink [XAU/USD price feed](https://etherscan.io/address/0x214eD9Da11D2fbe465a6fc601a91E62EbEc1a0D6), pricing the token at underlying gold spot with no CAPO growth-ceiling wrapper. PAXG carries no monotonic exchange-rate growth for a cap to bound, so a CAPO adapter is not recommended. The accepted risks are a sustained token-level dislocation priced at full gold spot and the feed's weekend staleness. The liquidation parameters set at any future collateral-enable phase must absorb that envelope rather than assume a continuously updating reference.

## References

- Implementation: [AaveV4Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260824_AaveV4Ethereum_OnboardPAXGGlobalDollarHub/AaveV4Ethereum_OnboardPAXGGlobalDollarHub_20260824.sol)
- Tests: [AaveV4Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260824_AaveV4Ethereum_OnboardPAXGGlobalDollarHub/AaveV4Ethereum_OnboardPAXGGlobalDollarHub_20260824.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x65be5cb5922bc73d14ba16b13d4e7ee5eaae2c6d9518c27b7ab9721fd2f637b1)
- [Discussion](https://governance.aave.com/t/arfc-onboard-paxg-to-the-global-dollar-hub-in-aave-v4-ethereum/25340)
- [Aave Labs technical assessment](https://governance.aave.com/t/paxos-gold-paxg-on-aave-ethereum-assessments/25359/2)
- [LlamaRisk risk assessment](https://governance.aave.com/t/paxos-gold-paxg-on-aave-ethereum-assessments/25359/3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
