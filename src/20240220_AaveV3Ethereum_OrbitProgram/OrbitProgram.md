---
title: "Orbit Program"
author: "karpatkey_TokenLogic_ACI"
discussions: "https://governance.aave.com/t/arfc-orbit-program-renewal/16550"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x412b38c7a0cf1840b102e28ea7ef0373e3ab4b9544873e8cc1544972b777d9a1"
---

## Simple Summary

This proposal includes the renewal of the Orbit program for recognized delegates. Compensating them with GHO and ETH reimbursement of Gas costs associated with their governance activity.

## Motivation

The Orbit program Snapshot and discussion can be found [here](https://snapshot.org/#/aave.eth/proposal/0x412b38c7a0cf1840b102e28ea7ef0373e3ab4b9544873e8cc1544972b777d9a1) and [here](https://governance.aave.com/t/arfc-orbit-program-renewal/16550) respectively.
LBS updated their address [here](https://governance.aave.com/t/arfc-orbit-program-renewal/16550/5?u=lbsblockchain).

The following table outlines the proposed compensation for eligible delegates matching the requirements:

| Delegate Platform | Retro-Payment (GHO) | New Stream (GHO) |
| ----------------- | ------------------- | ---------------- |
| EzR3al            | 5000                | 15000            |
| Stable Labs       | 5000                | 15000            |
| LBS Blockchain    | 5000                | 15000            |
| Michigan          | 5000                | 15000            |

In terms of gas rebate, we included Gov V2 reimbursement & payload-related activity in the following table:

| Delegate / Service Provider | Gas Used (ETH) |
| --------------------------- | -------------- |
| ACI                         | 3.365          |
| Tokenlogic                  | 0.586          |
| Michigan                    | 0.276          |
| Wintermute                  | 0.2518         |
| LBS                         | 0.031          |
| StableLabs                  | 0.0342         |
| ezr3al                      | 0.3833         |
| Total                       | 4.9273         |

Note Michigan has rebranded as Arana as can be seen in the forum [here](https://governance.aave.com/t/arfc-orbit-program-renewal/16550/6).

## Specification

- Create GHO streams for Orbit participants of 15,000 GHO for 90 days as detailed in the table above
- Transfer GHO for Orbit participants of 5,000 as retroactive payment as detailed in the table above
- Transfer ETH to delegates/service providers as detailed in the table above

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240220_AaveV3Ethereum_OrbitProgram/AaveV3Ethereum_OrbitProgram_20240220.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240220_AaveV3Ethereum_OrbitProgram/AaveV3Ethereum_OrbitProgram_20240220.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x412b38c7a0cf1840b102e28ea7ef0373e3ab4b9544873e8cc1544972b777d9a1)
- [Discussion](https://governance.aave.com/t/arfc-orbit-program-renewal/16550)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
