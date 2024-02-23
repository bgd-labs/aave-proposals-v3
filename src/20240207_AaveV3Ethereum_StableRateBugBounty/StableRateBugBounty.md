---
title: "Stable Rate Bug Bounty"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-full-deprecation-of-stable-rate/16473"
---

## Simple Summary

Bug bounty payment for the [report received on 4th November 2023](https://governance.aave.com/t/aave-v2-v3-security-incident-04-11-2023/15335) amounting a grant total of ~1'000'000 for the white hat splitted in stable-coins and AAVE, together with the $100'000 Immunefi fee (10% of the total).

## Motivation

On the 4th of November 2023, a report was received via the Aave <> Immunefi bug bounty program about a critical bug related to the stable borrow rate.

Similar to any other valid bug reports, a bounty needs to be paid to the white-hat. However, being a critical severity one, we think it is reasonable to have an ad-hoc governance proposal for this type of sizeable payment.

## Specification

The governance proposal executes the payment to 2 different recipients:

-> **White-hat**

- Transfer of 500'000 aUSDT v2 Ethereum from the Aave Ethereum Collector.
- Transfer of 5'583 AAVE (calculated to be $500'000 using a 30-days average) from the Aave Ecosystem Reserve. The amount has been determined following the recommendation of the financial service providers of the DAO [HERE](https://governance.aave.com/t/bgd-full-deprecation-of-stable-rate/16473/8).

-> **Immunefi**

- Transfer of 100'000 aUSDT v2 Ethereum from the Aave Ethereum Collector.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240207_AaveV3Ethereum_StableRateBugBounty/AaveV3Ethereum_StableRateBugBounty_20240207.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240207_AaveV3Ethereum_StableRateBugBounty/AaveV3Ethereum_StableRateBugBounty_20240207.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-full-deprecation-of-stable-rate/16473)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
