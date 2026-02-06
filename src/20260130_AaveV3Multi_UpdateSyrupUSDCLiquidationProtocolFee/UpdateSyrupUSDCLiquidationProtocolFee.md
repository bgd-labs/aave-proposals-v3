---
title: "Update syrupUSDC liquidation protocol fee"
author: "Aavechan Initiative @aci"
discussions: "https://governance.aave.com/t/direct-to-aip-update-syrupusdc-liquidation-protocol-fee-on-aave-v3-base-instance/23963"
---

## Simple Summary

This Direct to AIP proposal plans to update SyrupUSDC config and add a 10% Liquidation Protocol Fee on Aave V3 Base Instance.

## Motivation

AIP was executed through [AIP Onboard SyrupUSDC on Base](https://vote.onaave.com/proposal/?proposalId=437&ipfsHash=0x40b5da4af3c5e5d8048049bcb42d242a6dc5a6c89db2e351c4aa92108b753fe1).

Nevertheless, by mistake the Liquidation Protocol Fee was set up to 0, despite being mentioned to be 10% by risk Services Providers and the proposal itself on Forum [Direct to AIP] Onboard syrupUSDC to Aave V3 Base Instance](https://governance.aave.com/t/direct-to-aip-onboard-syrupusdc-to-aave-v3-base-instance/23234).

This Direct to AIP will update the Liquidation Protocol fee from 0 to 10%.

## Specification

Update the Liquidation Protocol Fee from 0% to 10% for SyrupUSDC on Aave V3 Base Instance.

We will also batch with this AIP a correction of last PT srUSDCe e-mode labels.

## Useful Links

[**[Direct to AIP] Onboard syrupUSDC to Aave V3 Base Instance**](https://governance.aave.com/t/direct-to-aip-onboard-syrupusdc-to-aave-v3-base-instance/23234)

[AIP Onboard SyrupUSDC on Base](https://vote.onaave.com/proposal/?proposalId=437&ipfsHash=0x40b5da4af3c5e5d8048049bcb42d242a6dc5a6c89db2e351c4aa92108b753fe1).

## Disclaimer

ACI is not directly affiliated with Maple and did not receive compensation for the creation of this proposal.

## References

- Implementation: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260130_AaveV3Base_UpdateSyrupUSDCLiquidationProtocolFee/AaveV3Base_UpdateSyrupUSDCLiquidationProtocolFee_20260130.sol)
- Tests: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260130_AaveV3Base_UpdateSyrupUSDCLiquidationProtocolFee/AaveV3Base_UpdateSyrupUSDCLiquidationProtocolFee_20260130.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-update-syrupusdc-liquidation-protocol-fee-on-aave-v3-base-instance/23963)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
