---
title: "Maintenance: Grant AL RETRY_ROLE on a.DI (Part 1)"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-grant-aave-labs-retry-role-on-a-di/25020"
---

## Simple Summary

This proposal grants the Aave Labs multisig the RETRY_ROLE on a.DI’s granular access controls.

Recipient: 0x2B99790c35a401be873FA7Eb514D9220736BB1cA

This is Part 1 of 2. It covers Ethereum, Polygon, Avalanche, Optimism, Arbitrum, Metis, Base, Gnosis, Scroll and BNB. Part 2 covers Linea, Celo, Sonic, Soneium, Plasma, Mantle, MegaEth, XLayer and Ink.

## Motivation

a.DI is the cross-chain delivery layer used by Aave governance to route approved governance actions from Ethereum to other networks.

As Aave governance expands across more networks, message delivery operations become more important. The RETRY_ROLE allows a technical operator to retry messages that were already sent through a.DI if a message does not arrive, or to route an already-sent message through another configured bridge adapter if one of the selected providers fails.

Granting this role to Aave Labs improves operational coverage for governance message delivery while keeping control of governance actions with the DAO.

## Specification

If approved, this proposal will grant the RETRY_ROLE on a.DI to the Aave Labs multisig:

Aave Labs multisig: 0x2B99790c35a401be873FA7Eb514D9220736BB1cA

The role will be used by Aave Labs as a technical service provider to support retry operations for already-sent a.DI messages when needed.

The role grant covers the nineteen networks: Ethereum, Polygon, Avalanche, Optimism, Arbitrum, Metis, Base, Gnosis, Scroll, BNB, Linea, Celo, Sonic, Soneium, Plasma, Mantle, MegaEth, XLayer and Ink. Forwarding that many payloads through a.DI in a single proposal execution would risk running out of gas, so it is split across two proposals. This proposal covers Ethereum, Polygon, Avalanche, Optimism, Arbitrum, Metis, Base, Gnosis, Scroll and BNB; the remaining nine are covered by Part 2. The two proposals are otherwise identical in intent and grant the same role to the same multisig.

On Scroll and Metis the payload also sets the GranularGuardian as guardian of the CrossChainController, a role currently held by an external multisig on those two networks. The GranularGuardian can only forward retry calls to the CrossChainController while it holds that role, so without this change the RETRY_ROLE grant would have no effect on Scroll and Metis. All other a.DI networks already have the GranularGuardian set as CrossChainController guardian, so this brings both networks in line with the default a.DI configuration.

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Ethereum_MaintenanceGrantALRETRY_ROLEOnADI_20260603.sol), [AaveV3Polygon](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Polygon_MaintenanceGrantALRETRY_ROLEOnADI_20260603.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Avalanche_MaintenanceGrantALRETRY_ROLEOnADI_20260603.sol), [AaveV3Optimism](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Optimism_MaintenanceGrantALRETRY_ROLEOnADI_20260603.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Arbitrum_MaintenanceGrantALRETRY_ROLEOnADI_20260603.sol), [AaveV3Metis](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Metis_MaintenanceGrantALRETRY_ROLEOnADI_20260603.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Base_MaintenanceGrantALRETRY_ROLEOnADI_20260603.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Gnosis_MaintenanceGrantALRETRY_ROLEOnADI_20260603.sol), [AaveV3Scroll](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Scroll_MaintenanceGrantALRETRY_ROLEOnADI_20260603.sol), [AaveV3BNB](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3BNB_MaintenanceGrantALRETRY_ROLEOnADI_20260603.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Ethereum_MaintenanceGrantALRETRY_ROLEOnADI_20260603.t.sol), [AaveV3Polygon](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Polygon_MaintenanceGrantALRETRY_ROLEOnADI_20260603.t.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Avalanche_MaintenanceGrantALRETRY_ROLEOnADI_20260603.t.sol), [AaveV3Optimism](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Optimism_MaintenanceGrantALRETRY_ROLEOnADI_20260603.t.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Arbitrum_MaintenanceGrantALRETRY_ROLEOnADI_20260603.t.sol), [AaveV3Metis](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Metis_MaintenanceGrantALRETRY_ROLEOnADI_20260603.t.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Base_MaintenanceGrantALRETRY_ROLEOnADI_20260603.t.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Gnosis_MaintenanceGrantALRETRY_ROLEOnADI_20260603.t.sol), [AaveV3Scroll](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Scroll_MaintenanceGrantALRETRY_ROLEOnADI_20260603.t.sol), [AaveV3BNB](https://github.com/aave-dao/aave-proposals-v3/blob/fb9f03ac9320fe6fa59de59065e833aa8e1da402/src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3BNB_MaintenanceGrantALRETRY_ROLEOnADI_20260603.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-grant-aave-labs-retry-role-on-a-di/25020)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
