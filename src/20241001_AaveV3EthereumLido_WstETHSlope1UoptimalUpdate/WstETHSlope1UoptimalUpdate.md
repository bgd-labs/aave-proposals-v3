---
title: "wstETH Slope1 & Uoptimal Update"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-lido-instance-wsteth-slope1-uoptimal-update/19069"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x80a2e4e23afa0536c198acc18bb90f2cbb9a28d06e5ab9f2999eb49503232c5f"
---

## Simple Summary

This publication proposes improving the capital efficiency of the wstETH Reserve on the Lido instance of Aave v3 on Ethereum by increasing Uoptimal from 45.00% to 80.00% and reducing the Slope1 from 3.50% to 2.25%.

## Motivation

This proposal recommends revising the wstETH borrow rate ahead of the introduction of Liquid Restaking Tokens (LRTs) and the creation of several new eModes on the Lido instance of Aave v3 on Ethereum.

The upcoming Liquid eModes upgrade will allow a single asset to be included in multiple eModes. As we onboard various LRTs, our goal is to promote the use of wstETH as a debt asset to enhance the returns of the wstETH/wETH yield strategy.

By increasing the Uoptimal of the wstETH reserve, we can significantly improve its capital efficiency. Strategists using LRTs as collateral and borrowing wstETH to generate yield will be able to borrow a larger portion of the wstETH that in turn generates a wstETH deposit yield.

The wstETH deposit yield will offset the wETH borrowing costs. Depending on market conditions, this could lead to a future proposal that fine-tunes the wETH and wstETH Slope1 parameters to balance the wETH deposit yield, revenue, and the performance of the wstETH/ETH yield strategy. Optimizing these parameters is expected to significantly reduce the payback period on the Lido instance and improve the DAO’s overall return on investment.

A separate proposal will provide details on the new eMode configurations being introduced to the Lido instance of Aave v3. This publication focuses specifically on optimizing the wstETH Uoptimal to improve capital efficiency in preparation for LRT onboarding.

Whilst several teams are expected to offer incentives for strategies involving LRT collateral and wstETH debt, general market conditions are not sufficiently buoyant to support retaining the current 3.50% Slope1 parameter.

Whilst we expect strong demand for wstETH debt from users wanting to leverage farm LRT point incentives. Our research indicates sufficient demand emerges when the Slope1 is within the 2.00% to 2.50% range. As a result, this publication proposes reducing the Slope1 from 3.50% to 2.25%.

By revising the Slope1 and Uoptimal configuration for the wstETH reserve, we expect LRT deposits to drive significant AUM growth for the Lido instance.

## Specification

The Lido instance wstETH Slope1 and Uoptimal are to be revised as follows:

| Description | Current | Proposed | Change |
| ----------- | ------- | -------- | ------ |
| Slope1      | 3.50%   | 2.25%    | -1.25% |
| Uopitimal   | 45.00%  | 80.00%   | 35.00% |

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/ec1290f171a1159708fc9be059f669f5231dc835/src/20241001_AaveV3EthereumLido_WstETHSlope1UoptimalUpdate/AaveV3EthereumLido_WstETHSlope1UoptimalUpdate_20241001.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/ec1290f171a1159708fc9be059f669f5231dc835/src/20241001_AaveV3EthereumLido_WstETHSlope1UoptimalUpdate/AaveV3EthereumLido_WstETHSlope1UoptimalUpdate_20241001.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x80a2e4e23afa0536c198acc18bb90f2cbb9a28d06e5ab9f2999eb49503232c5f)
- [Discussion](https://governance.aave.com/t/arfc-lido-instance-wsteth-slope1-uoptimal-update/19069)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
