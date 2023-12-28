---
title: "Aave Funding Updates (part 2)"
author: "TokenLogic, efecarranza.eth"
discussions: "https://governance.aave.com/t/arfc-aave-funding-update/15194"
---

## Simple Summary

This AIP aims to consolidate Aave DAO's stablecoin holdings. It is divided into different parts that are detailed below. This is part two and it consists of depositing USDC into Aave v3 Ethereum, as well as migrating the v2 position to v3 in Ethereum. Also depositing USDT into Aave v2 Ethereum and swapping DAI for GHO.

## Motivation

This proposal intends to ensure the DAO is well capitalised.

The DAO has sufficient USDC, DAI and USDT deposited across the various instances of Aave Protocol to support existing streams and the AURA purchase 3.

However, with the emergence of new service provider proposal expected, the DAO needs to adjust its stable coin holdings. This publication supports transferring additional funds from Polygon to Mainnet and acquiring GHO on the market to ensure the DAO is well capitalised for the next 6 months. It also aims to move assets from the old V2 to the newer V3 aToken.

## Specification

- Deposit 1.7M units of USDC from Treasury into Aave v3 Ethereum (received from Polygon bridge)
- Deposit 750k units of USDT from Treasury into Aave v3 Ethereum (received from Polygon bridge)
- Withdraw 900k units of USDC from Aave v2 Ethereum Pool into USDC
- Deposit 900k of USDC into Aave v3 Ethereum Pool (withdrawn in previous step)

Swap the following asset holdings to GHO:

- 500k units of DAI held in Treasury (received from Polygon bridge)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231106_AaveV3Ethereum_AaveFundingUpdates/AaveV3Ethereum_AaveFundingUpdates_20231106.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231106_AaveV3Ethereum_AaveFundingUpdates/AaveV3Ethereum_AaveFundingUpdates_20231106.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x099f88e1728760952be26fcb8fc99b26c29336e6a109820b391751b108399ee5)
- [Discussion](https://governance.aave.com/t/arfc-aave-funding-update/15194)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
