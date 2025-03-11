---
title: "Clinic steward activation"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-bgd-aave-clinicsteward/21209"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0xee0249fea0fecbeb2d2cab90ae3e6d9c5e21d5456417048c49aea9f48f970afe"
---

## Simple Summary

Enabling a new Aave `ClinicSteward` smart contract, with capabilities to liquidate and repay non-healthy positions.
The contract will utilize Aave Collector funds for the repayment.

## Motivation

Since the initial Aave v3 activation three years ago, due to the nature of liquidations, the system has accrued a minimal bad debt of approximately $400’000.

This amount is pretty irrelevant in comparison with the ~$12 billion outstanding borrowings, but given the imminent activation of the Umbrella system (to automatically cover bad debt), and the recent upgrade of Aave to v3.3 (formally accounting for deficit/bad-debt post-liquidation), we believe it is appropriate to raise a proposal to clean the “legacy” bad debt, and this way start with clean accounting.

The Aave ClinicSteward is a smart contract that simply facilitates for a permissioned entity to execute the clean-up on behalf of the DAO, by authorizing a constraint budget from the Aave Collector for exclusive usage on liquidations/repayments of unhealthy positions (liquidatable).

## Specification

The Stewards were deployed with the following configuration:

- the `governance executor lvl1` was granted the `DEFAULT_ADMIN` role on each network
- a multisig with 2/3 multisig with `ACI/TokenLogic/Karpatkey` as signers was granted the `CLEANUP_ROLE` admin

The proposal:

- grants the `ClinicSteward` the `FUNDS_ADMIN` role in the Aave DAO.
- grants an EOA/Bot controlled by ACI the `CLEANUP_ROLE` to cleanup debt on behalf of the Aave DAO.

The stewards themselves implement a $ cap, which is pre-configured to the following amounts:

- Ethereum core $30’000
- Ethereum prime $5’000
- Polygon $30’000
- Avalanche $350’000
- Arbitrum $60’000
- Optimism $5’000
- Base $15’000
- Metis $1’000
- Gnosis Chain $1’000
- BNB Chain $2’000
- Scroll $1’000
- ZKSync $1’000
- Linea $1’000

## References

- [Implementation](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250228_Multi_ClinicStewardActivation/ActivationPayload_20250228.sol)
- [Test](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250228_Multi_ClinicStewardActivation/ActivationPayload_20250228.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0xee0249fea0fecbeb2d2cab90ae3e6d9c5e21d5456417048c49aea9f48f970afe)
- [Discussion](https://governance.aave.com/t/arfc-bgd-aave-clinicsteward/21209)
- [Steward Code](https://github.com/bgd-labs/aave-stewards/tree/4a1bfd93330043c455b239b9824b73c664e65e01/src/maintenance/ClinicSteward.sol)
- [Audit](https://github.com/bgd-labs/aave-stewards/blob/4a1bfd93330043c455b239b9824b73c664e65e01/audits/2025_02_17_ClinicSteward_Certora.pdf)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
