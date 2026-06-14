---
title: "Maintenance: Grant AL RETRY_ROLE on a.DI"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-grant-aave-labs-retry-role-on-a-di/25020"
---

## Simple Summary

This proposal grants the Aave Labs multisig the RETRY_GUARDIAN role on a.DI’s granular access controls.

Recipient: 0x4Ab2Bed1d667260dB34244Ba412817651C2dD52b

## Motivation

a.DI is the cross-chain delivery layer used by Aave governance to route approved governance actions from Ethereum to other networks.

As Aave governance expands across more networks, message delivery operations become more important. The RETRY_ROLE allows a technical operator to retry messages that were already sent through a.DI if a message does not arrive, or to route an already-sent message through another configured bridge adapter if one of the selected providers fails.

Granting this role to Aave Labs improves operational coverage for governance message delivery while keeping control of governance actions with the DAO.

## Specification

If approved, this proposal will grant the RETRY_ROLE on a.DI to the Aave Labs multisig:

Aave Labs multisig: 0x4Ab2Bed1d667260dB34244Ba412817651C2dD52b

The role will be used by Aave Labs as a technical service provider to support retry operations for already-sent a.DI messages when needed.

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/054088a94887aace379859dd7e4cdf985e1dddbf/src/20260602_AaveV3Ethereum_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Ethereum_MaintenanceGrantALRETRY_ROLEOnADI_20260602.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/054088a94887aace379859dd7e4cdf985e1dddbf/src/20260602_AaveV3Ethereum_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Ethereum_MaintenanceGrantALRETRY_ROLEOnADI_20260602.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-grant-aave-labs-retry-role-on-a-di/25020)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
