---
title: "Enable SVR on Base and Arbitrum"
author: "BGD Labs @bgdlabs"
discussions: https://governance.aave.com/t/arfc-aave-chainlink-svr-multi-network-expansion-base-arbitrum/24241
snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xc230fa0a74af2a064ca8c908d0edd61a23ad99dba6c73ec06dbd819fe766269a
---

## Simple Summary

Enable SVR price feeds on Base and Arbitrum.

## Motivation

After a successful implementation of SVR on Ethereum, we aim to expand its coverage to Base and Arbitrum networks.

## Specification

- **Ethereum**: Removes the SVR steward's `AssetListingAdmin` role from both `AaveV3 Ethereum Core` and `AaveV3 Ethereum Lido` pools, as the steward has already completed its work on mainnet and no longer needs elevated permissions.

- **Arbitrum**: Grants the SVR Oracle Steward ([`0x94E54D858e9293964b4ACd6f8938c831827a31F4`](https://arbiscan.io/address/0x94E54D858e9293964b4ACd6f8938c831827a31F4)) the `AssetListingAdmin` role and enables SVR oracles for the following 17 assets:
  DAI, LINK, USDC, WBTC, WETH, USDT, AAVE, wstETH, rETH, LUSD, USDCn, FRAX, ARB, weETH, ezETH, rsETH, tBTC.

- **Base**: Grants the SVR Oracle Steward ([`0x4B09DAEAe857b93c9103392028294F0602C5fD5b`](https://basescan.org/address/0x4B09DAEAe857b93c9103392028294F0602C5fD5b)) the `AssetListingAdmin` role and enables SVR oracles for the following 14 assets:
  WETH, cbETH, USDbC, wstETH, USDC, weETH, cbBTC, ezETH, wrsETH, LBTC, EURC, AAVE, tBTC, syrupUSDC.

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260224_Multi_EnableSVROnBaseAndArbitrum/AaveV3Ethereum_EnableSVROnBaseAndArbitrum_20260224.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260224_Multi_EnableSVROnBaseAndArbitrum/AaveV3Arbitrum_EnableSVROnBaseAndArbitrum_20260224.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260224_Multi_EnableSVROnBaseAndArbitrum/AaveV3Base_EnableSVROnBaseAndArbitrum_20260224.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260224_Multi_EnableSVROnBaseAndArbitrum/AaveV3Ethereum_EnableSVROnBaseAndArbitrum_20260224.t.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260224_Multi_EnableSVROnBaseAndArbitrum/AaveV3Arbitrum_EnableSVROnBaseAndArbitrum_20260224.t.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260224_Multi_EnableSVROnBaseAndArbitrum/AaveV3Base_EnableSVROnBaseAndArbitrum_20260224.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0xc230fa0a74af2a064ca8c908d0edd61a23ad99dba6c73ec06dbd819fe766269a)
- [Discussion](https://governance.aave.com/t/arfc-aave-chainlink-svr-multi-network-expansion-base-arbitrum/24241)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
