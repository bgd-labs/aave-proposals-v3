---
title: "Increase cbBTC Supply Caps"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-increase-cbbtc-supply-caps-on-aave-v3-ethereum-market-and-base/19304"
---

## Simple Summary

This proposal aims to increase the supply caps for cbBTC on both the Aave V3 Ethereum Market and BASE. The increase in supply caps will allow for greater utilization of cbBTC within the Aave ecosystem, potentially improving liquidity and capital efficiency.

## Motivation

The current supply caps for cbBTC on Aave V3 Ethereum and BASE markets may be limiting the potential growth and utilization of this asset, as we’ve seen demand and current Supply Caps not being enough to allocate it.

By increasing these caps, we can:

1. Enhance liquidity for cbBTC within the Aave protocol.
2. Provide more opportunities for users to supply and borrow cbBTC.
3. Potentially attract more users and capital to the Aave ecosystem.

## Specification

Ticker: cbBTC (cbBTC)

Mainnet: 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf

Base: 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf

We propose to Increase Supply Caps on Mainnet to 10000 cbBTC and to Increase Supply Caps on Base to 5000 cbBTC.

| cbBTC                | Ethereum V3 | Base       |
| -------------------- | ----------- | ---------- |
| Increase Supply Caps | 10000 cbBTC | 5000 cbBTC |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/e4cad4615ad125404aa6cf2b43325f2cd4f1d167/src/20241004_Multi_IncreaseCbBTCSupplyCaps/AaveV3Ethereum_IncreaseCbBTCSupplyCaps_20241004.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/e4cad4615ad125404aa6cf2b43325f2cd4f1d167/src/20241004_Multi_IncreaseCbBTCSupplyCaps/AaveV3Base_IncreaseCbBTCSupplyCaps_20241004.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/e4cad4615ad125404aa6cf2b43325f2cd4f1d167/src/20241004_Multi_IncreaseCbBTCSupplyCaps/AaveV3Ethereum_IncreaseCbBTCSupplyCaps_20241004.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/e4cad4615ad125404aa6cf2b43325f2cd4f1d167/src/20241004_Multi_IncreaseCbBTCSupplyCaps/AaveV3Base_IncreaseCbBTCSupplyCaps_20241004.t.sol)
- Snapshot: Direct AIP
- [Discussion](https://governance.aave.com/t/arfc-increase-cbbtc-supply-caps-on-aave-v3-ethereum-market-and-base/19304)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
