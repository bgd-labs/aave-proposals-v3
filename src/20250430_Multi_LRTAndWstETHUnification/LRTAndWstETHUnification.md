---
title: "LRT and wstETH Unification"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-lrt-and-wsteth-unification/21739"
---

## Simple Summary

This publication presents a comprehensive overview of proposed LRT and LST risk parameters updates across Ethereum, Prime, Base and Arbitrum instances of Aave v3.

## Motivation

This publication incorporates the feedback and recent discussions into a single holistic publication. For ease of reference, those publications are referenced below:

- [[ARFC] wstETH and weETH E-Modes and LT/LTV Adjustments on Ethereum, Arbitrum, Base - 03.12.25](https://governance.aave.com/t/arfc-wsteth-and-weeth-e-modes-and-lt-ltv-adjustments-on-ethereum-arbitrum-base-03-12-25/21370)
- [[ARFC] rsETH LTV & LT Update](https://governance.aave.com/t/arfc-rseth-ltv-lt-update/21305)
- [[ARFC] Core Instance - Add ezETH and update rsETH eMode Parameters](https://governance.aave.com/t/arfc-core-instance-add-ezeth-and-update-rseth-emode-parameters/21505)
- [[Risk Stewards]wstETH/wETH eMode Update - Ethereum, Arbitrum & Base Instances](https://governance.aave.com/t/risk-stewards-wsteth-weth-emode-update-ethereum-arbitrum-base-instances/21333)

Each of the following sub-sections presents insights into how each parameter is to be adjusted.

### Prime Instance - wstETH and WETH eMode

The Prime instance, previously Lido instance, presents a tailored wstETH eMode configuration that offers enhanced capital efficiency relative to other instances of Aave v3. With a Liquidation Threshold (LT) of 96.50% for wstETH on Prime relative to 95.00% elsewhere, a position with a Health Factor of 1.01 can support a leverage ratio of 22.44 on Prime relative to 16.83 on other instances of Aave Protocol.

With all other variables held constant, a small difference in the wstETH deposit yield on Prime relative to the Core instance, has a meaningful impact on the overall return of the wstETH/WETH yield strategy. With a strong focus on sustaining a wstETH deposit yield derived from LRT/wstETH leverage, the wstETH/WETH yield strategy is expected to outperform on Prime relative to other venues supporting the same wstETH/WETH strategy.

### rsETH LTV & LT Update

To promote a level playing field between LRTs, a proposal was submitted and approved by Risk Service Providers to align the LTV and LT parameters of rsETH with other LRTs, ezETH and weETH.

The following is proposed for rsETH Core, Prime and Base instances:

- Update rsETH/wstETH eMode: LTV 93%, LT 95% and Liquidation Penalty 1%.

### EModes

The introduction of Liquid eModes in Aave v3.2 enables more granular and targeted risk configurations between correlated assets such as LSTs and LRTs. Creating isolated eModes for each pair enhances capital efficiency relative to the current ETH-correlated eModes on the Base instance.

## Specification

The following adjustments are to be implemented on all instances within the same AIP.

### Prime - Ethereum

Update the current wstETH/wETH eMode

|       Parameter       | Value  |
| :-------------------: | :----: |
|        Max LTV        |  95.0  |
| Liquidation Threshold |  96.5  |
|  Liquidation Penalty  | 1.00%  |
|      Collaterals      | wstETH |
|      Borrowable       |  WETH  |

Create new rsETH/Stablecoins eMode

|       Parameter       |      Value      |
| :-------------------: | :-------------: |
|        Max LTV        |     72.00%      |
| Liquidation Threshold |     75.00%      |
|  Liquidation Penalty  |      7.50%      |
|      Collaterals      |      rsETH      |
|      Borrowable       | USDS, USDC, GHO |

### Core - Ethereum

Update the current rsETH/wstETH

|       Parameter       |    Value     |
| :-------------------: | :----------: |
|        Max LTV        |    93.00%    |
| Liquidation Threshold |    95.00%    |
|  Liquidation Penalty  |    1.00%     |
|      Collaterals      |    rsETH     |
|      Borrowable       | wstETH, ETHx |

### Arbitrum

Update the current rsETH/wstETH

|       Parameter       | Value  |
| :-------------------: | :----: |
|        Max LTV        | 93.00% |
| Liquidation Threshold | 95.00% |
|  Liquidation Penalty  | 1.00%  |
|      Collaterals      | rsETH  |
|      Borrowable       | wstETH |

Create new rsETH/Stablecoins eMode

|       Parameter       |   Value    |
| :-------------------: | :--------: |
|        Max LTV        |   72.00%   |
| Liquidation Threshold |   75.00%   |
|  Liquidation Penalty  |   7.50%    |
|      Collaterals      |   rsETH    |
|      Borrowable       | USDC, USDT |

### Base

Update the current rsETH/wstETH eMode

|       Parameter       | Value  |
| :-------------------: | :----: |
|        Max LTV        | 93.00% |
| Liquidation Threshold | 95.00% |
|  Liquidation Penalty  | 1.00%  |
|      Collaterals      | rsETH  |
|      Borrowable       | wstETH |

Create new rsETH/USDC eMode

|       Parameter       | Value  |
| :-------------------: | :----: |
|        Max LTV        | 72.00% |
| Liquidation Threshold | 75.00% |
|  Liquidation Penalty  | 7.50%  |
|      Collaterals      | rsETH  |
|      Borrowable       |  USDC  |

Create new weETH/wETH eMode

|       Parameter       | Value  |
| :-------------------: | :----: |
|        Max LTV        | 93.00% |
| Liquidation Threshold | 95.00% |
|  Liquidation Penalty  | 1.25%  |
|      Collaterals      | weETH  |
|      Borrowable       |  wETH  |

Create new wstETH/wETH eMode

|       Parameter       | Value  |
| :-------------------: | :----: |
|        Max LTV        | 93.00% |
| Liquidation Threshold | 95.00% |
|  Liquidation Penalty  | 1.00%  |
|      Collaterals      | wstETH |
|      Borrowable       |  wETH  |

Create new cbETH/WETH eMode

|       Parameter       | Value  |
| :-------------------: | :----: |
|        Max LTV        | 93.00% |
| Liquidation Threshold | 95.00% |
|  Liquidation Penalty  | 2.00%  |
|      Collaterals      | cbETH  |
|      Borrowable       |  wETH  |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/6558c100cabdf233a35aea1b7524a9b83c7cfdb6/src/20250430_Multi_LRTAndWstETHUnification/AaveV3Ethereum_LRTAndWstETHUnification_20250430.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/6558c100cabdf233a35aea1b7524a9b83c7cfdb6/src/20250430_Multi_LRTAndWstETHUnification/AaveV3EthereumLido_LRTAndWstETHUnification_20250430.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/6558c100cabdf233a35aea1b7524a9b83c7cfdb6/src/20250430_Multi_LRTAndWstETHUnification/AaveV3Arbitrum_LRTAndWstETHUnification_20250430.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/6558c100cabdf233a35aea1b7524a9b83c7cfdb6/src/20250430_Multi_LRTAndWstETHUnification/AaveV3Base_LRTAndWstETHUnification_20250430.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/6558c100cabdf233a35aea1b7524a9b83c7cfdb6/src/20250430_Multi_LRTAndWstETHUnification/AaveV3Ethereum_LRTAndWstETHUnification_20250430.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/6558c100cabdf233a35aea1b7524a9b83c7cfdb6/src/20250430_Multi_LRTAndWstETHUnification/AaveV3EthereumLido_LRTAndWstETHUnification_20250430.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/6558c100cabdf233a35aea1b7524a9b83c7cfdb6/src/20250430_Multi_LRTAndWstETHUnification/AaveV3Arbitrum_LRTAndWstETHUnification_20250430.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/6558c100cabdf233a35aea1b7524a9b83c7cfdb6/src/20250430_Multi_LRTAndWstETHUnification/AaveV3Base_LRTAndWstETHUnification_20250430.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-lrt-and-wsteth-unification/21739)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
