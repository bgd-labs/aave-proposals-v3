---
title: "Deploy 10M GHO into Aave v3 Lido Instance"
author: "karpatkey_TokenLogic & BGD Labs"
discussions: "https://governance.aave.com/t/arfc-mint-deploy-10m-gho-into-aave-v3-lido-instance/19700"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x4af37d6b4a1c9029c7693c4bdfb646931a9815c4a56d9066ac1fbdbef7cd15e5"
---

## Simple Summary

Following the addition of GHO to the Lido instance of Aave v3 on Ethereum, this publication proposes supporting GHO liquidity by minting 10M units of GHO and depositing into Aave Lido.

## Motivation

By providing liquidity on the Lido instance, the Aave DAO shall provide the initial bootstrapping liquidity in a very cost efficient manner and, in doing so, enhance the DAO's revenue generated from the Lido instance. GHO holders will be able to deposit GHO to earn the deposit yield whilst benefit from small than otherwise concentration risk within the reserve due to the DAO providing the bootstrapping liquidity.

With strong demand for GHO using wstETH as collateral resulting in 23.7% of GHO supply sourced from the Main market being backed by wstETH, this demonstrates that users actively seek to benefit from the capital efficiency of using an LST as collateral. Deploying additional GHO into the Lido instance is expected to further encourage this positive behavior, reinforcing the appeal of wstETH as a reliable, yield-bearing collateral for GHO.

## Specification

- Prior to proposal, GhoDirectMinter contract was deployed [here](https://etherscan.io/address/0x2cE01c87Fec1b71A9041c52CaED46Fc5f4807285)
- Grant RISK_ADMIN_ROLE to GhoDirectMinter referenced above
- Add GhoDirectMinter as a GHO token facilitator
- Mint 10M GHO and supply into Aave Lido
- Allow GhoBucketSteward to control GhoDirectMinter

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241229_AaveV3EthereumLido_Deploy10MGHOIntoAaveV3LidoInstance/AaveV3EthereumLido_Deploy10MGHOIntoAaveV3LidoInstance_20241229.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241229_AaveV3EthereumLido_Deploy10MGHOIntoAaveV3LidoInstance/AaveV3EthereumLido_Deploy10MGHOIntoAaveV3LidoInstance_20241229.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x4af37d6b4a1c9029c7693c4bdfb646931a9815c4a56d9066ac1fbdbef7cd15e5)
- [Discussion](https://governance.aave.com/t/arfc-mint-deploy-10m-gho-into-aave-v3-lido-instance/19700)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
