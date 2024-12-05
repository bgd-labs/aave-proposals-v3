---
title: "Onboard rsETH to Lido Instance"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-add-rseth-to-aave-v3-ethereum/17696/18"
snapshot: TODO
---

## Simple Summary

The current ARFC Addendum seeks to onboard rsETH to Lido Instance. This integration aligns with the recent support for rsETH in Aave Mainnet Instance, as outlined in the ARFC proposal and the AIP that is live.

This will be a Direct to Direct AIP Proposal so we can align with the final AIP and onboarding of rsETH in Mainnet Instance.

## Motivation

With rsETH set to become a reality on Aave v3 Ethereum, integrating it into the Lido Instance offers deeper liquidity, higher composability, and more strategic borrowing opportunities for users. Given the synergy between wstETH and rsETH as liquid staking derivatives (LSDs), enabling eMode will maximize capital efficiency for borrowers while maintaining a conservative risk approach.

## Specification

The table below illustrates the configured risk parameters for **rsETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (rsETH)        |                                     10,000 |
| Borrow Cap (rsETH)        |                                          1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                     0.05 % |
| LT                        |                                      0.1 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                        0 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                       10 % |
| Variable Slope 2          |                                      100 % |
| Uoptimal                  |                                        1 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x47F52B2e43D0386cF161e001835b03Ad49889e3b |

Additionaly [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for rsETH and the corresponding aToken.

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241205_AaveV3EthereumLido_OnboardRsETHToLidoInstance/AaveV3EthereumLido_OnboardRsETHToLidoInstance_20241205.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241205_AaveV3EthereumLido_OnboardRsETHToLidoInstance/AaveV3EthereumLido_OnboardRsETHToLidoInstance_20241205.t.sol)
  [Snapshot](TODO)
- [Discussion](https://governance.aave.com/t/arfc-add-rseth-to-aave-v3-ethereum/17696/18)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).