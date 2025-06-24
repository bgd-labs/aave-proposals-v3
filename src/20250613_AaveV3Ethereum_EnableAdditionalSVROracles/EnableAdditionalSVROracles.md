---
title: "Enable additional SVR oracles"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/direct-to-aip-aave-chainlink-svr-v1-activation-phase-3/22387"
---

## Simple Summary

Activates SVR feeds for ETH correlated assets and USDC on Aave V3 Ethereum core.

## Motivation

SVR feeds for ETH correlated assets have been successfully activated on Aave V3 `Prime` instance. This proposal aims to extend the coverage of SVR feeds to include the `Core` instance.

## Specification

As previous activation proposals, this proposal utilizes the `SVR_STEWARD` to replace the existing Oracle feeds with the SVR equivalent, ensuring strict validation of price similarity.

The following feeds will be activated:

- [`WETH`](https://etherscan.io/address/0x5424384B256154046E9667dDFaaa5e550145215e)
- [`weETH`](https://etherscan.io/address/0x87625393534d5C102cADB66D37201dF24cc26d4C)
- [`osETH`](https://etherscan.io/address/0x2b86D519eF34f8Adfc9349CDeA17c09Aa9dB60E2)
- [`ETHx`](https://etherscan.io/address/0xd7b163B671f8cE9379DF8Ff7F75fA72Ccec1841c)
- [`rsETH`](https://etherscan.io/address/0x7292C95A5f6A501a9c4B34f6393e221F2A0139c3)
- [`wstETH`](https://etherscan.io/address/0xe1D97bF61901B075E9626c8A2340a7De385861Ef)
- [`rETH`](https://etherscan.io/address/0x6929706c42d637DF5Ebf7F0BcfF2aF47F84Ea69D)
- [`cbETH`](https://etherscan.io/address/0x889399C34461b25d70d43931e6cE9E40280E617B)
- [`USDC`](https://etherscan.io/address/0x3f73F03aa83B2A48ed27E964eD0fDb590332095B)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/50482379de120dc569c34dc5073b46f6e276e5a6/src/20250613_AaveV3Ethereum_EnableAdditionalSVROracles/AaveV3Ethereum_EnableAdditionalSVROracles_20250613.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/50482379de120dc569c34dc5073b46f6e276e5a6/src/20250613_AaveV3Ethereum_EnableAdditionalSVROracles/AaveV3Ethereum_EnableAdditionalSVROracles_20250613.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-aave-chainlink-svr-v1-activation-phase-3/22387)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
