---
title: "Adopt The SEAL Safe Harbor Agreement"
author: "SEAL (@_SEAL_Org), BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-adopt-the-seal-safe-harbor-agreement/23059"
---

## Simple Summary

This proposal registers Aave's adoption of the SEAL (Security Alliance) Whitehat Safe Harbor Agreement on-chain. The agreement enables whitehats to legally intervene during active exploits to protect protocol funds, with clear rules for fund recovery, predefined bounties, and legal protections for good-faith actors.

## Motivation

While Aave maintains strong security through audits and preventive measures, the unpredictable nature of exploits requires swift response mechanisms. The Safe Harbor Agreement addresses a critical gap: whitehats often hesitate to intervene during active exploits due to legal uncertainty, even when they could save funds. By providing legal protection and clear operating guidelines, this agreement removes barriers that prevent whitehats from acting in good faith.

Key benefits include:

- **Rapid Response**: Whitehats can intervene immediately during active exploits, minimizing damage without requiring protocol halts
- **Clear Process**: Predetermined recovery addresses and procedures eliminate chaotic negotiations during crises
- **Fair Incentives**: A 10% bounty (capped at $1M) aligns with Aave's existing bug bounty program, incentivizing protection without creating conflicting priorities
- **Legal Clarity**: Provides whitehats with legal protection when acting in good faith, encouraging intervention over inaction
- **Industry Alignment**: Positions Aave at the forefront of DeFi security practices

The agreement complements existing security measures by providing an additional defensive layer specifically for active threat scenarios.

## Specification

The proposal executes a single transaction to register Aave's adoption in the Safe Harbor Registry:

**Transaction Details:**

- **To:** [0x1eaCD100B0546E433fbf4d773109cAD482c34686](https://etherscan.io/address/0x1eaCD100B0546E433fbf4d773109cAD482c34686) (Safe Harbor Registry)
- **Action:** `adoptSafeHarbor(address)`
- **Parameter:** [0x585aFfCCFF9398AfdB12bDfF2E74182437f45aF0](https://etherscan.io/address/0x585aFfCCFF9398AfdB12bDfF2E74182437f45aF0) (Adoption Details Contract)

**Adoption Parameters:**

1. **Asset Recovery Addresses:** Multi-chain collector addresses controlled by Aave (see [ARFC](https://governance.aave.com/t/arfc-adopt-the-seal-safe-harbor-agreement/23059) for complete list across 16 chains)
2. **Scope:** Comprehensive coverage including:
   - All Aave V3 pools (Core and Prime on Ethereum, plus 15 other chains)
   - All pool components (configurators, oracles, adapters, gateways)
   - Governance infrastructure (cross-chain controllers, payload controllers, executors)
   - GHO token infrastructure across multiple chains
   - Umbrella, treasury, and v2 contracts
   - Contact: BGD Labs (aave-security@bgdlabs.com)
3. **Bounty Terms:**
   - Percentage: 10% of recovered funds
   - Cap: $1,000,000 USD per incident
   - Aggregate Cap: $1,000,000 USD
   - Retainable: False (all funds returned to protocol, bounty paid separately from DAO treasury)
   - Identity: Named (full legal name may be required)
   - Diligence: KYC & sanctions screening only when necessary

**Important Notes:**

- Bounty payments come from Aave DAO treasury, not recovered user funds
- Safe Harbor and Bug Bounty rewards are mutually exclusive for the same exploit
- KYC requested sparingly, respecting whitehat anonymity when possible
- Reward denomination at DAO discretion, volatile assets priced using 30-day average from incident date

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251006_AaveV3Ethereum_AdoptTheSEALSafeHarborAgreement/AaveV3Ethereum_AdoptTheSEALSafeHarborAgreement_20251006.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251006_AaveV3Ethereum_AdoptTheSEALSafeHarborAgreement/AaveV3Ethereum_AdoptTheSEALSafeHarborAgreement_20251006.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-adopt-the-seal-safe-harbor-agreement/23059)
- [Safe Harbor Framework](https://frameworks.securityalliance.org/safe-harbor/index.html)
- [Safe Harbor Legal Agreement](https://github.com/security-alliance/safe-harbor/blob/main/documents/agreement.pdf)
- [Safe Harbor Registry](https://etherscan.io/address/0x1eaCD100B0546E433fbf4d773109cAD482c34686)
- [Aave Bug Bounty Program](https://immunefi.com/bug-bounty/aave/information/)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
