---
title: "Aave V4 Ethereum Activation"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0x55e85a32828da36122b9c8d50548696d7c748fd41c775f5bf06bdf0f2e32a265"
---

## Simple Summary

Activates all spokes on all hubs (Core, Plus, Prime) for all listed assets on Aave V4 Ethereum. Additionally, the treasury spoke is activated for every asset on every hub.

## Motivation

As part of the Aave V4 deployment on Ethereum, all spokes need to be activated on each hub to enable the full hub-spoke lending architecture.

## Specification

For each hub (Core, Plus, Prime) and each asset, the proposal:

1. Activates each of the 11 spokes (including the treasury spoke and tokenization spoke) where they are listed via `updateSpokeActive` on the Hub Configurator.

| Hub       | Address                                    |
| --------- | ------------------------------------------ |
| Core Hub  | 0xDA21DF2D9297f3E1CB564A54190a2984DF42B934 |
| Plus Hub  | 0x85F9b1d60f9F6fbD51006EA2E20Cde1A670A8eB4 |
| Prime Hub | 0x502B96A1A31572264e27474C2f1439E7FB69b6E8 |

<!-- TODO: Include the tokenization spoke once its address is available -->

| Spoke                   | Address                                    |
| ----------------------- | ------------------------------------------ |
| Main Spoke              | 0x47b880030329821412d614EAe2da68856E87C3fb |
| Bluechip Spoke          | 0x20f09138d51a85B075659ec325c66Da4Ca663Dea |
| Ethena Correlated Spoke | 0xA76fdE0bFF53ffcd5f3FbE84133C22F37C9E6Cf3 |
| Ethena Ecosystem Spoke  | 0x7c7C23bEe25ba4B12Bf1e11d12257A42030C6E04 |
| EtherFi eSpoke          | 0xDfdf5272E13F01Fa3D7590aB059589f0Ec1D4B02 |
| Forex Spoke             | 0x71e9339F9E8F0d1EFaf73C2823B7Bf7c0202D2aF |
| Gold Spoke              | 0x84aFeef66c1456244659e7F98705cA904aE5ebef |
| Kelp eSpoke             | 0xF3D54610227480Fc94D5C4677C2cf906901dac81 |
| Lido eSpoke             | 0x39299bc53cff6EA0bf9183EfCC4074e4b57504b1 |
| Lombard BTC Spoke       | 0x9A93D44e38c8505f24cCDFaEb2FbdfC1eba25c1C |
| Treasury Spoke          | 0x4f3647C9675723822BC618ad9b15802f6c893f06 |

## References

- Implementation: [AaveV4Ethereum_ActivateV4Ethereum_20260319](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260319_AaveV4Ethereum_ActivateV4Ethereum/AaveV4Ethereum_ActivateV4Ethereum_20260319.sol)
- Tests: [AaveV4Ethereum_ActivateV4Ethereum_20260319_Test](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260319_AaveV4Ethereum_ActivateV4Ethereum/AaveV4Ethereum_ActivateV4Ethereum_20260319.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x55e85a32828da36122b9c8d50548696d7c748fd41c775f5bf06bdf0f2e32a265)
- [Discussion](https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
