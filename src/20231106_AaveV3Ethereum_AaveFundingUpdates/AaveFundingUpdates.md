---
title: "Aave Funding Updates (part 2)"
author: "TokenLogic, efecarranza.eth"
discussions: "https://governance.aave.com/t/arfc-aave-funding-update/15194"
---

## Simple Summary

This AIP aims to consolidate Aave DAO's stablecoin holdings. It is divided into different parts that are detailed below. This is part two and it consists of depositing USDC into Aave v3 Ethereum, as well as migrating the v2 position to v3 in Ethereum. Also depositing USDT into Aave v2 Ethereum and swapping DAI and USDC for GHO.

## Motivation

This AIP (Part B) when implemented ensures the Aave Protocol is sufficiently funded to support service providers receiving DAI, GHO and USDT.

The funds transferred from Polygon to Ethereum by the Aave Funding Part A AIP are to be deposited into Aave v2 and v3 as required and DAI swapped to GHO. In addition, with no USDC stream drawing from Aave v2 on Ethereum, all USDC is to be withdrawn from v2. 1.00M of this USDC is to be swapped to GHO and the remainder to be deposited into v3.

## Specification

- Deposit 1.7M units of USDC from Treasury into Aave v3 Ethereum (received from Polygon bridge)
- Deposit 750k units of USDT from Treasury into Aave v3 Ethereum (received from Polygon bridge)
- Withdraw all but 10 units of USDC from Aave v2 Ethereum Pool into USDC (keep 10 units of USDC as dust, as to not leave an empty reserve)
- Deposit the balance of the withdrawn USDC, minuts the 1.0M to be swapped, into Aave v3 Ethereum Pool (withdrawn in previous step)

Swap the following asset holdings to GHO:

- 500k units of DAI held in Treasury (received from Polygon bridge)
- 1.0M units of USDC (withdrawn from Aave v2 Ethereum in previous step)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/6f6d369f9ae1d13828b93b7a1276cf6241682cd4/src/20231106_AaveV3Ethereum_AaveFundingUpdates/AaveV3Ethereum_AaveFundingUpdates_20231106.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/6f6d369f9ae1d13828b93b7a1276cf6241682cd4/src/20231106_AaveV3Ethereum_AaveFundingUpdates/AaveV3Ethereum_AaveFundingUpdates_20231106.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x099f88e1728760952be26fcb8fc99b26c29336e6a109820b391751b108399ee5)
- [Discussion](https://governance.aave.com/t/arfc-aave-funding-update/15194)

## Disclaimer

TokenLogic and karpatkey receive no compensation beyond Aave protocol for the creation of this proposal. TokenLogic and karpatkey are both delegates within the Aave ecosystem.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
