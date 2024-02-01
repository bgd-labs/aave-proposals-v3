---
title: "stkABPT Balancer V2 migration"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-abpt-balancer-v2-migration-plan/8381/7#abpt-balancer-v1-v2-migration-update-1"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x33cdbe42706aa449c2e7d55d6c1e81da4bf3f153bb5c1010df71e8ab296fe525"
---

## Simple Summary

Deprecate the `stkABPT` Balancer v1 safety module in favor of a new `AAVE_wstETH_BPT_V2` Balancer v2 safety module.

## Motivation

The ABPT(AAVE/WETH) pool was created in January 2021, so it runs on the Balancer v1 system.
The community decided that an upgrade to Balancer v2 and a yield optimized AAVE/wstETH pool.

## Specification

Therefore this proposal:

- Upgrades the existing `stkABPT` to allow immediate withdrawal without cooldown and disable slashing.
- Stops AAVE reward emission on `stkABPT`.
- Starts AAVE reward emission on the new `stkAAVE_wstETH_BPT_V2`.

## References

- Implementation: [StakeToken](https://github.com/bgd-labs/stake-token/blob/main/src/contracts/StakeToken.sol),[Payload](https://github.com/bgd-labs/abpt-migration/blob/main/src/contracts/ProposalPayload.sol)
- Tests: [StakeToken](https://github.com/bgd-labs/stake-token/tree/main/tests), [Payload](https://github.com/bgd-labs/abpt-migration/tree/main/tests)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x33cdbe42706aa449c2e7d55d6c1e81da4bf3f153bb5c1010df71e8ab296fe525)
- [Discussion](https://governance.aave.com/t/bgd-abpt-balancer-v2-migration-plan/8381/7#abpt-balancer-v1-v2-migration-update-1)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
