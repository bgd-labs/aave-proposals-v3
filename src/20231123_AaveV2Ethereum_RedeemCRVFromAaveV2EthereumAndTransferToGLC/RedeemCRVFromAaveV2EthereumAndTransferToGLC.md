---
title: "Transfer all CRV positions from Ethereum Mainnet Collector to GLC Safe"
author: "TokenLogic & karpatkey"
discussions: "https://governance.aave.com/t/arfc-deploy-acrv-crv-to-vecrv/11628"
---

## Simple Summary

Transfer all available CRV from Aave Mainnet Treasury to GHO Liquidity Committee (GLC) SAFE where it will be deployed to sdCRV.

## Motivation

Upon implementation of this AIP, CRV will be withdrawn from Aave Protocol on Ethereum Mainnet (both V2 and V3) and all newly available CRV transferred to the GLC SAFE.

- [aEthCRV](https://etherscan.io/token/0x7b95ec873268a6bfc6427e7a28e396db9d0ebc65?a=0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c) - 30,153.23 units at time of writing
- [aCRV](https://etherscan.io/token/0x8dae6cb04688c62d939ed9b68d32bc62e49970b1?a=0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c) - 6,052,066.53 units at time of writing
- [CRV](https://etherscan.io/token/0xD533a949740bb3306d119CC777fa900bA034cd52?a=0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c) - 29,247.71 units

Total ~6,111,467.47 units of CRV

The GLC is expected to mint and stake sdCRV with the CRV. At the time of writing, staked sdCRV is generating between 20.35% and 41.85% APR.

The GLC is then expected to manage the sdCRV holdings to the benefit of the DAO with the primary focus of supporting GHO liquidity. The GLC is expected to make use of the vote-boosted sdCRV offering by StakeDAO. Details on vote-boosted sdCRV can be found [here](https://stakedaohq.medium.com/introducing-the-boosted-vote-strategy-the-best-way-to-get-boosted-voting-power-on-your-crv-22fc7ed52088).

## Specification

This proposal encompasses the following actions:

- Transfer aEthCRV (Aave V3) & aCRV (AaveV2) from Collector to Proposal Payload contract
- Withdraw aEthCRV (Aave V3) & aCRV (Aave V2) from Ethereum Mainnet on the Proposal Payload contract to GLC SAFE
- Transfer existing CRV position on Ethereum Mainnet to GLC SAFE

GLC SAFE Address: [`0x205e795336610f5131Be52F09218AF19f0f3eC60`](https://etherscan.io/address/0x205e795336610f5131Be52F09218AF19f0f3eC60)

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/3e50661ad7dbfe4b60591f75feea7d84b57a0109/src/20231123_AaveV2Ethereum_RedeemCRVFromAaveV2EthereumAndTransferToGLC/AaveV2Ethereum_RedeemCRVFromAaveV2EthereumAndTransferToGLC_20231123.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/3e50661ad7dbfe4b60591f75feea7d84b57a0109/src/20231123_AaveV2Ethereum_RedeemCRVFromAaveV2EthereumAndTransferToGLC/AaveV2Ethereum_RedeemCRVFromAaveV2EthereumAndTransferToGLC_20231123.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xf92c5647c7f60a4a3db994b4953fc4408f5946cafdc0cebcd4c5924f40e04d36)
- [Discussion](https://governance.aave.com/t/arfc-deploy-acrv-crv-to-vecrv/11628)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
