---
title: "Set REZ, KERNEL and rsETH Emission Admin to ACI"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/arfc-set-rez-kernel-and-rseth-emission-admin-to-aci/20599"
---

## Simple Summary

This proposal enables ACI to distribute REZ, KERNEL and rsETH rewards across several instances of Aave v3.

## Motivation

The Kelp team proposes distributing rsETH and KERNEL rewards on Core and Prime instances of Aave v3 to incentivize rsETH deposits and drive adoption. Similarly, the Renzo team seeks to distribute REZ rewards across Prime instance of Aave v3 to support the growth of ezETH deposits.

Both teams aim to leverage these rewards to foster the continued adoption and expansion of rsETH and ezETH within the Aave ecosystem. The ACI team will manage the distribution of rewards on behalf of Kelp and Renzo.

## Specification

### Aave Core & Prime:

The emission admin role for [KERNEL](https://etherscan.io/address/0x3f80B1c54Ae920Be41a77f8B902259D48cf24cCf), [REZ](https://etherscan.io/address/0x3B50805453023a91a8bf641e279401a0b23FA6F9) and [rsETH](https://etherscan.io/address/0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7) is granted to [0xdef1FA4CEfe67365ba046a7C630D6B885298E210](https://etherscan.io/address/0xdef1FA4CEfe67365ba046a7C630D6B885298E210).

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250117_AaveV3Ethereum_SetREZKERNELAndRsETHEmissionAdminToACI/AaveV3Ethereum_SetREZKERNELAndRsETHEmissionAdminToACI_20250117.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250117_AaveV3Ethereum_SetREZKERNELAndRsETHEmissionAdminToACI/AaveV3Ethereum_SetREZKERNELAndRsETHEmissionAdminToACI_20250117.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-set-rez-kernel-and-rseth-emission-admin-to-aci/20599)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
