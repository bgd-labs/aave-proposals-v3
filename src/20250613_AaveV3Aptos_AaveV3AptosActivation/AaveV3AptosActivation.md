---
title: "AaveV3AptosActivation"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-aave-events-sponsorship-budget-2025/22173"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x12ae50ccd9a4cd8edfead63d773e62ca23ea567a458c442557e0b6193e01bb1d"
---

# Summary

This proposal seeks approval to deploy Aave V3 on the Aptos mainnet, marking Aave's first expansion into a non-EVM blockchain. The deployment aims to leverage Aptos' high throughput, low transaction fees, and the security features of the Move programming language to enhance Aave's protocol performance and broaden its user base.

# Motivation

- **Expansion**: Expanding into the Aptos ecosystem allows Aave to grow its presence beyond EVM-compatible chains.
- **Technical Advantages**: Aptos offers high transaction throughput and enhanced security through the Move language.
- **Ecosystem Growth**: Aptos has demonstrated significant growth, with a TVL of approximately $958.64 million, making it the 11th largest chain by TVL.

All the governance procedures for the expansion of Aave v3 to Bnb have been finished, said:

- Positive signaling and approval regarding the expansion on the [governance forum](https://governance.aave.com/t/temp-check-aave-v3-deployment-on-aptos-mainnet/18124/17?u=aavelabs), [temp check snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x3ab72b46e2039d255c8df47e3210e40a7df5e7d4e079096439a018e28a38a17e), [ARFC](https://governance.aave.com/t/arfc-aave-v3-deployment-on-aptos-mainnet/21823) and [final snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x7da9509685cb547a0af6582a110697a40d6056bff566670cc487441cd4c380cd).
- Positive risk analysis and assets/parameters recommendation by the service providers LlamaRisk and Chaos Labs.

# Specification

## Supported Assets

The initial deployment will support the following native assets:

- **APT**

- **USDC**

- **USDT**

- **sUSDe**

## Risk Parameters

Risk parameters for each asset have been provided by Chaos Labs and LlamaRisk:

# Specification

| Parameter                | Value     | Value            | Value            | Value            |
| :----------------------- | :-------- | :--------------- | :--------------- | :--------------- |
| Asset                    | APT       | USDC             | USDT             | sUSDe            |
| Isolation Mode           | No        | No               | No               | No               |
| Enable Borrow            | Yes       | Yes              | Yes              | Yes              |
| Enable Collateral        | Yes       | Yes              | Yes              | Yes              |
| Loan To Value            | 58%       | 75%              | 75%              | 65%              |
| Liquidation Threshold    | 63%       | 78%              | 78%              | 75%              |
| Liquidation Penalty      | 10%       | 5%               | 5%               | 8.5%             |
| Reserve Factor           | 20%       | 10%              | 10%              | 20%              |
| Liquidation Protocol Fee | 10%       | 10%              | 10%              | 10%              |
| Supply Cap               | 1,000,000 | 25,000,000       | 40,000,000       | 14,000,000       |
| Borrow Cap               | 500,000   | 23,000,000       | 37,000,000       | \-               |
| Debt Ceiling             | \-        | \-               | \-               | \-               |
| UOptimal                 | 45%       | 90%              | 90%              | \-               |
| Base                     | 0%        | 0%               | 0%               | \-               |
| Slope1                   | 7%        | 6%               | 6%               | \-               |
| Slope2                   | 300%      | 40%              | 40%              | \-               |
| Stable Borrowing         | No        | No               | No               | No               |
| Flashloanable            | Yes       | Yes              | Yes              | Yes              |
| Siloed Borrowing         | No        | No               | No               | No               |
| Borrowable in Isolation  | No        | Yes              | Yes              | No               |
| E-Mode Category          | N/A       | sUSDe/Stablecoin | sUSDe/Stablecoin | sUSDe/Stablecoin |

## sUSDe/Stablecoin

| Asset             | sUSDe  | USDC | USDT |
| :---------------- | :----- | :--- | :--- |
| Collateral        | Yes    | No   | No   |
| Borrowable        | No     | Yes  | Yes  |
| LTV               | 90.00% | \-   | \-   |
| LT                | 92.00% | \-   | \-   |
| Liquidation Bonus | 4.00%  | \-   | \-   |

## Initial Deployment Safeguards

Given the novel nature of this deployment as Aave's first expansion to a non-EVM chain, the Aptos mainnet launch will initially operate in a restricted “honeypot” phase lasting approximately 4 to 6 weeks. During this period, a maximum of $25,000 per supported asset will be supplied by the deployment team, and user deposits will be disabled. This controlled environment is designed to observe protocol behavior, validate assumptions, and facilitate further security review. Following the successful completion of this phase, the protocol will transition into an open bug bounty period. User deposits will be enabled, and asset caps will be progressively raised in phases. These adjustments will be made in close coordination with Chaos Labs and LlamaRisk, aligning with their risk parameter recommendations.

## Oracle Integration

- **Primary Source**: Chainlink Data Feeds on Aptos.

## Security Measures

- **Audits**: Smart contracts have undergone comprehensive audits by SpearBit, Certora, and OtterSec.
- **Security Competition**: We ran a $150,000 GHO initiative aimed at motivating participants to uncover and report possible security flaws.
- **Bug Bounty Program**:A bug bounty program is in place to incentivize the identification of potential vulnerabilities.

## Governance Strategy

- **Initial Stewardship**: Aave Labs and Aptos Foundation will maintain initial stewardship over the deployment to ensure stability.
- **Transition Plan**: A phased approach will transition full governance to the Aave DAO, incorporating community guardians and aligning with existing governance structures.

# Implementation Plan

1. **Deployment**: Deploy Aave V3 smart contracts on the Aptos mainnet.
2. **Oracle Integration**: Integrate Chainlink data feeds for price oracles.  
   **Parameter Configuration**: Set initial risk parameters as per recommendations from Chaos Labs and LlamaRisk.
3. **Security Measures**: Implement circuit breakers and other safety modules.
4. **Governance Transition**: Begin the phased transition of full governance to the Aave DAO.
