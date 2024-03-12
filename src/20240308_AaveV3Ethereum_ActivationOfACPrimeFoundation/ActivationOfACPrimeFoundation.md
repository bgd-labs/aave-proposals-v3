---
title: "Activation of A-C Prime Foundation"
author: "@Khan"
discussions: "https://governance.aave.com/t/arfc-aave-treasury-rwa-allocation/14790"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x71db494e4b49e7533c5ccaa566686b2d045b0761cb3296a2d77af4b500566eb0"
---

## Simple Summary

Following [AIP-331](https://governance-v2.aave.com/governance/proposal/331/) giving mandate to Centrifuge to create a Association to represent the Aave DAO off-chain, this AIP proposes the activation of the A-C Prime Foundation.

## Motivation

The A-C Prime Foundation is a Cayman island foundation company created by Centrifuge on behalf of the Aave DAO. It is the legal entity that will represent the Aave DAO off-chain. It will be the entity that will be able to sign contracts, hold assets, and enter into agreements on behalf of the Aave DAO.

This AIP proposes the activation of the A-C Prime Foundation. and the pre-approval of a investment in the Anemoy Liquid Treasury Fund 1 with an initial investment of the equivalent of $1m in shares.

## Specification

This AIP does not require any on-chain changes. It is a proposal to activate the A-C Prime Foundation.

To explicitly convey the Aave DAO approval via its governance, an event is created on-chain casting the following message:

    ```
    'The Aave DAO approves and ratify the following documents :

    the articles of Association : https://centrifuge.mypinata.cloud/ipfs/QmSn1Jx4PCPCvJDwx5JHqAcrCYFtCdVGtXc2Dcmk8NFauM

    The Memorandum Of association : https://centrifuge.mypinata.cloud/ipfs/QmeNnARf9CqLQ9krQn8b4UCnBaWhUhLryEBqrVqW9cuTjV'

    ```

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/ea76865ffbaccf08920bace6268571076e1ce06b/src/20240308_AaveV3Ethereum_ActivationOfACPrimeFoundation/AaveV3Ethereum_ActivationOfACPrimeFoundation_20240308.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/ea76865ffbaccf08920bace6268571076e1ce06b/src/20240308_AaveV3Ethereum_ActivationOfACPrimeFoundation/AaveV3Ethereum_ActivationOfACPrimeFoundation_20240308.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x71db494e4b49e7533c5ccaa566686b2d045b0761cb3296a2d77af4b500566eb0)
- [Discussion](https://governance.aave.com/t/arfc-aave-treasury-rwa-allocation/14790)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
