---
title: "Treasury Management - Add to rETH Holding (resubmission)"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-treasury-management-add-to-reth-holding/15123"
---

## Simple Summary

This AIP will convert all wETH held in the DAO’s Ethereum Treasury to rETH.

## Motivation

This AIP proposes using all available wETH to acquire rETH. The rETH yield, currently at 3.07%, surpasses the ETH deposit yield on Aave v3.

This action will yield two significant advantages for the DAO. First, it will enable the DAO to earn a higher return on its ETH assets, thus improving the value of its holdings. Second, by promoting greater diversity in the nodes supporting the network, this move contributes to the overall health and sustainability of the Ethereum network.

A balance of 100 aEthWETH tokens will be retained in the Treasury. These tokens will serve as a reserve for covering ongoing DAO expenses, including initiatives like the [Quarterly Gas Rebate](https://governance.aave.com/t/arfc-quarterly-gas-rebate-distribution-august-2023/14680), and any other potential expenses that may arise in the future.

## Specification

The previous attempt of this AIP performed the following:

- Withdraw all awETH to wETH
- Withdraw all but 100 aEthWETH to wETH

This AIP will perform the following:

- Swap all wETH into RocketPool’s rETH

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/03c12c707428902d1369b0baab9c2a1b712f3e09/src/20231123_AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission/AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/03c12c707428902d1369b0baab9c2a1b712f3e09/src/20231123_AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission/AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x80493cdca3b1893e198802cd245e6e3c00f5fcd0b37c09aa41765b17419a71fe)
- [Discussion](https://governance.aave.com/t/arfc-treasury-management-add-to-reth-holding/15123)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
