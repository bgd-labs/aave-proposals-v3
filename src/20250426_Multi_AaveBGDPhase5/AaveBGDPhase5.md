---
title: "Aave BGD Phase 5"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-aave-bored-ghosts-developing-phase-5/21803"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xcad607fa0b4cc00eb09d8af5a6506d64b74a0713b4261014ca3f23fa8afe4c07"
---

## Simple Summary

Proposal for an engagement of development and security services between the Aave DAO and BGD Labs, from 1st April 2025 until 1st October 2025.

## Motivation

For the last three years, BGD Labs has been a service provider of the Aave DAO, contributing with multiple developments, technical maintenance, and security coordination tasks.

The motivation/goal of this new engagement is same as the previous Phase 4:

- Keep the stability and trust in the Aave technology.
- Innovate responsibly on production systems.
- Support all other non-tech contributors to the DAO, accelerating progress.

In summary, the same as before, but always striving for better.

## Specification

A full description of the scope can be found on the Aave Governance Forum [HERE](https://governance.aave.com/t/arfc-aave-bored-ghosts-developing-phase-5/21803) or on the pre-approval on ARFC (Aave Request For Comments) [HERE](https://snapshot.box/#/s:aavedao.eth/proposal/0xcad607fa0b4cc00eb09d8af5a6506d64b74a0713b4261014ca3f23fa8afe4c07).

In terms of implementation, this proposal sets up the payment schedule defined:

- From the Aave DAO's treasury (Collector smart contract), an upfront transfer for a value of 1'150'000 aUSDT (v3 Ethereum), 50% of the stablecoins budget.
- From the Aave DAO AAVE Ecosystem Reserve, an upfront transfer for a value of 2'000 AAVE tokens, 50% of the tokens budget.
- From the Aave DAO's treasury, the creation of a payment stream for a value of 1'150'000 aGHO Prime (v3 Ethereum Prime), from the execution time of this proposal until 1st October 2025 (from proposal execution), completing the 6-month duration, for the other 50% of the stablecoins budget.
- From the Aave DAO AAVE Ecosystem Reserve, the creation of a payment stream for a value of 2'000 AAVE tokens, from the execution time of this proposal until 1st October 2025 (from proposal execution), completing the 6-month duration, for the other 50% of the tokens budget.

**The approval of this proposal by Aave governance acts as a binding agreement between the Aave DAO and BGD Labs**. Detailed terms of service can be found [HERE](https://bgdlabs.com/aave-dao-tos-phase5).

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/e0cf6f266ca0389ca104aafdd9715b2a3803a9eb/src/20250426_Multi_AaveBGDPhase5/AaveV3Ethereum_AaveBGDPhase5_20250426.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/e0cf6f266ca0389ca104aafdd9715b2a3803a9eb/src/20250426_Multi_AaveBGDPhase5/AaveV3EthereumLido_AaveBGDPhase5_20250426.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/e0cf6f266ca0389ca104aafdd9715b2a3803a9eb/src/20250426_Multi_AaveBGDPhase5/AaveV3Ethereum_AaveBGDPhase5_20250426.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/e0cf6f266ca0389ca104aafdd9715b2a3803a9eb/src/20250426_Multi_AaveBGDPhase5/AaveV3EthereumLido_AaveBGDPhase5_20250426.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xcad607fa0b4cc00eb09d8af5a6506d64b74a0713b4261014ca3f23fa8afe4c07)
- [Discussion](https://governance.aave.com/t/arfc-aave-bored-ghosts-developing-phase-5/21803)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
