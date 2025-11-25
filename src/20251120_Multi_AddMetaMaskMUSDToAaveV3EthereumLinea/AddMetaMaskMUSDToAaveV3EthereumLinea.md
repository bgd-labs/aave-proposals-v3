---
title: "Add MetaMask USD (mUSD) to Aave V3 Ethereum/Linea"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-add-metamask-usd-musd-to-aave-v3-core-instance-on-ethereum-and-linea/23097"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x9abb72d91df849e8723ed6e8f20151310f42861a2c0d420f300324d855d787d9"
---

## Simple Summary

This publication proposes onboarding MetaMask's mUSD stablecoin to the Core instance of Aave v3 on Ethereum and Linea.

## Motivation

MetaMask USD (mUSD) is a dollar-denominated stablecoin natively integrated into MetaMask. mUSD is issued by Bridge, a Stripe company, and stablecoin issuance and orchestration platform. On-chain MetaMask USD is powered by M0, a decentralized stablecoin infrastructure and liquidity platform. mUSD will be deeply integrated into MetaMask’s wallet, offering users a seamless, dollar-denominated stablecoin experience for holding, spending, and transacting in web3.

### Key properties

- Wallet-native: deeply integrated across MetaMask UX and supported dapps.
- Multi-chain at launch: Ethereum Mainnet and Linea and will play a foundational role in the growing Linea DeFi ecosystem and network expansion.
- Interoperable: designed for cross-chain liquidity via the M0 network.
- Transparency-first: reserve management by Bridge with real-time reporting.
  mUSD is fully backed 1:1 by high-quality, liquid dollar-equivalent assets. Bridge provides real-time transparency reporting, with independent attestations to follow. The launch aligns with new U.S. regulatory clarity under the GENIUS Act.

### Payments & MetaMask Card

mUSD supports on-ramps, swaps, bridging, and will soon be spendable via the MetaMask Card at millions of Mastercard merchants.

## Specification

The table below illustrates the configured risk parameters for **mUSD** on Ethereum.

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                      false |
| Supply Cap (mUSD)         |                                 10,000,000 |
| Borrow Cap (mUSD)         |                                  8,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                        0 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      6.5 % |
| Variable Slope 2          |                                       60 % |
| Uoptimal                  |                                       80 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xf22de319901C3b9BAEc7Fa14FdF013Ede40E7312 |

### Oracle

| Parameter      |                                                                                         Value |
| -------------- | --------------------------------------------------------------------------------------------: |
| Oracle address | [Capped mUSD / USD ](https://etherscan.io/address/0xf22de319901C3b9BAEc7Fa14FdF013Ede40E7312) |
| Underlying     |         [mUSD / USD](https://etherscan.io/address/0xc90E3460424fb8ea79775089E9053113FEE34Ed0) |
| last answer    |                                                                   (2025-11-24) USD 0.99995036 |

The table below illustrates the configured risk parameters for **mUSD** on Linea.

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                      false |
| Supply Cap (mUSD)         |                                 70,000,000 |
| Borrow Cap (mUSD)         |                                 60,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                        0 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      6.5 % |
| Variable Slope 2          |                                       60 % |
| Uoptimal                  |                                       80 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xB8454f3b48395103F23c88B699d4F6A81fD1DCff |

### Oracle

| Parameter      |                                                                                            Value |
| -------------- | -----------------------------------------------------------------------------------------------: |
| Oracle address | [Capped mUSD / USD ](https://lineascan.build/address/0xB8454f3b48395103F23c88B699d4F6A81fD1DCff) |
| Underlying     |         [mUSD / USD](https://lineascan.build/address/0xc834a55fb78dEa866E9cd86047Df0F584B9da339) |
| last answer    |                                                                      (2025-11-24) USD 0.99974795 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251120_Multi_AddMetaMaskMUSDToAaveV3EthereumLinea/AaveV3Ethereum_AddMetaMaskMUSDToAaveV3EthereumLinea_20251120.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251120_Multi_AddMetaMaskMUSDToAaveV3EthereumLinea/AaveV3Linea_AddMetaMaskMUSDToAaveV3EthereumLinea_20251120.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251120_Multi_AddMetaMaskMUSDToAaveV3EthereumLinea/AaveV3Ethereum_AddMetaMaskMUSDToAaveV3EthereumLinea_20251120.t.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251120_Multi_AddMetaMaskMUSDToAaveV3EthereumLinea/AaveV3Linea_AddMetaMaskMUSDToAaveV3EthereumLinea_20251120.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x9abb72d91df849e8723ed6e8f20151310f42861a2c0d420f300324d855d787d9)
- [Discussion](https://governance.aave.com/t/arfc-add-metamask-usd-musd-to-aave-v3-core-instance-on-ethereum-and-linea/23097)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
