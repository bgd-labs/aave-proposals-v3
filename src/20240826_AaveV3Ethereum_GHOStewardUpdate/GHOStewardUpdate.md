---
title: "GHO Steward Update"
author: "BGD Labs (@bgdlabs)"
discussions: ""
---

## Simple Summary

This proposal aims to upgrade the GHO Steward contract to a new version that is compatible with Aave v3.1. The update ensures that the GHO Steward can continue to effectively manage GHO parameters on the latest Aave v3.1 version.

## Motivation

The Aave v3.1 upgrade introduced stateful interest rates, rendering the existing GHO Steward incompatible due to its reliance on fixed interest rate strategy contracts. During the v3.1 upgrade, the original GHO Steward was not deactivated to allow for adjustments to parameters other than the borrow rate. In the interim, GHO borrow rate updates were being managed through governance proposals (such as [Proposal 151](https://vote.onaave.com/proposal/?proposalId=151)).

The activation of this new GHO Steward will restore full functionality to the GHO Stewards, allowing to manage all GHO parameters effectively within the current Aave protocol version.

Same as earlier, the GHO Stewards will consist of members from Growth (ACI), Risk (ChaosLabs) and Finance (TokenLogic + Karpatkey) Service Providers and utilize a 3 of 4 [multi-sig](https://etherscan.io/address/0x8513e6F37dBc52De87b166980Fa3F50639694B60).

## Specification

The proposal gives / revokes the following admin roles:

- Grant new GHO Steward the Risk Admin role via the [ACL_MANAGER](https://etherscan.io/address/0xc2aaCf6553D20d1e9d78E365AAba8032af9c85b0) contract and revoke from the old Steward.
- Grant new GHO Steward the Bucket Manager role on the [GHO token](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f) and revoke from the old Steward.
- Grant new GHO Steward the Configurator role on [GSM_USDC](https://etherscan.io/address/0x0d8eFfC11dF3F229AA1EA0509BC9DFa632A13578) and [GSM_USDT](https://etherscan.io/address/0x686F8D21520f4ecEc7ba577be08354F4d1EB8262) and revoke from the old Steward.
- Whitelists all the facilitators on the new GHO Stewards, including: [GHO_AToken](https://etherscan.io/address/0x00907f9921424583e7ffBfEdf84F92B7B2Be4977), [GHO_FlashMinter](https://etherscan.io/address/0xb639D208Bcf0589D54FaC24E655C79EC529762B8), [GSM_USDC](https://etherscan.io/address/0x0d8eFfC11dF3F229AA1EA0509BC9DFa632A13578), [GSM_USDT](https://etherscan.io/address/0x686F8D21520f4ecEc7ba577be08354F4d1EB8262) - so that the steward has the permissions to update the bucket capacity.

Changes:

- GHO borrow rate change is now done via stateful interest rates, being compatible with Aave v3.1

_Note: The params for the GHO Stewards will be exactly the same as on the earlier version._

## References

- GHO Steward SAFE address: [0x8513e6F37dBc52De87b166980Fa3F50639694B60](https://etherscan.io/address/0x8513e6F37dBc52De87b166980Fa3F50639694B60)
- GHO Steward V2 address: [0x1180eE41eC15Dd0accC13a1e646B3152bECFf8F6](https://etherscan.io/address/0x1180ee41ec15dd0accc13a1e646b3152becff8f6)
- GHO Steward Repo: [GhoStewardV2.sol](TODO-ADD-AFTER-PR-MERGE)
- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240826_AaveV3Ethereum_GHOStewardUpdate/AaveV3Ethereum_GHOStewardUpdate_20240826.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240826_AaveV3Ethereum_GHOStewardUpdate/AaveV3Ethereum_GHOStewardUpdate_20240826.t.sol)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
