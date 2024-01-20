---
title: "StkGHO Activation"
author: "Aave Labs & ACI"
discussions: "https://governance.aave.com/t/arfc-upgrade-safety-module-with-stkgho/15635"
---

## Simple Summary

This AIP activates the new GHO based Safety module by initiating the emission schedule approved by the community during the [Snapshot vote](https://snapshot.org/#/aave.eth/proposal/0x4bc99a842adab6cdd8c7d5c7a787ee4c0056be554fde0d008d53b45b3e795065)

## Motivation

The GHO Safety Module will fortify the Aave Protocol’s resilience by adding a stablecoin asset, which is inherently less volatile than AAVE. This strategic move diversifies the Safety Module’s capacity to absorb shocks from various risk vectors in case of shortfall events.

## Specification

The GHO Safety module will be activated with the following parameters:

- Base emission: 50 AAVE/day
- Duration: Three months

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/198281130656afdb67959cfd957018fcf773a5fa/src/20240119_AaveV3Ethereum_StkGHOActivation/AaveV3Ethereum_StkGHOActivation_20240119.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/198281130656afdb67959cfd957018fcf773a5fa/src/20240119_AaveV3Ethereum_StkGHOActivation/AaveV3Ethereum_StkGHOActivation_20240119.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x4bc99a842adab6cdd8c7d5c7a787ee4c0056be554fde0d008d53b45b3e795065)
- [Discussion](https://governance.aave.com/t/arfc-upgrade-safety-module-with-stkgho/15635)
- [StkGHO](https://etherscan.io/address/0x1a88Df1cFe15Af22B3c4c783D4e6F7F9e0C1885d)
- [StakeToken Repository](https://github.com/bgd-labs/stake-token)

## Disclaimer

Aave Labs, and ACI receive no compensation beyond Aave protocol for the creation of this proposal. ACI is delegate within the Aave ecosystem.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
