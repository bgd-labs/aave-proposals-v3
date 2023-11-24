---
title: "Treasury Management - Add to rETH Holding"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-treasury-management-add-to-reth-holding/15123"
---

## Simple Summary

This AIP will convert all but 100 aEthWETH held in the DAO’s Ethereum Treasury to rETH.

## Motivation

This AIP proposes consolidating the DAO's ETH-nominated assets into Aave v3 on the Ethereum network and subsequently acquiring rETH. The rETH yield, currently at 3.07%, surpasses the ETH deposit yield on Aave v3.

This action will yield two significant advantages for the DAO. First, it will enable the DAO to earn a higher return on its ETH assets, thus improving the value of its holdings. Second, by promoting greater diversity in the nodes supporting the network, this move contributes to the overall health and sustainability of the Ethereum network.

A balance of 100 aEthWETH tokens will be retained in the Treasury. These tokens will serve as a reserve for covering ongoing DAO expenses, including initiatives like the [Quarterly Gas Rebate](https://governance.aave.com/t/arfc-quarterly-gas-rebate-distribution-august-2023/14680), and any other potential expenses that may arise in the future.

## Specification

This AIP will perform the following:

- Withdraw all awETH to wETH
- Withdraw all but 100 aEthWETH to wETH
- Swap all wETH into RocketPool’s rETH

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f9c4f1f97f88982fb5dbf895fa6762503b1bf7fa/src/20231103_AaveV3Ethereum_TreasuryManagementAddToRETHHolding/AaveV3Ethereum_TreasuryManagementAddToRETHHolding_20231103.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f9c4f1f97f88982fb5dbf895fa6762503b1bf7fa/src/20231103_AaveV3Ethereum_TreasuryManagementAddToRETHHolding/AaveV3Ethereum_TreasuryManagementAddToRETHHolding_20231103.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x80493cdca3b1893e198802cd245e6e3c00f5fcd0b37c09aa41765b17419a71fe)
- [Discussion](https://governance.aave.com/t/arfc-treasury-management-add-to-reth-holding/15123)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
