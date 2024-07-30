---
title: "wETH LTV0 Aave V3 Lido Instance "
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-deploy-a-lido-aave-v3-instance/18047/18"
---

## Simple Summary

This AIP proposes to update the recently deployed Lido Aave v3 instance by setting the wETH LTV to zero, shifting focus to the instance's intended main use case of leveraged staking.

## Motivation

Following discussions with service providers, the Lido Aave v3 instance was initially launched with wETH as collateral to allow quick growth of the wETH reserve, preparing the grounds for third-party integrations such as DefiSaver to bring wstETH liquidity and usage.

This kickstart strategy was highly successful, attracting $121 million in deposits within 24 hours, surpassing our projections. Now, it's time to adjust the strategy by cutting the wETH LTV to zero and focusing on the instance's primary intended use case: leveraged staking.

The motivation for this change includes:

1. Refocusing the instance on its primary use case of leveraged staking with wstETH.
2. Reducing potential risks associated with using wETH as collateral in this specialized instance.
3. Encouraging users to migrate towards wstETH for collateral, aligning with the Lido ecosystem focus.

This AIP proposes the following changes to the Lido Aave v3 instance for wETH:

- Set wETH LTV (Loan-to-Value) from 82% to 0%

All other parameters for wETH will remain unchanged:

| Parameter | Current Value | Proposed Value |
| --------- | ------------- | -------------- |
| LTV       | 82%           | 0%             |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729/AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729/AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-deploy-a-lido-aave-v3-instance/18047/18)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
