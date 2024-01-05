---
title: "Aave Pool update"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/pre-cautionary-measures-on-three-aave-v3-assets/16037"
---

## Simple summary

Proposal to apply a fix on Aave v3 for all different instances.

## Motivation

During an internal security review, a technical problem on Aave v3 has been detected. After coordinating with the Aave Guardian to apply protective measures, this proposal applies a fix on all Aave v3 instances, that completely solves the issue.

## Specification

The proposal does an upgrade of the Aave Pool, on all different Aave instances, by calling the setPoolImpl() function on the PoolAddressesProvider smart contract.
In order to not disclose the patch in advance, the code will be verified just before execution. We have disclosed the code to contributors of the community (Certora, Avara, and extra security researchers) for them to certify in the governance forum thread about the legitimacy of the upgrade.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/af9ef67aebf264eab4d163f28e27e89a2e405a5a/src/20240104_Multi_Patch/AaveV3Ethereum_Patch_20240104.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/af9ef67aebf264eab4d163f28e27e89a2e405a5a/src/20240104_Multi_Patch/AaveV3Polygon_Patch_20240104.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/af9ef67aebf264eab4d163f28e27e89a2e405a5a/src/20240104_Multi_Patch/AaveV3Avalanche_Patch_20240104.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/af9ef67aebf264eab4d163f28e27e89a2e405a5a/src/20240104_Multi_Patch/AaveV3Optimism_Patch_20240104.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/af9ef67aebf264eab4d163f28e27e89a2e405a5a/src/20240104_Multi_Patch/AaveV3Arbitrum_Patch_20240104.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/af9ef67aebf264eab4d163f28e27e89a2e405a5a/src/20240104_Multi_Patch/AaveV3Base_Patch_20240104.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/af9ef67aebf264eab4d163f28e27e89a2e405a5a/src/20240104_Multi_Patch/AaveV3Gnosis_Patch_20240104.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/af9ef67aebf264eab4d163f28e27e89a2e405a5a/src/20240104_Multi_Patch/AaveV3Ethereum_Patch_20240104.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/af9ef67aebf264eab4d163f28e27e89a2e405a5a/src/20240104_Multi_Patch/AaveV3Polygon_Patch_20240104.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/af9ef67aebf264eab4d163f28e27e89a2e405a5a/src/20240104_Multi_Patch/AaveV3Avalanche_Patch_20240104.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/af9ef67aebf264eab4d163f28e27e89a2e405a5a/src/20240104_Multi_Patch/AaveV3Optimism_Patch_20240104.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/af9ef67aebf264eab4d163f28e27e89a2e405a5a/src/20240104_Multi_Patch/AaveV3Arbitrum_Patch_20240104.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/af9ef67aebf264eab4d163f28e27e89a2e405a5a/src/20240104_Multi_Patch/AaveV3Base_Patch_20240104.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/af9ef67aebf264eab4d163f28e27e89a2e405a5a/src/20240104_Multi_Patch/AaveV3Gnosis_Patch_20240104.t.sol)
- [Discussion](https://governance.aave.com/t/pre-cautionary-measures-on-three-aave-v3-assets/16037)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
