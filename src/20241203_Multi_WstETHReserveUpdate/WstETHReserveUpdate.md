---
title: "wstETH Reserve Update"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-prime-core-instance-wsteth-reserve-update/19973"
snapshot: Direct-to-AIP
---

## Simple Summary

The publication using the Direct-to-AIP process, proposes increasing the capital efficiency of the wstETH Reserve on both Prime and Core instances of Aave v3. This is a Direct to AIP proposal.

## Motivation

### Prime Instance

The addition of ezETH has resulted in over $620M in direct deposits and approximately $520M in wstETH debt. With yield from EIGEN decreasing and Renzo’s Season 3 rewards nearing expiration, this publication proposes amending the wstETH Reserve parameters to enhance capital efficiency and support user retention.

We have engaged with several builders and investors with significant capital deployed on the Prime instance. Currently, leveraged ezETH/wstETH users are primarily sustained by Renzo’s Season 3 rewards, which are set to expire soon. While an additional $100M of USDS is expected in the coming days, this alone will not be sufficient to retain existing users.

### Core Instance

Based on strong demand for wstETH following the rsETH onboarding, this proposal, when implemented, will make a larger portion of wstETH liquidity available.

Discussions with the Kelp team and various investors indicate significant demand wstETH deb by rsETH holders. To accelerate Aave’s growth, the Uoptimal on the wstETH Reserve is be adjusted higher to make available a greater portion of the wstETH liquidity.

## Specification

### Prime Instance

**wstETH Reserve**

| Parameter | Current Value | Proposed Value |
| --------- | ------------- | -------------- |
| Uoptimal  | 80.00%        | 90.00%         |
| Base      | 0.00%         | 0.00%          |
| Slope1    | 2.25%         | 1.75%          |
| Slope2    | 85.00%        | 85.00%         |

### Core Instance

**wstETH Reserve**

| Parameter | Current Value | Proposed Value |
| --------- | ------------- | -------------- |
| Uoptimal  | 45.00%        | 80.00%         |
| Base      | 0.00%         | 0.00%          |
| Slope1    | 2.00%         | 1.75%          |
| Slope2    | 85.00%        | 85.00%         |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/b8f760271a3e490729bd63b21964778e90288478/src/20241203_Multi_WstETHReserveUpdate/AaveV3Ethereum_WstETHReserveUpdate_20241203.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/b8f760271a3e490729bd63b21964778e90288478/src/20241203_Multi_WstETHReserveUpdate/AaveV3EthereumLido_WstETHReserveUpdate_20241203.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/b8f760271a3e490729bd63b21964778e90288478/src/20241203_Multi_WstETHReserveUpdate/AaveV3Ethereum_WstETHReserveUpdate_20241203.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/b8f760271a3e490729bd63b21964778e90288478/src/20241203_Multi_WstETHReserveUpdate/AaveV3EthereumLido_WstETHReserveUpdate_20241203.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-prime-core-instance-wsteth-reserve-update/19973)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
