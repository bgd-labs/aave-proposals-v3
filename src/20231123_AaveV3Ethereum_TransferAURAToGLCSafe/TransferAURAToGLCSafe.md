---
title: "Transfer AURA to GLC Safe"
author: "karpatkey - TokenLogic"
discussions: "https://governance.aave.com/t/arfc-treasury-management-transfer-aura-to-glc-safe/15669"
---

# Summary

This AIP will transfer the AURA holdings from the Ethereum Treasury to the GHO Liquidity Committee (GLC) SAFE.

# Motivation

The Aave DAO holds [845,090.43 vlAURA](https://etherscan.io/token/0x3fa73f1e5d8a792c80f426fc8f84fbf7ce9bbcac?a=0x205e795336610f5131Be52F09218AF19f0f3eC60) on the GLC SAFE and also [443,674 AURA](https://etherscan.io/token/0xC0c293ce456fF0ED870ADd98a0828Dd4d2903DBF?a=0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c) on the Treasury (Collector contract).

This AIP will transfer the AURA from the Treasury to the GLC SAFE, consolidating the vlAURA holdings. The Aave DAO is expected to receive ~413,849.57 units of vlAURA upon locking 443,674 AURA.

The GLC is tasked with locking the AURA and managing the vlAURA holdings on behalf of the Aave DAO.

# Specification

This proposal encompasses the following actions:

- Transfer all AURA from the Aave Mainnet Collector to the GLC SAFE Address.

GLC SAFE Address: `0x205e795336610f5131Be52F09218AF19f0f3eC60`

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231123_AaveV3Ethereum_TransferAURAToGLCSafe/AaveV3Ethereum_TransferAURAToGLCSafe_20231123.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231123_AaveV3Ethereum_TransferAURAToGLCSafe/AaveV3Ethereum_TransferAURAToGLCSafe_20231123.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xc999644bf64e4f62722d327416520b6f8cf8d7ceecbb69e7c52e2ebe1f4c3d63)
- [Discussion](https://governance.aave.com/t/arfc-treasury-management-transfer-aura-to-glc-safe/15669)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
