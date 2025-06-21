---
title: "Aave V3 Aptos Activation"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-aave-v3-deployment-on-aptos-mainnet/21823"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x7da9509685cb547a0af6582a110697a40d6056bff566670cc487441cd4c380cd"
---

# Summary

This proposal seeks to formally approve the already-deployed Aave V3 Aptos Market under the Aave DAO, marking Aave’s first expansion into a non-EVM blockchain. Bringing the Aptos market under DAO will leverage Aptos’s high throughput, low transaction fees, and the Move programming language’s security features to enhance Aave’s protocol performance and broaden its user base.

# Motivation

- **Expansion**: Expanding into the Aptos ecosystem allows Aave to grow its presence beyond EVM-compatible chains.
- **Technical Advantages**: Aptos offers high transaction throughput and enhanced security through the Move language.
- **Ecosystem Growth**: Aptos has demonstrated significant growth, with a TVL of approximately $958.64 million, making it the 11th largest chain by TVL.

All previous governance procedures for the expansion of Aave V3 to Aptos have been completed, including:

- Positive signaling and approval regarding the expansion on the Aave governance forum as a [Temp Check](https://governance.aave.com/t/temp-check-aave-v3-deployment-on-aptos-mainnet/18124/17), [Temp Check Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x3ab72b46e2039d255c8df47e3210e40a7df5e7d4e079096439a018e28a38a17e), [ARFC](https://governance.aave.com/t/arfc-aave-v3-deployment-on-aptos-mainnet/21823) and [ARFC snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x7da9509685cb547a0af6582a110697a40d6056bff566670cc487441cd4c380cd).
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

Given the novel nature of this deployment as Aave's first expansion to a non-EVM chain, the Aptos mainnet launch will initially operate in a restricted Capture the Flag (CTF) phase lasting approximately 4 to 6 weeks. During this period, a maximum of $25,000 per supported asset (agreed upon with Risk Providers) will be supplied by the deployment team, no room for user assets will be left. This controlled environment is designed to observe protocol behavior, validate assumptions, and facilitate further security review. Following the successful completion of this phase, the protocol will transition into an open bug bounty period that will be defined after the completion of the CTF phase. Caps will be increased to accommodate user deposits, and will be progressively raised in phases. These adjustments will be made in close coordination with Chaos Labs and LlamaRisk, aligning with their risk parameter recommendations.

## Current Stewardship (CTF phase)

| Role                                                                                     | Steward                                        | Signers and threshold         |
| :--------------------------------------------------------------------------------------- | :--------------------------------------------- | :---------------------------- |
| PoolAdmin, EmergencyAdmin, RiskAdmin, AssetListingAdmin, EmissionAdmin, FundsAdmin, etc. | Launch Steward (Aave Labs \+ Aptos Foundation) | 4-of-7 signers from both orgs |

## Oracle Integration

- **Primary Source**: Chainlink Data Feeds on Aptos.

## User Interface and Documentation

The following links provide access to the Aptos deployment interface and official docs for validation and exploration.

- **Interface:** [https://aptos.aave.com/](https://aptos.aave.com/)
- **Documentation:** [https://docs-aave-git-crest-avaraxyz.vercel.app/docs](https://docs-aave-git-crest-avaraxyz.vercel.app/docs)

## Security Measures

- **Audits**: Smart contracts have undergone comprehensive audits by [Certora](https://github.com/aave/aptos-aave-v3/tree/main/audits) and [SpearBit](https://github.com/aave/aptos-aave-v3/tree/main/audits), and an audit by OtterSec is currently underway.
- **Security Competition**: We ran a $150,000 GHO initiative aimed at motivating participants to uncover and report possible security flaws.
- **Capture The Flag:** During the 6 weeks we will run a CTF campaign to uncover potential vulnerabilities.
- **Bug Bounty Program**: A bug bounty program will be determined to incentivize the identification of potential vulnerabilities once the CTF phase is done.

## Governance Strategy

- **Launch Steward**: Aave Labs and Aptos Foundation will maintain initial stewardship over the deployment to ensure stability.
- **Transition and ongoing Governance:**
  - Hand all ACL roles to the Aave Community Guardian.
  - Research, implement, audit and deploy Aave Governance V3 cross-chain executor.
  - All ACL roles will move from the Community Guardian to DAO executors, except for the EmergencyAdmin role.
  - All parameter or contract-level changes **must** follow the [**standard Aave Governance Framework**](https://aave.com/docs/primitives/governance) or the [**Direct-to-AIP Framework**](https://governance.aave.com/t/arfc-direct-to-aip-framework/13913)**.**
    - The Direct-to-AIP Framework allows the following protocol actions: freezing reserve on all pools on any protocol version, updating caps on all pools on V3 markets, and defining a new emission manager, on any token, on any market.
    - For any other action, the standard Aave Governance Framework will apply.

## Transition Roadmap

| Phase                                 | Gate / Trigger                                                                                          | Who executes changes?   | Oversight & Process                                                                                                                                                        |
| :------------------------------------ | :------------------------------------------------------------------------------------------------------ | :---------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 0\. CTF                               | AIP vote passes → Vote \+ 4-6 weeks                                                                     | Launch Steward          | Any tweak (pause, cap down, etc.) will go either through the standard Aave Governance Framework or Direct-to-AIP Framework and then it will be executed via Launch Steward |
| 1\. Gradual cap-lifts                 | End of CTF phase and Chaos Labs & LlamaRisk green-light (estimated up to 6 months)                      | Launch Steward          | Direct-to-AIP Framework                                                                                                                                                    |
| 2\. Aave Community guardian hand-over | Hand all ACL roles to the Aave Community Guardian                                                       | Aave Community Guardian | From this moment until the cross-chain executor is ready, the guardian steward will execute the changes approved by the Aave DAO                                           |
| 3\. Full DAO control (Gov-V3 X-Chain) | Cross-chain executor audited and markets stable (timelines estimation available after initial research) | Gov-v3 bridge           | UpgradeAdmin, RiskAdmin, etc. migrate to DAO executors; guardian downgraded to EmergencyAdmin only                                                                         |

## Service-Provider Involvement

- **Chaos Labs & LlamaRisk** – Working closely with the Launch steward for all cap-lift iterations.
- **ACI** & **TokenLogic** – Incentives strategy and distribution.

# Remaining Steps

1. **Validate and un-freeze reserves**:
   1. Contracts are validated
   2. Launch Steward (Aave Labs \+ Aptos Foundation) will un-freeze the markets and seed $25,000 equivalent of each asset. Timeline: within 24 hours after this AIP passes.
2. **Run the 4-6 weeks CTF campaign phase:**
   1. Monitored by Aave Labs and Aptos Foundation team
   2. CTF campaign with Cantina
   3. Launch Steward handles day-to-day ops and emergency actions
3. **Gradual cap-lifts**:
   1. Working closely with Chaos Labs and LlamaRisk we will start gradually lifting the caps in-line with the initial recommendations in the table above
   2. For all cap-lift iterations, proposals will be drafted and submitted for DAO vote
4. **Governance Transition**: Begin the phased transition of full governance to the Aave DAO:
   1. Hand all ACL roles to the Aave Community Guardian steward
   2. Research, implement, audit and deploy Governance V3 cross-chain executor
   3. All ACL roles move from the guardian steward to DAO executors except the EmergencyAdmin
5. **Maintain continuous security**:
   1. Bug Bounty remains active

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/b18f0ad2ab0533b284772040ef901dae567aca72/src/20250613_AaveV3Aptos_AaveV3AptosActivation/AaveV3Ethereum_AaveV3AptosActivation_20250613.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/b18f0ad2ab0533b284772040ef901dae567aca72/src/20250613_AaveV3Aptos_AaveV3AptosActivation/AaveV3Ethereum_AaveV3AptosActivation_20250613.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x7da9509685cb547a0af6582a110697a40d6056bff566670cc487441cd4c380cd)
- [Discussion](https://governance.aave.com/t/arfc-aave-v3-deployment-on-aptos-mainnet/21823)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
