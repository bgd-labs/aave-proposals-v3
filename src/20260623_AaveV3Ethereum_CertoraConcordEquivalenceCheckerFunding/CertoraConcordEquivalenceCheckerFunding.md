---
title: "Certora Concord Equivalence Checker Funding"
author: "Certora (implemented by Aave Labs)"
discussions: "https://governance.aave.com/t/arfc-strengthening-upgrade-safety-concord-equivalence-checker-by-certora/24713"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0xcf9ca2d7a9b1ee819b6b76f8dae1cdc7fb507e027f044e90d7937b4b264a42c1"
---

## Simple Summary

We propose that the Aave DAO participate as a founding sponsor in the development of Certora Concord, an open-source equivalence-checking framework designed to formally verify that smart contract upgrades — including compiler upgrades, optimizations, and refactors — preserve protocol behavior.

Aave would contribute $50,000 USD as part of a co-funded ecosystem initiative, alongside other leading protocols, unlocking matching funding from the Ethereum Foundation.

This initiative introduces a new security primitive for Aave:

Formal, machine-checked guarantees that upgrades do not introduce unintended behavioral changes.

## Motivation

Aave is a long-lived, continuously evolving protocol with:

- Frequent upgrades and governance proposals
- Increasing complexity (v4 and multi-chain deployments)
- Strong reliance on safe execution of changes

However, today:

- Even small changes (compiler upgrades, optimizations, refactors) can introduce subtle bugs
- These issues are **difficult or impossible to detect via testing alone**
- Post-audit changes often require **expensive re-audits**

This creates:

- Upgrade risk
- Operational overhead
- Slower innovation cycles

### **Proposed Solution: Certora Concord**

**Certora Concord** is an equivalence-checking framework that:

- Compares two smart contracts at the **bytecode level**
- Proves whether they are **behaviorally equivalent across all possible executions**
- Produces **counterexamples** when differences exist

Unlike testing or fuzzing:

- Concord is **exhaustive**, not probabilistic
- Covers **all inputs and execution paths**
- Verifies **externally observable behavior** (state, calls, events)

#### **In practice**

- Compile the same contract with two compiler versions → prove equivalence
- Compare pre/post upgrade contracts → ensure no unintended behavior changes

This directly addresses core risks in Aave’s lifecycle.

### **Why This Matters for Aave**

#### **1. Safer Upgrades**

Guarantee that:

- Compiler upgrades
- Gas optimizations
- Refactors

**Do not change protocol behavior**

### **2. Reduced Audit Overhead**

- Avoid full re-audits for non-functional changes
- Focus audits only where behavior actually changes

### **3. Governance Confidence**

- Provide stronger guarantees for AIPs
- Reduce the risk of introducing bugs through governance

### **4. Ecosystem Leadership**

Aave becomes:

- A **founding sponsor** of a new verification primitive
- A leader in advancing **formal security standards in DeFi**

### **Scope of Work**

Certora will:

1. Develop **Concord**, integrated with the Certora Prover
2. Provide:
   - CLI tooling
   - GUI interface for equivalence analysis
3. Open-source the tool and documentation
4. Maintain and extend Concord for **at least 18 months**
5. Deliver:
   - Real-world equivalence analyses
   - Documentation and best practices
   - Ecosystem-facing education and content

### **Funding Structure**

This is a **co-funded ecosystem initiative**:

- **4 sponsors (including Aave)**: $50,000 each
- **Total ecosystem funding**: $200,000
- **Ethereum Foundation match**: $200,000
- **Total project funding**: $400,000

Aave’s contribution unlocks:

- Additional funding from the Ethereum Foundation
- Shared development costs across leading protocols

## **Timeline**

- **Initial production-ready version**: 3 months
- **Ongoing development & maintenance**: 15+ months

Deliverables include:

- Tooling
- Documentation
- Case studies
- Continuous improvements

### **Benefits to Aave**

### **Technical Benefits**

- Early access to Concord tooling
- Ability to apply it directly to Aave upgrades
- Reduced upgrade risk and audit overhead

### **Strategic Benefits**

- Recognition as a **Concord Ecosystem Sponsor**
- Visibility in:
  - Technical publications
  - Case studies
  - Ecosystem initiatives

### **Financial Efficiency**

- Leverages Ethereum Foundation matching → **amplified impact per dollar**

## Specification

The proposal requests a one-time payment of $50,000 units of GHO paid to Certora for Concord development.

Certora Receiver: [0x0F11640BF66e2D9352d9c41434A5C6E597c5e4c8](https://etherscan.io/address/0x0f11640bF66E2d9352D9c41434A5C6E597C5E4c8)

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/07e4370099d7210154e31a97556f0c9a7d2fe57f/src/20260623_AaveV3Ethereum_CertoraConcordEquivalenceCheckerFunding/AaveV3Ethereum_CertoraConcordEquivalenceCheckerFunding_20260623.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/07e4370099d7210154e31a97556f0c9a7d2fe57f/src/20260623_AaveV3Ethereum_CertoraConcordEquivalenceCheckerFunding/AaveV3Ethereum_CertoraConcordEquivalenceCheckerFunding_20260623.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0xcf9ca2d7a9b1ee819b6b76f8dae1cdc7fb507e027f044e90d7937b4b264a42c1)
- [Discussion](https://governance.aave.com/t/arfc-strengthening-upgrade-safety-concord-equivalence-checker-by-certora/24713)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
