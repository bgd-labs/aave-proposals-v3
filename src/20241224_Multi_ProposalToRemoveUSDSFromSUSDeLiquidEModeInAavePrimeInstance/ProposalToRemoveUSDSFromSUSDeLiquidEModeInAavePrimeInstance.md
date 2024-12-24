---
title: "Proposal to Remove USDS from sUSDe Liquid E-Mode in Aave Prime Instance"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/arfc-proposal-to-remove-usds-from-susde-liquid-e-mode-in-aave-prime-instance/20264"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x2be035a75fb8c5bb4e99e56006e57b7eb7df8bdd5616d903309ef6fc5b7446de"
---

## Simple Summary

This proposal recommends the removal of USDS from the sUSDe Liquid E-Mode in the Aave Prime instance.

## Motivation

The sUSDe Liquid E-Mode was introduced to enhance capital efficiency for users by allowing higher loan-to-value (LTV) ratios when using sUSDe as collateral to borrow stablecoins like USDS. See [this proposal](https://governance.aave.com/t/arfc-onboard-and-enable-susde-liquid-e-mode-on-aave-v3-mainnet-and-lido-instance/19703) for more context.

However, recent market observations have indicated increased borrow rates and potential liquidity mismatches involving USDS within this E-Mode. To address these concerns, this proposal suggests temporarily removing USDS from the sUSDe Liquid E-Mode in the Aave Prime instance.

The primary motivations for this proposal are:

1. **Risk Mitigation:** The inclusion of USDS in the sUSDe Liquid E-Mode has led to elevated borrow rates and potential liquidity mismatches.
2. **Collateral Isolation:** Until a wrapper is available to isolate USDS collateral in the Prime instance, USDS remains the primary exposure. Removing it from the sUSDe Liquid E-Mode will help manage associated risks more effectively.
3. **User Impact:** This change will not negatively impact existing user positions but will prevent the establishment of new ones involving USDS in the sUSDe Liquid E-Mode, thereby safeguarding current users while mitigating potential future risks.

## Specification

The proposed changes are as follows:

- **Asset Removal:** Exclude USDS from the sUSDe Liquid E-Mode in the Aave Prime instance.
- **Parameter Adjustments:** Update the E-Mode configuration to reflect the removal of USDS, ensuring alignment with the protocol’s risk management framework.
- **Liquidation buffer improvement:**
  echoing concerns from @LlamaRisk and other service providers, sUSDe emode on both Prime & Core instances are set to increase their buffer for liquidations.
  - Increase Liquidation Bonus from 3 to 4% on e-modes on Core and Prime instances.

Current ARFC will be reviewed by Risk Service Providers and their feedback will be included in the current ARFC.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241224_Multi_ProposalToRemoveUSDSFromSUSDeLiquidEModeInAavePrimeInstance/AaveV3Ethereum_ProposalToRemoveUSDSFromSUSDeLiquidEModeInAavePrimeInstance_20241224.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241224_Multi_ProposalToRemoveUSDSFromSUSDeLiquidEModeInAavePrimeInstance/AaveV3EthereumLido_ProposalToRemoveUSDSFromSUSDeLiquidEModeInAavePrimeInstance_20241224.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241224_Multi_ProposalToRemoveUSDSFromSUSDeLiquidEModeInAavePrimeInstance/AaveV3Ethereum_ProposalToRemoveUSDSFromSUSDeLiquidEModeInAavePrimeInstance_20241224.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241224_Multi_ProposalToRemoveUSDSFromSUSDeLiquidEModeInAavePrimeInstance/AaveV3EthereumLido_ProposalToRemoveUSDSFromSUSDeLiquidEModeInAavePrimeInstance_20241224.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x2be035a75fb8c5bb4e99e56006e57b7eb7df8bdd5616d903309ef6fc5b7446de)
- [Discussion](https://governance.aave.com/t/arfc-proposal-to-remove-usds-from-susde-liquid-e-mode-in-aave-prime-instance/20264)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
