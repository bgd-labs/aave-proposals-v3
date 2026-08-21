---
title: "Maintenance: Grant AL RETRY_ROLE on a.DI (Part 2)"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-grant-aave-labs-retry-role-on-a-di/25020"
---

## Simple Summary

This proposal grants the Aave Labs multisig the RETRY_ROLE on a.DI’s granular access controls.

Recipient: 0x2B99790c35a401be873FA7Eb514D9220736BB1cA

This is Part 2 of 2. It covers Linea, Celo, Sonic, Soneium, Plasma, Mantle, MegaEth, XLayer and Ink. Part 1 covers Ethereum, Polygon, Avalanche, Optimism, Arbitrum, Metis, Base, Gnosis, Scroll and BNB.

## Motivation

a.DI is the cross-chain delivery layer used by Aave governance to route approved governance actions from Ethereum to other networks.

As Aave governance expands across more networks, message delivery operations become more important. The RETRY_ROLE allows a technical operator to retry messages that were already sent through a.DI if a message does not arrive, or to route an already-sent message through another configured bridge adapter if one of the selected providers fails.

Granting this role to Aave Labs improves operational coverage for governance message delivery while keeping control of governance actions with the DAO.

## Specification

If approved, this proposal will grant the RETRY_ROLE on a.DI to the Aave Labs multisig:

Aave Labs multisig: 0x2B99790c35a401be873FA7Eb514D9220736BB1cA

The role will be used by Aave Labs as a technical service provider to support retry operations for already-sent a.DI messages when needed.

The role grant covers the nineteen networks: Ethereum, Polygon, Avalanche, Optimism, Arbitrum, Metis, Base, Gnosis, Scroll, BNB, Linea, Celo, Sonic, Soneium, Plasma, Mantle, MegaEth, XLayer and Ink. Forwarding that many payloads through a.DI in a single proposal execution would risk running out of gas, so it is split across two proposals. This proposal covers Linea, Celo, Sonic, Soneium, Plasma, Mantle, MegaEth, XLayer and Ink; the remaining ten are covered by Part 1. The two proposals are otherwise identical in intent and grant the same role to the same multisig.

## References

- Implementation: [AaveV3Linea](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3Linea_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol), [AaveV3Celo](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3Celo_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol), [AaveV3Sonic](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3Sonic_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol), [AaveV3Soneium](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3Soneium_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3Plasma_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol), [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3Mantle_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol), [AaveV3MegaEth](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3MegaEth_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol), [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3XLayer_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol), [AaveV3InkWhitelabel](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3InkWhitelabel_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol)
- Tests: [AaveV3Linea](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3Linea_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.t.sol), [AaveV3Celo](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3Celo_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.t.sol), [AaveV3Sonic](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3Sonic_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.t.sol), [AaveV3Soneium](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3Soneium_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.t.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3Plasma_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.t.sol), [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3Mantle_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.t.sol), [AaveV3MegaEth](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3MegaEth_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.t.sol), [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3XLayer_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.t.sol), [AaveV3InkWhitelabel](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3InkWhitelabel_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-grant-aave-labs-retry-role-on-a-di/25020)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
