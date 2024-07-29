---
title: "GHO Flash Minter Facilitator Arbitrum"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-gho-flash-minter-facilitator-arbitrum/18445"
snapshot: "TODO"
---

## Simple Summary

This publication proposes deploying a FlashMinter Facilitator on Arbitrum.

## Background

1. **Title of Facilitator**
   Arbitrum FlashMinter Facilitator

2. **High-Level Description of Mechanism/Request**
   FlashMinting provides the same functionality as a flashloan, but instead of borrowing assets from a pool, users would be able to FlashMint GHO and repay in a single transaction.

3. **Author / Link to License**
   @karpatkey_TokenLogic, [MIT License](https://github.com/aave/gho-core/blob/main/LICENSE)

4. **Link to whitepaper**
   NA

5. **How Facilitator Furthers GHO**
   FlashMinting GHO would allow for efficient arbitrage and refinancing. Thus, FlashMinting would play an important role in peg maintenance.

6. **Organization / DAO responsible for operation of the Facilitator**
   The Aave DAO.

7. **History, Details, Background of the operator of the Facilitator**
   The Aave DAO governs the Aave Protocol and consists of a wide variety of contributors, delegates and token holders.

## Credit Line Details

1. **Requested Facilitator Capacity**
   2,000,000 GHO

2. **Use of Funds**
   This Facilitator Capacity would be used to allow users to FlashMint.

3. **Revenue Streams**
   To start, it is proposed that the fee for FlashMint be set at 0%. In the early stages, GHO’s ability to maintain its peg would be enhanced by the presence of low fees, which incentivize arbitrage. However, at the same time, the 0% fee would mean that in the short run, the FlashMint Facilitator would not create revenue for the DAO.

4. **Revenue Split/Interest Terms**
   If the DAO decides to add a fee for this Facilitator, all revenue will go to the Aave DAO Treasury.

5. **Collateral Posted**
   NA

6. **Other Commercial Details/Considerations**
   NA

## Mechanism & Risk Details

1. **Detailed Description of the Facilitator**
   The FlashMinter Facilitator would allow users to FlashMint and borrow GHO if they repay the borrowed GHO in the same transaction. The FlashMinter would positively influence GHO’s ability to maintain its peg by enabling more efficient arbitrage.

2. **How Facilitator is backing GHO**
   Since no GHO is effectively entering circulating supply, no backing is needed.

3. **If RWA - description of legal structure etc**
   N/A

4. **Detail any/all risks (Contract risk, Cross-chain, Bridging, Regulatory, etc)**
   Smart contract risk is always present. To mitigate this risk, the code for this Facilitator has been audited by multiple top auditing firms.

5. **Please include links to supporting docs**
   [GHOFlashMinter Documentation](https://docs.gho.xyz/developer-docs/flashmint-facilitator/GhoFlashMinter)

## Governance Controls

1. **List of controls given to Aave DAO**
   The only controls related to the FlashMinter facilitator are:
   -Changing the FlashMint fee.
   -Changing the Facilitator’s bucket capacity.
   These changes would be made through an Aave DAO Short Executor vote.

2. **Controls given not to Aave DAO**
   N/A

3. **Alternative controls / roles that may be present but not set (optimistic governance? Risk Admin? SubDAO etc) + description on who can set these roles**
   N/A

4. **Upgradability controls**
   N/A

## Specification

The following outlines the parameters for the Arbitrum GHO FlashMinter Facilitator:

| Parameter             |  Value   |
| --------------------- | :------: |
| Facilitatory Capacity | 2M Units |
| FlashMint Fee         |  0.00%   |

A draft PR is located [here](https://github.com/bgd-labs/aave-proposals-v3/pull/401).

## References

- Implementation: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240727_AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum/AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727.sol)
- Tests: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240727_AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum/AaveV3Arbitrum_GHOFlashMinterFacilitatorArbitrum_20240727.t.sol)
- [Snapshot](TODO)
- [Discussion](https://governance.aave.com/t/arfc-gho-flash-minter-facilitator-arbitrum/18445)

# Disclosure

TokenLogic and karpatkey receive no payment for this proposal. TokenLogic and karpatkey are both delegates within the Aave community.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
