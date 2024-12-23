---
title: "Onboard AUSD"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-onboard-ausd-to-aave-v3-on-avalanche/19689"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x021b40c7042ce770c0ce1ee5ff63591c132a9f0f12e3a1cb92fa209299793dec"
---

## Simple Summary

This proposal seeks to onboard AUSD, a secure digital dollar backed 1:1 by USD fiat, to Aave V3 on Avalanche. AUSD, issued by Agora, serves as a stable and liquid alternative to USDT and USDC. With a growing AUM and robust liquidity, AUSD will enhance Aave’s liquidity pool, offering users a reliable and efficient stablecoin option with strong institutional backing.

## Motivation

Agora offers AUSD, a digital dollar minted 1:1 with USD fiat. AUSD is designed to be a secure digital currency, utilizing one of the world’s largest custodian banks to safeguard assets. AUSD enables users to participate in trading, lending and payments. It is the most cost-efficient stablecoin to transact with due to its gas-optimized smart contract, making it ideal for traders and payments.

Agora operates an open partnership model, allowing collaboration with a diverse range of customers who meet KYB (Know Your Business) requirements and operate in jurisdictions we can serve. This approach contrasts with single partnership models (eg. Exchange-Backed Stables), ensuring that AUSD can be widely adopted across different ecosystems, providing liquidity and stability without conflicts of interest.

AUSD is currently available on Ethereum, Avalanche, Sui and Mantle, garnering $70+ million in TVL and $12+ million in daily DEX volume since contract deployment. The reserve assets are managed by VanEck ($100B+ asset manager) and custodied with one of the largest global banks, ensuring security and safety. AUSD’s unique value proposition also includes zero-fee minting and redemption facilities, making it an attractive asset for all ecosystem participants.

By integrating AUSD into Aave, users will gain access to a stable, liquid asset that supports trading, lending, and other decentralized finance activities. This integration aligns with Aave’s mission to decentralize finance while offering secure and reliable stablecoin options.

## Specification

The table below illustrates the configured risk parameters for **AUSD**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                      false |
| Supply Cap (AUSD)         |                                 19,000,000 |
| Borrow Cap (AUSD)         |                                 17,400,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                        0 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      5.5 % |
| Variable Slope 2          |                                       75 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x83f32c0882B12Ef16214c417efF11FD9e764bf34 |

Additionaly [0xac140648435d03f784879cd789130F22Ef588Fcd](https://snowtrace.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for AUSD and the corresponding aToken.

## References

- Implementation: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/b368d236cc385cba56cee2009278e67145e10325/src/20241125_AaveV3Avalanche_OnboardAUSD/AaveV3Avalanche_OnboardAUSD_20241125.sol)
- Tests: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/b368d236cc385cba56cee2009278e67145e10325/src/20241125_AaveV3Avalanche_OnboardAUSD/AaveV3Avalanche_OnboardAUSD_20241125.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x021b40c7042ce770c0ce1ee5ff63591c132a9f0f12e3a1cb92fa209299793dec)
- [Discussion](https://governance.aave.com/t/arfc-onboard-ausd-to-aave-v3-on-avalanche/19689)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
