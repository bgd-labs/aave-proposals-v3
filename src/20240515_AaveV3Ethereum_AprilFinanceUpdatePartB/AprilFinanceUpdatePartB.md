---
title: "April Finance Update Part B"
author: "@karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-april-finance-update/17390"
---

## Simple Summary

This proposal presents April's funding update part B, which is a follow up to the one executed last week, including the following key activities:

- Swap DAI bridged from Polygon on Part A to GHO
- Create allowance for ALC safe of USDC and aEthUSDT
- Deposit underlying balances into Aave V3 Ethereum

## Motivation

This is an ongoing effort to manage the DAO's treasury as can be seen in the April [Update](https://governance.aave.com/t/arfc-april-finance-update/17390)
and GSM funding [update](https://governance.aave.com/t/arfc-fund-usdc-usdt-gsm/17566).

## Specification

- Swap DAI bridged from Polygon on Part A to GHO (~500,000 units)
- Create allowance for ALC safe of USDC for 1,000,000
- Create allowance for ALC safe of aEthUSDT for 1,000,000
- Deposit Collector wETH balance into V3
- Deposit Collector wBTC balance into V3
- Deposit Collector USDC balance (minus ALC approval) into V3

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/1e89d862b2503c3d4cf90b1e258c1e542dcb5c15/src/20240515_AaveV3Ethereum_AprilFinanceUpdatePartB/AaveV3Ethereum_AprilFinanceUpdatePartB_20240515.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/1e89d862b2503c3d4cf90b1e258c1e542dcb5c15/src/20240515_AaveV3Ethereum_AprilFinanceUpdatePartB/AaveV3Ethereum_AprilFinanceUpdatePartB_20240515.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-april-finance-update/17390)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
