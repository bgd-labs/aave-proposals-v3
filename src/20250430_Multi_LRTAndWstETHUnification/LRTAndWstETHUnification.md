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

Provided suitable ETH liquidity is available, implementing favourable eMode terms on Prime relative to other instances of Aave is expected to lead to significant growth in wstETH deposits. A LT of 96.50% exceeds the previous forum discussion supportive of implementing a 96.00% LT, whilst also isolating the LT increase specifically to the Prime instance that reflects a clear focus to progress Prime into a sustainable ETH correlated instance of Aave v3.

Reference: [[Risk Stewards]wstETH/wETH eMode Update - Ethereum, Arbitrum & Base Instances](https://governance.aave.com/t/risk-stewards-wsteth-weth-emode-update-ethereum-arbitrum-base-instances/21333)

#### wstETH/wETH Legacy eMode Update

|       Parameter       |    Value     |
| :-------------------: | :----------: |
|         Asset         | wstETH, WETH |
|        Max LTV        |     93.5     |
| Liquidation Threshold |     95.5     |
|  Liquidation Penalty  |    1.00%     |

#### New wstETH/wETH v3.2 liquid eMode

|       Parameter       | Value  | Value |
| :-------------------: | :----: | :---: |
|         Asset         | wstETH | WETH  |
|      Collateral       |  Yes   |  No   |
|      Borrowable       |   No   |  Yes  |
|        Max LTV        | 95.00% |   -   |
| Liquidation Threshold | 96.50% |   -   |
|  Liquidation Penalty  | 1.00%  |   -   |

Complimenting the abundance of USDS liquidity provided by the Sky Ecosystem via D3M, this publication proposes increasing the LTV and LT on Prime to improve the capital efficiency of WETH and wstETH relative to other instances of Aave v3. With the support of Sky via D3M and Gho Stewards via Direct Gho Minter Facilitator providing liquidity on demand, the Prime instance is able to offer consistent stablecoin supply and less volatile borrow rates to users.

The combination of improved capital efficiency and less volatile borrow rates elevates the competitive positioning of the Prime instances within the broader ecosystem.

#### WETH LTV/LT Update

| Parameter | Current | Proposed |
| :-------: | :-----: | :------: |
|    LTV    | 82.00%  |  84.00%  |
|    LT     | 83.00%  |  85.00%  |

#### wstETH LTV/LT Update

| Parameter | Current | Proposed |
| :-------: | :-----: | :------: |
|    LTV    | 80.00%  |  82.00%  |
|    LT     | 81.00%  |  83.00%  |

### rsETH LTV & LT Update

To promote a level playing field between LRTs, a proposal was submitted and approved by Risk Service Providers to align the LTV and LT parameters of rsETH with other LRTs, ezETH and weETH.

The following is proposed for rsETH Core, Prime and Base instances:

- Update rsETH/wstETH eMode: LTV 93%, LT 95% and Liquidation Penalty 1%.

A previous forum post details favourable feedback from Risk Service providers supporting amending the LTV and LT to align with other LRTs.

Reference: [[ARFC] rsETH LTV & LT Update](https://governance.aave.com/t/arfc-rseth-ltv-lt-update/21305/1)

#### rsETH/wstETH eMode Update

(Prime, Core, Arbitrum and Base)

|       Parameter       | Value  | Value  |
| :-------------------: | :----: | :----: |
|         Asset         | rsETH  | wstETH |
|      Collateral       |  Yes   |   No   |
|      Borrowable       |   No   |  Yes   |
|        Max LTV        | 93.00% |   -    |
| Liquidation Threshold | 95.00% |   -    |
|  Liquidation Penalty  | 1.00%  |   -    |

Enable rsETH to access stablecoin liquidity on Prime, Arbitrum and Base instances.

#### Create new v3.2 liquid eMode

(Prime)

|       Parameter       | Value  | Value | Value | Value |
| :-------------------: | :----: | :---: | :---: | :---: |
|         Asset         | rsETH  | USDS  | USDC  |  GHO  |
|      Collateral       |  Yes   |  No   |  No   |  No   |
|      Borrowable       |   No   |  Yes  |  Yes  |  Yes  |
|        Max LTV        | 72.00% |   -   |   -   |   -   |
| Liquidation Threshold | 75.00% |   -   |   -   |   -   |
|  Liquidation Penalty  | 7.50%  |   -   |   -   |   -   |

#### Create new v3.2 liquid eMode

(Arbitrum)

|       Parameter       | Value  | Value | Value |
| :-------------------: | :----: | :---: | :---: |
|         Asset         | rsETH  | USDC  | USDT  |
|      Collateral       |  Yes   |  No   |  No   |
|      Borrowable       |   No   |  Yes  |  Yes  |
|        Max LTV        | 72.00% |   -   |   -   |
| Liquidation Threshold | 75.00% |   -   |   -   |
|  Liquidation Penalty  | 7.50%  |   -   |   -   |

#### Create new v3.2 liquid eMode

(Base)

|       Parameter       | Value  | Value |
| :-------------------: | :----: | :---: |
|         Asset         | rsETH  | USDC  |
|      Collateral       |  Yes   |  No   |
|      Borrowable       |   No   |  Yes  |
|        Max LTV        | 72.00% |   -   |
| Liquidation Threshold | 75.00% |   -   |
|  Liquidation Penalty  | 7.50%  |   -   |

### weETH LTV & LT Update

Based upon improving liquidity conditions on both Arbitrum and Base for weETH, this publication proposes increasing the weETH LTV and LTV as recommended by the Chaos Labs and Llama Risk in the reference linked below.

#### weETH LTV/LT Update

(Arb and Base)

| Parameter | Current | Proposed |
| :-------: | :-----: | :------: |
|    LTV    |  72.5%  |   75%    |
|    LT     |   75%   |   77%    |

Reference: [[ARFC] wstETH and weETH E-Modes and LT/LTV Adjustments on Ethereum, Arbitrum, Base - 03.12.25](https://governance.aave.com/t/arfc-wsteth-and-weeth-e-modes-and-lt-ltv-adjustments-on-ethereum-arbitrum-base-03-12-25/21370)

### Base Instance - Liquid eMode v3.2

The introduction of Liquid eModes in Aave v3.2 enables more granular and targeted risk configurations between correlated assets such as LSTs and LRTs. Creating isolated eModes for each pair enhances capital efficiency relative to the current ETH-correlated eModes on the Base instance.

Currently, Aave Protocol supports a single ETH Correlated eMode on Base.

|       Parameter       |           Value            |
| :-------------------: | :------------------------: |
|         Asset         | weETH, wstETH, cbETH, WETH |
|        Max LTV        |           90.00%           |
| Liquidation Threshold |           93.00%           |
|  Liquidation Penalty  |           2.00%            |

To align the asset parameter configuration on Base instance with other instances of Aave, new v3.2 Liquid eModes are to be deployed with the following parameters. Each new eMode reflects the LTV and LT in use on the Core instance on Ethereum and in doing so unifies the parameters across Core, Arb and Base. Furthermore, by pausing the existing ETH correlated eMode and transitioning to more capital efficient v3.2 eModes, it prevents same-asset looping that undermines liquidity incentives from unintended utilisation.

#### weETH/WETH eMode Update

|       Parameter       | Value  | Value |
| :-------------------: | :----: | :---: |
|         Asset         | weETH  | wETH  |
|      Collateral       |  Yes   |  No   |
|      Borrowable       |   No   |  Yes  |
|        Max LTV        | 93.00% |   -   |
| Liquidation Threshold | 95.00% |   -   |
|  Liquidation Penalty  | 1.25%  |   -   |

#### wstETH/WETH eMode Update

|       Parameter       | Value  | Value |
| :-------------------: | :----: | :---: |
|         Asset         | wstETH | wETH  |
|      Collateral       |  Yes   |  No   |
|      Borrowable       |   No   |  Yes  |
|        Max LTV        | 93.00% |   -   |
| Liquidation Threshold | 95.00% |   -   |
|  Liquidation Penalty  | 1.00%  |   -   |

#### cbETH/WETH eMode Update

|       Parameter       | Value  | Value |
| :-------------------: | :----: | :---: |
|         Asset         | cbETH  | wETH  |
|      Collateral       |  Yes   |  No   |
|      Borrowable       |   No   |  Yes  |
|        Max LTV        | 93.00% |   -   |
| Liquidation Threshold | 95.00% |   -   |
|  Liquidation Penalty  | 2.00%  |   -   |

The above new weETH eModes incorporates the feedback from the forum discussion linked below.

Reference: [[ARFC] wstETH and weETH E-Modes and LT/LTV Adjustments on Ethereum, Arbitrum, Base - 03.12.25](https://governance.aave.com/t/arfc-wsteth-and-weeth-e-modes-and-lt-ltv-adjustments-on-ethereum-arbitrum-base-03-12-25/21370)

## Specification

The following adjustments are to be implemented on all instances within the same AIP.

### Prime - Ethereum

The Prime instance has the highest LTV/LT for ETH correlated assets.

Pause the current wstETH/wETH Legacy eMode Update

|       Parameter       |    Value     |
| :-------------------: | :----------: |
|         Asset         | wstETH, WETH |
|        Max LTV        |     95.0     |
| Liquidation Threshold |     96.5     |
|  Liquidation Penalty  |    1.00%     |

Update WETH LTV and LT Parameters

| Parameter | Current | Proposed |
| :-------: | :-----: | :------: |
|    LTV    | 82.00%  |  84.00%  |
|    LT     | 83.00%  |  85.00%  |

Update wstETH LTV and LT Parameters

| Parameter | Current | Proposed |
| :-------: | :-----: | :------: |
|    LTV    | 80.00%  |  82.00%  |
|    LT     | 81.00%  |  83.00%  |

Create new v3.2 liquid eMode

|       Parameter       | Value  | Value |
| :-------------------: | :----: | :---: |
|         Asset         | wstETH | WETH  |
|      Collateral       |  Yes   |  No   |
|      Borrowable       |   No   |  Yes  |
|        Max LTV        | 95.00% |   -   |
| Liquidation Threshold | 96.50% |   -   |
|  Liquidation Penalty  | 1.00%  |   -   |

Create new v3.2 liquid eMode

|       Parameter       | Value  | Value | Value | Value |
| :-------------------: | :----: | :---: | :---: | :---: |
|         Asset         | rsETH  | USDS  | USDC  |  GHO  |
|      Collateral       |  Yes   |  No   |  No   |  No   |
|      Borrowable       |   No   |  Yes  |  Yes  |  Yes  |
|        Max LTV        | 72.00% |   -   |   -   |   -   |
| Liquidation Threshold | 75.00% |   -   |   -   |   -   |
|  Liquidation Penalty  | 7.50%  |   -   |   -   |   -   |

### Core - Ethereum

rsETH/wstETH liquid eMode update.

|       Parameter       |      Value      | Value  |
| :-------------------: | :-------------: | :----: |
|         Asset         |      rsETH      | wstETH |
|      Collateral       |       Yes       |   No   |
|      Borrowable       |       No        |  Yes   |
|        Max LTV        | ~~92.5~~ 93.00% |   -    |
| Liquidation Threshold | ~~94.5~~ 95.00% |   -    |
|  Liquidation Penalty  |      1.00%      |   -    |

### Arbitrum

rsETH/wstETH liquid eMode update.

|       Parameter       |      Value      | Value  |
| :-------------------: | :-------------: | :----: |
|         Asset         |      rsETH      | wstETH |
|      Collateral       |       Yes       |   No   |
|      Borrowable       |       No        |  Yes   |
|        Max LTV        | ~~92.5~~ 93.00% |   -    |
| Liquidation Threshold | ~~94.5~~ 95.00% |   -    |
|  Liquidation Penalty  |      1.00%      |   -    |

Create new v3.2 liquid eMode

|       Parameter       | Value  | Value | Value |
| :-------------------: | :----: | :---: | :---: |
|         Asset         | rsETH  | USDC  | USDT  |
|      Collateral       |  Yes   |  No   |  No   |
|      Borrowable       |   No   |  Yes  |  Yes  |
|        Max LTV        | 72.00% |   -   |   -   |
| Liquidation Threshold | 75.00% |   -   |   -   |
|  Liquidation Penalty  | 7.50%  |   -   |   -   |

weETH LTV/LT Update.

| Parameter | Current | Proposed |
| :-------: | :-----: | :------: |
|    LTV    |  72.5%  |   75%    |
|    LT     |   75%   |   77%    |

### Base

rsETH/wstETH liquid eMode, no change.

|       Parameter       |      Value      | Value  |
| :-------------------: | :-------------: | :----: |
|         Asset         |      rsETH      | wstETH |
|      Collateral       |       Yes       |   No   |
|      Borrowable       |       No        |  Yes   |
|        Max LTV        | ~~92.5~~ 93.00% |   -    |
| Liquidation Threshold | ~~94.5~~ 95.00% |   -    |
|  Liquidation Penalty  |      1.00%      |   -    |

Create new v3.2 liquid eMode

|       Parameter       | Value  | Value |
| :-------------------: | :----: | :---: |
|         Asset         | rsETH  | USDC  |
|      Collateral       |  Yes   |  No   |
|      Borrowable       |   No   |  Yes  |
|        Max LTV        | 72.00% |   -   |
| Liquidation Threshold | 75.00% |   -   |
|  Liquidation Penalty  | 7.50%  |   -   |

Create weETH/wETH liquid eMode.

|       Parameter       | Value  | Value |
| :-------------------: | :----: | :---: |
|         Asset         | weETH  | wETH  |
|      Collateral       |  Yes   |  No   |
|      Borrowable       |   No   |  Yes  |
|        Max LTV        | 93.00% |   -   |
| Liquidation Threshold | 95.00% |   -   |
|  Liquidation Penalty  | 1.25%  |   -   |

Create wstETH/WETH eMode Update

|       Parameter       | Value  | Value |
| :-------------------: | :----: | :---: |
|         Asset         | wstETH | wETH  |
|      Collateral       |  Yes   |  No   |
|      Borrowable       |   No   |  Yes  |
|        Max LTV        | 93.00% |   -   |
| Liquidation Threshold | 95.00% |   -   |
|  Liquidation Penalty  | 1.00%  |   -   |

Create cbETH/WETH eMode Update

|       Parameter       | Value  | Value |
| :-------------------: | :----: | :---: |
|         Asset         | cbETH  | wETH  |
|      Collateral       |  Yes   |  No   |
|      Borrowable       |   No   |  Yes  |
|        Max LTV        | 93.00% |   -   |
| Liquidation Threshold | 95.00% |   -   |
|  Liquidation Penalty  | 2.00%  |   -   |

Pause the existing eMode by disabling wETH Borrowing within existing eMode. Users will no be able to borrow wETH debt within the legacy eMode upon implementation.

weETH LTV/LT Update.

| Parameter | Current | Proposed |
| :-------: | :-----: | :------: |
|    LTV    |  72.5%  |   75%    |
|    LT     |   75%   |   77%    |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250430_Multi_LRTAndWstETHUnification/AaveV3Ethereum_LRTAndWstETHUnification_20250430.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250430_Multi_LRTAndWstETHUnification/AaveV3EthereumLido_LRTAndWstETHUnification_20250430.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250430_Multi_LRTAndWstETHUnification/AaveV3Arbitrum_LRTAndWstETHUnification_20250430.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250430_Multi_LRTAndWstETHUnification/AaveV3Base_LRTAndWstETHUnification_20250430.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250430_Multi_LRTAndWstETHUnification/AaveV3Ethereum_LRTAndWstETHUnification_20250430.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250430_Multi_LRTAndWstETHUnification/AaveV3EthereumLido_LRTAndWstETHUnification_20250430.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250430_Multi_LRTAndWstETHUnification/AaveV3Arbitrum_LRTAndWstETHUnification_20250430.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250430_Multi_LRTAndWstETHUnification/AaveV3Base_LRTAndWstETHUnification_20250430.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-lrt-and-wsteth-unification/21739)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
