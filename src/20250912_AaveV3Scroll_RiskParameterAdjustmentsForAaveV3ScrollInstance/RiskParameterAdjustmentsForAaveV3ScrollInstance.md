---
title: "Risk Parameter Adjustments for Aave V3 Scroll Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-risk-parameter-adjustments-for-aave-v3-scroll-instance/23113"
---

## Simple Summary

This Direct to AIP proposes immediate risk parameter adjustments for all assets on the Aave V3 Scroll instance to mitigate potential risks arising from ongoing governance instability within the Scroll ecosystem. The proposal seeks to increase Reserve Factors (RF) across all assets.

## Motivation

Recent governance developments within the Scroll ecosystem have introduced material uncertainty and potential risks that warrant immediate protocol protection measures. As a responsible risk management action, these adjustments aim to:

- **Reduce Exposure**: Lower caps will limit the protocol’s total exposure to Scroll-based assets
- **Maintain Protocol Safety**: Conservative parameters ensure protocol resilience during governance instability
- **Enable Swift Response**: Direct to AIP process allows for rapid implementation of necessary risk controls

## Specification

- **Reserve Factor Updates**: Increase RF for all listed assets to 50%.

| Asset  | Chain  | Current Reserve Factor | Recommended Reserve Factor |
| ------ | ------ | ---------------------- | -------------------------- |
| WETH   | Scroll | 15%                    | 50%                        |
| weETH  | Scroll | 45%                    | 50%                        |
| wstETH | Scroll | 5%                     | 50%                        |
| USDC   | Scroll | 10%                    | 50%                        |
| SCR    | Scroll | 20%                    | 50%                        |

The other changes mentionned in the original forum post will be handled separately via risk steward.

## References

- Implementation: [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/4bdc4d609596e471926d0582f611fb22582e0b40/src/20250912_AaveV3Scroll_RiskParameterAdjustmentsForAaveV3ScrollInstance/AaveV3Scroll_RiskParameterAdjustmentsForAaveV3ScrollInstance_20250912.sol)
- Tests: [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/4bdc4d609596e471926d0582f611fb22582e0b40/src/20250912_AaveV3Scroll_RiskParameterAdjustmentsForAaveV3ScrollInstance/AaveV3Scroll_RiskParameterAdjustmentsForAaveV3ScrollInstance_20250912.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-risk-parameter-adjustments-for-aave-v3-scroll-instance/23113)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
