---
title: "Renew LlamaRisk as Risk Service Provider - Epoch 4"
author: "LlamaRisk"
discussions: "https://governance.aave.com/t/arfc-renew-llamarisk-as-risk-service-provider-epoch-4/24446"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x139144f55e87579003f5f9ed53fc4b87bd0c7312fc9c356e5e4e164baa3f8077"
---

## Simple Summary

This AIP renews LlamaRisk as a Risk Service Provider for Aave for one year.

Aave’s risk layer recently lost critical infrastructure operated by a departing risk provider, including automated risk-oracle infrastructure, parameter automation pipelines, and Risk Steward coverage. LlamaRisk stepped in with Aave Labs to assume control of the Risk Steward and maintain operational continuity across Aave markets.

The immediate issue is continuity.

The structural issue is ensuring Aave does not depend on risk infrastructure the DAO cannot inspect, verify, or replace without disruption.

This renewal expands LlamaRisk’s scope across Aave V3, Aave V4, and Horizon, with a focus on protocol-owned risk infrastructure built on Chainlink CRE. This moves Aave’s risk layer toward infrastructure owned and controlled by the DAO, with off-chain logic independently verifiable through cryptographic workflow IDs.

LlamaRisk will deliver:

- Protocol-owned risk infrastructure on Chainlink CRE.
- Risk-managed price feeds for Pendle PTs, CAPO assets, USDe, RWA NAV, and related integrations.
- Dynamic parameter automation for supply caps, borrow caps, interest rates, Umbrella calibration, credit lines, risk premiums, and liquidation configuration.
- Safety mechanisms including freeze guardians and V4 per-Spoke circuit breakers.
- Risk Steward co-ownership and operational accountability.
- AIP and governance payload review.
- Guardian signer duties.
- Monitoring, dashboards, escalation playbooks, and incident response support.
- Continued Horizon cooperation and LlamaGuard NAV expansion.
- R&D for V4-native risk systems, including RWA liquidation infrastructure and instant settlement infrastructure.
- Legal and regulatory research covering stablecoins, custody, counterparty risk, DeFi lending compliance, and tokenized RWA structuring.

LlamaRisk is currently a team of 16 contributors and expects to scale to 20+ contributors during this engagement. LlamaRisk also proposes to phase out remaining non-Aave work over six months and become Aave-exclusive by the midpoint of the engagement.

The approved compensation structure is:

| Component        |        Amount | Payment Method              |
| ---------------- | ------------: | --------------------------- |
| Upfront payment  | 1,500,000 GHO | Immediate payment           |
| Streamed payment | 1,500,000 GHO | Linear stream over one year |
| Streamed payment |    5,000 AAVE | Linear stream over one year |

The current GHO stream with ID `100071` will be terminated.

## Motivation

This proposal renews LlamaRisk as a Risk Service Provider for Aave following DAO discussion and Snapshot approval.

LlamaRisk’s role has expanded beyond its original mandate and now covers risk work across Aave V3, Aave V4, Horizon, governance review, market monitoring, Guardian signer duties, and protocol-owned risk infrastructure.

The renewal also addresses a near-term continuity need. With a departing risk provider no longer covering critical risk infrastructure and operational processes, the DAO needs to maintain coverage across active markets while reducing reliance on closed systems that are difficult for the DAO to inspect, verify, or replace.

Under this engagement, LlamaRisk will continue supporting Aave risk operations and contribute to protocol-owned risk infrastructure, including Chainlink CRE-based risk oracles, dynamic parameter tooling, LlamaGuard expansion, V4-native risk systems, and Horizon-related risk work.

The full scope, rationale, and budget were discussed through the ARFC process and approved by Snapshot. This AIP implements the approved renewal terms.

## Specification

The payload performs the following actions on Ethereum mainnet:

- Cancel the existing GHO stream (ID `100071`) on `AaveV3EthereumLido.COLLECTOR`.
- Transfer `1,500,000 aEthLidoGHO` from `AaveV3EthereumLido.COLLECTOR` to the LlamaRisk-controlled multisig at `0x9eE16dBDE572886342fc1e2Db8525DEFB007b27c`.
- Create a new `aEthLidoGHO` stream of `1,500,000` over `365 days` to the same recipient, via `CollectorUtils.stream()` on `AaveV3EthereumLido.COLLECTOR`.
- Create a new `AAVE` stream of `5,000` over `365 days` to the same recipient, via `AAVE_ECOSYSTEM_RESERVE_CONTROLLER.createStream()` on `MiscEthereum.ECOSYSTEM_RESERVE`. The stream amount is rounded down to the nearest multiple of the duration to avoid revert in the underlying controller.

## References

- Implementation: [AaveV3EthereumLido](https://github.com/aave-dao/aave-proposals-v3/blob/431d25eaf61d370e0781164e7174f32c2d9977b6/src/20260513_AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4/AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513.sol)
- Tests: [AaveV3EthereumLido](https://github.com/aave-dao/aave-proposals-v3/blob/431d25eaf61d370e0781164e7174f32c2d9977b6/src/20260513_AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4/AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513.t.sol)
- Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x139144f55e87579003f5f9ed53fc4b87bd0c7312fc9c356e5e4e164baa3f8077
- [Discussion](https://governance.aave.com/t/arfc-renew-llamarisk-as-risk-service-provider-epoch-4/24446)

## Disclaimer

LlamaRisk receives compensation from the Aave DAO for serving as a Risk Service Provider, as specified in this proposal.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
