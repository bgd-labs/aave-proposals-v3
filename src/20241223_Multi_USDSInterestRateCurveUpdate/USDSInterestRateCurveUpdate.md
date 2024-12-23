---
title: "USDS Interest Rate Curve Update"
author: "ChaosLabs"
discussions: "https://governance.aave.com/t/arfc-usds-interest-rate-curve-update/20243"
---

## Simple Summary

Following our previous stablecoin IR recommendation, Chaos Labs recommends adjustments to USDS’s interest rate curves on the Prime and Core deployments.

## Motivation

As noted in our previous stablecoin IR [recommendation](https://www.notion.so/USDS-IR-Update-15e57ab37ebf80bdb091e3d65ca16bff?pvs=21), we did not provide updates to USDS’s interest rate curves because there was a concurrent [AIP](https://vote.onaave.com/proposal/?proposalId=209&ipfsHash=0x1a9acbab30d3c9c381e899fb79433cf8bdb996bddb514b195baa32a085a84809) that proposed adjusting its IR curves. This AIP has since passed and been implemented, allowing us to recommend further adjustments.

We have observed frequent spikes above UOptimal for USDS on the Core instance, with rates briefly exceeding 100% in December. Rates on the Prime deployment have been more stable as a result of limited sUSDe growth in this deployment. As shown below, the spikes in the Core instance have continued after the passage of the AIP and the associated IR change.

The frequent spikes have coincided with a decrease in borrows, as a result of large market outflows. To optimally price the asset, and to set USDS in line with other stablecoins, we recommend increasing the target borrow rate at UOptimal, which will also reduce the time spent above UOptimal. Specifically, we recommend targeting 12.5% at UOptimal and a Slope2 of 35% for both USDS markets, noting that this is aligned with the target rate for all other major stablecoin markets.

## Specification

| Chain    | Market | **Asset** | Current Base Rate | **Current Slope1** | **Current Slope2** | Recommended Base Rate | **Recommended Slope1** | **Recommended Slope2** |
| -------- | ------ | --------- | ----------------- | ------------------ | ------------------ | --------------------- | ---------------------- | ---------------------- |
| Ethereum | Core   | USDS      | 9.25%             | 0.75%              | 75%                | 11.75%                | -                      | 35%                    |
| Ethereum | Prime  | USDS      | 0.75%             | 9.25%              | 75%                | -                     | 11.75%                 | 35%                    |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_USDSInterestRateCurveUpdate/AaveV3Ethereum_USDSInterestRateCurveUpdate_20241223.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_USDSInterestRateCurveUpdate/AaveV3EthereumLido_USDSInterestRateCurveUpdate_20241223.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_USDSInterestRateCurveUpdate/AaveV3Ethereum_USDSInterestRateCurveUpdate_20241223.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241223_Multi_USDSInterestRateCurveUpdate/AaveV3EthereumLido_USDSInterestRateCurveUpdate_20241223.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-usds-interest-rate-curve-update/20243)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
