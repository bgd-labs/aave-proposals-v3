---
title: "Extend GHO Steward on Aave Prime Instance"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-extend-gho-steward-on-aave-prime-instance/20598"
snapshot: "https://snapshot.org/#/s:aave.eth/proposal/0xf28190a683eff1dc246924f150a724dcf29b23dd40971df38d20fc6cf301fbe1"
---

## Simple Summary

This publication proposes extending the GHO Aave Steward to the GHO market on the Prime instance.

## Motivation

In response to the expanding GHO ecosystem and following the upgrade of the [GHO Stewards](https://governance.aave.com/t/arfc-gho-steward-v2-upgrade/19116) to a more modular approach at the end of 2024, this publication proposes extending the GHO Aave Steward role to the GHO Reserve on the Prime instance of Aave v3 on Ethereum.

Similar to how the GHO reserve on Arbitrum, which already has a GHO Aave Steward implementation, the role will be extended to the Prime instance of Aave v3.

## Specification

A new [GhoAaveSteward](https://etherscan.io/address/0x5C905d62B22e4DAa4967E517C4a047Ff6026C731) was deployed, with the Prime configuration:

Owner: [0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A](https://etherscan.io/address/0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A)

Addresses Provider: [0xcfBf336fe147D643B9Cb705648500e101504B16d](https://etherscan.io/address/0xcfBf336fe147D643B9Cb705648500e101504B16d)

Pool Data Provider: [0x08795CFE08C7a81dCDFf482BbAAF474B240f31cD](https://etherscan.io/address/0x08795CFE08C7a81dCDFf482BbAAF474B240f31cD)

Gho Token: [0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f)

Risk Council: [0x8513e6F37dBc52De87b166980Fa3F50639694B60](https://etherscan.io/address/0x8513e6F37dBc52De87b166980Fa3F50639694B60)

BorrowRateConfig:

- UOptimal Max Change: 500
- Base Variable Rate Max Change: 500
- Slope 1 Max Change: 500
- Slope 2 Max Change: 500

Then, the GhoAaveSteward is to be granted the following permissions: `RiskAdmin` in Aave V3 Ethereum Prime Pool

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250129_AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance/AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250129_AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance/AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129.t.sol)
- [Snapshot](https://snapshot.org/#/s:aave.eth/proposal/0xf28190a683eff1dc246924f150a724dcf29b23dd40971df38d20fc6cf301fbe1)
- [Discussion](https://governance.aave.com/t/arfc-extend-gho-steward-on-aave-prime-instance/20598)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
