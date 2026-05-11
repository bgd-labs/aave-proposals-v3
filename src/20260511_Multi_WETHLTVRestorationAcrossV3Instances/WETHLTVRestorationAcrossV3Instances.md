---
title: "rsETH Incident: WETH LTV Restoration Across V3 Instances"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-weth-unfreeze-and-ltv-restoration-across-aave-v3-instances/24878"
---

## Simple Summary

Restore WETH Loan-to-Value (LTV) on Aave V3 Ethereum Core, Ethereum Prime, Arbitrum, Base, Mantle, Linea to their respective pre-exploit values. The Risk Guardian has already lifted the WETH freeze on the L2 instances where it remains in place. Together, these actions return the WETH market to normal operation across all Aave V3 deployments affected by the precautionary measures applied during the [2026-04-18 Kelp/LayerZero OFT bridge exploit](https://governance.aave.com/t/rseth-incident-2026-04-18/24481/153).

## Motivation

The temporary WETH freeze on L2s and LTV=0 across all affected instances were precautionary measures applied at the time of the 2026-04-18 exploit, alongside the freeze of rsETH and wrsETH reserves. The recovery has since progressed substantially, as outlined in the [Aave update of 2026-05-08](https://x.com/aave/status/2052928584667275472):

- On 2026-05-06, the attacker positions across Aave V3 Ethereum Core and Arbitrum were liquidated via a specifically constructed AIP payload.
- Combined with Compound’s parallel liquidations, 106,993 rsETH has been recovered (89,567 from Aave V3 + 17,426 from Compound) out of an estimated 112,103 rsETH of unbacked supply on the affected L2s. The retrieved rsETH was transferred to the [Aave Recovery Guardian](https://debank.com/profile/0x53cb4bb8f61fa45405dc75f476fadad801e653d9).
- The remaining ~5,211 rsETH (sold by the attacker on DEXs and not recovered through liquidations) is to be covered by the DeFi United coalition’s committed ETH.
- Mantle DAO has formally joined DeFi United via onchain governance vote.
- A New York court has authorised an onchain Arbitrum DAO vote to transfer the immobilised $71M of stolen ETH (recovered by Arbitrum’s Security Council) to Aave LLC for the recovery effort.

Given the secured DeFi United funds and the demonstrated recovery progress, the precautionary WETH constraints on Aave can be lifted now without compromising user protection. Holding WETH LTV at 0 longer than necessary creates avoidable friction for end-users. This advisory to unfreeze and restore WETH LTV is contingent on the rsETH restoration efforts progressing as planned and with the successful deployment of DeFi United funds to cover the bad debt in all affected Aave markets.

## Specification

### Base Reserve LTV Restoration

Restore the WETH base reserve LTV to its pre-2026-04-18 value on each Aave V3 deployment that received the precautionary LTV=0 as part of the reserve freeze enacted via the Aave Protocol Guardian. Liquidation Threshold (LT), Liquidation Bonus (LB), Reserve Factor, and the `usageAsCollateralEnabled` flag remain unchanged.

| Aave V3 Instance | Current LTV | Target LTV (pre-exploit) | LT (unchanged) | LB (unchanged) |
| ---------------- | ----------- | ------------------------ | -------------- | -------------- |
| Ethereum Core    | 0.00%       | **80.50%**               | 83.00%         | 5.00%          |
| Ethereum Prime   | 0.00%       | **84.00%**               | 85.00%         | 5.00%          |
| Arbitrum         | 0.00%       | **80.00%**               | 84.00%         | 5.00%          |
| Base             | 0.00%       | **80.00%**               | 83.00%         | 5.00%          |
| Mantle           | 0.00%       | **80.50%**               | 83.00%         | 5.50%          |
| Linea            | 0.00%       | **80.00%**               | 83.00%         | 6.00%          |

### E-Mode LTV Restoration

The precaution also implicitly set the LTV-zero flag on WETH in the ETH-correlated E-Mode of each market where WETH is enabled as E-Mode collateral. The flag zeroes the E-Mode LTV for the flagged asset without modifying the eMode category configuration or the collateral bitmap; LT and LB inside the eMode are unaffected. Since Aave v3.6, this state can be reset via `setAssetLtvzeroInEMode`.

| Market        | E-Mode ID | Category       | **LTV**    | LT (unchanged) |
| ------------- | --------- | -------------- | ---------- | -------------- |
| Ethereum Core | 1         | ETH correlated | **93.00%** | 95.00%         |
| Arbitrum      | 2         | ETH correlated | **93.00%** | 95.00%         |
| Base          | 1         | ETH correlated | **90.00%** | 93.00%         |

After the flag is unset on these markets, the effective WETH E-Mode LTV reverts to the eMode category cap: 93% on Ethereum Core and Arbitrum, 90% on Base.

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260511_Multi_WETHLTVRestorationAcrossV3Instances/AaveV3Ethereum_WETHLTVRestorationAcrossV3Instances_20260511.sol), [AaveV3EthereumLido](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260511_Multi_WETHLTVRestorationAcrossV3Instances/AaveV3EthereumLido_WETHLTVRestorationAcrossV3Instances_20260511.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260511_Multi_WETHLTVRestorationAcrossV3Instances/AaveV3Arbitrum_WETHLTVRestorationAcrossV3Instances_20260511.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260511_Multi_WETHLTVRestorationAcrossV3Instances/AaveV3Base_WETHLTVRestorationAcrossV3Instances_20260511.sol), [AaveV3Linea](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260511_Multi_WETHLTVRestorationAcrossV3Instances/AaveV3Linea_WETHLTVRestorationAcrossV3Instances_20260511.sol), [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260511_Multi_WETHLTVRestorationAcrossV3Instances/AaveV3Mantle_WETHLTVRestorationAcrossV3Instances_20260511.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260511_Multi_WETHLTVRestorationAcrossV3Instances/AaveV3Ethereum_WETHLTVRestorationAcrossV3Instances_20260511.t.sol), [AaveV3EthereumLido](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260511_Multi_WETHLTVRestorationAcrossV3Instances/AaveV3EthereumLido_WETHLTVRestorationAcrossV3Instances_20260511.t.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260511_Multi_WETHLTVRestorationAcrossV3Instances/AaveV3Arbitrum_WETHLTVRestorationAcrossV3Instances_20260511.t.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260511_Multi_WETHLTVRestorationAcrossV3Instances/AaveV3Base_WETHLTVRestorationAcrossV3Instances_20260511.t.sol), [AaveV3Linea](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260511_Multi_WETHLTVRestorationAcrossV3Instances/AaveV3Linea_WETHLTVRestorationAcrossV3Instances_20260511.t.sol), [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260511_Multi_WETHLTVRestorationAcrossV3Instances/AaveV3Mantle_WETHLTVRestorationAcrossV3Instances_20260511.t.sol)
- Snapshot: Direct-To-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-weth-unfreeze-and-ltv-restoration-across-aave-v3-instances/24878)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
