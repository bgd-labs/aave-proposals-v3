---
title: "CRVUSD onboarding on Aave V3 Ethereum"
author: "@Marczeller - Aave-chan Initiative"
discussions: "https://governance.aave.com/t/arfc-crvusd-onboarding-on-aave-v3-ethereum-pool/15161"
---

## Simple Summary

This AIP proposes the onboarding of the CRVUSD stablecoin, minted by the Curve Protocol, into the Aave V3 Ethereum pool.

## Motivation

CrvUSD is a USD-peg stablecoin minted by the Curve Protocol. While it's relatively young, it has grown to a circulating supply of over $130M with strong peg resilience. Onboarding this asset into Aave will:

- Reinforce synergies between Aave and Curve.
- Offer Aave users an additional decentralized stablecoin option matching the ACI diversity support ethos.
- Strengthen the relationship between the CRVUSD & the GHO stablecoins.

As the primary usecase for stablecoins is to be deposited by users looking for a passive yield and used as a borrowable asset and not as much as a collateral asset, the ACI proposes a CRVUSD onboarding outside isolation mode but without collateral properties.

Following CrvUSD maturity, the Aave governance can propose a collateral activation for crvUSD at a later stage.

## Specification

Ticker: crvUSD  
Contract address: [0xf939E0A03FB07F59A73314E73794Be0E57ac1b4E](https://etherscan.io/token/0xf939E0A03FB07F59A73314E73794Be0E57ac1b4E)  
Price Feed: [0xEEf0C605546958c1f899b6fB336C20671f9cD49F](https://etherscan.io/address/0xEEf0C605546958c1f899b6fB336C20671f9cD49F)

We propose the following parameters for a crvUSD onboarding:

| Parameter                          | Value    |
| ---------------------------------- | -------- |
| Isolation Mode                     | No       |
| Borrowable                         | Yes      |
| Collateral Enabled                 | No       |
| Supply Cap (CRVUSD)                | 60M      |
| Borrow Cap (CRVUSD)                | 50M      |
| Debt Ceiling                       | N/A      |
| LTV                                | N/A      |
| LT                                 | N/A      |
| Liquidation Bonus                  | N/A      |
| Liquidation Protocol Fee           | 10.00%   |
| Variable Base                      | 0.00%    |
| Variable Slope1                    | 5.00%    |
| Variable Slope2                    | 80.00%   |
| Uoptimal                           | 80.00%   |
| Reserve Factor                     | 10.00%   |
| Stable Borrowing                   | Disabled |
| Stable Slope1                      | 13.00%   |
| Stable Slope2                      | 300.00%  |
| Base Stable Rate Offset            | 3.00%    |
| Stable Rate Excess Offset          | 8.00%    |
| Optimal Stable To Total Debt Ratio | 20.00%   |
| Flashloanable                      | Yes      |
| Siloed Borrowing                   | No       |
| Borrowed in Isolation              | No       |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/1e5d9e78ec397ee3280c75d87e0880104c6df9dd/src/20231116_AaveV3Ethereum_CRVUSDOnboardingOnAaveV3Ethereum/AaveV3Ethereum_CRVUSDOnboardingOnAaveV3Ethereum_20231116.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/1e5d9e78ec397ee3280c75d87e0880104c6df9dd/src/20231116_AaveV3Ethereum_CRVUSDOnboardingOnAaveV3Ethereum/AaveV3Ethereum_CRVUSDOnboardingOnAaveV3Ethereum_20231116.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xbc10b43fccd3954f02c9df774ba6f8335268727b999660738ae37a1b9d5b969e)
- [Discussion](https://governance.aave.com/t/arfc-crvusd-onboarding-on-aave-v3-ethereum-pool/15161)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
