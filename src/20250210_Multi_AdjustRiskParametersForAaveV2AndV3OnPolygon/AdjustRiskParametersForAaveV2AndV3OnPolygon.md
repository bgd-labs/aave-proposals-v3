---
title: "Adjust Risk Parameters for Aave V2 and V3 on Polygon"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/arfc-adjust-risk-parameters-for-aave-v2-and-v3-on-polygon/20211"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x48cb2ca277c9cfa0855e8561878836eea182e45dea0e140c03786e533519c2dc"
---

## Simple Summary

This proposal will update the risk parameters for Aave V2 and V3 instances on the Polygon network. The adjustments are in response to an upcoming proposal that will significantly impact the risk profiles of bridged assets within the Polygon network.

## Motivation

Polygon governance was evaluating [a proposal](https://forum.polygon.technology/t/pre-pip-polygon-pos-bridge-liquidity-program/20284) that would redefine the risk profile of bridged assets on the Polygon network. This change could have substantial implications for the risk profiles of Aave V2 and V3 deployments on Polygon PoS.

Historically, bridge vulnerabilities have caused the largest losses in the DeFi ecosystem, including:

1. [Ronin](https://rekt.news/ronin-rekt/) - $624M
2. [BNB “Bridge”](https://rekt.news/bnb-bridge-rekt/) - $586M
3. [Wormhole](https://rekt.news/wormhole-rekt/) - $326M
4. [Nomad](https://rekt.news/nomad-rekt/) - $190M
5. [Multichain](https://rekt.news/multichain-rekt2/) - $126M
6. [Harmony](https://rekt.news/harmony-rekt/) - $100M

The Aave ecosystem has experienced both indirect and direct impacts from bridge vulnerabilities, notably the Multichain and Harmony bridge hacks. Additionally, depositing user funds into unsafe protocols has historically resulted in significant losses. For example, the Angle Protocol deposited EURA funds into Euler a week before its hack, which caused EURA to lose its peg temporarily, impacting Aave users.

This AIP aims to mitigate potential losses for Aave users by:

1. Soliciting immediate feedback from risk service providers (@ChaosLabs and @LlamaRisk) to determine appropriate adjustments to risk parameters.
2. Engaging @TokenLogic to design a user position migration initiative, leveraging Merit (rewards for closing positions on Polygon and reopening equivalent positions on other networks).
3. Inviting L2 networks interested in attracting Aave Polygon users to participate in Merit co-incentive programs.

> Sonic team announced a 20m$ incentives plan for their [TEMP CHECK](https://governance.aave.com/t/temp-check-deploy-aave-v3-on-sonic/20259) with 10% allocated for migration incentives.

4. Seeking feedback from @bgdlabs to migrate Aave Governance V3 voting infrastructure to a more secure L2 network.
5. Requesting support from @AaveLabs to develop front-end migration tools and provide Merit support for a seamless user experience.

## Specification

The following recommendations are proposed to mitigate risk and incentivize migration from the Polygon network:

@ChaosLabs recommend the following risk parameters change:

| Deployment | Asset  | Current LTV | Proposed LTV | Current RF | Proposed RF |
| ---------- | ------ | ----------- | ------------ | ---------- | ----------- |
| Polygon V3 | DAI    | 63%         | 0%           | 25%        | -           |
| Polygon V3 | USDC.e | 75%         | 0%           | 50%        | 60%         |
| Polygon V3 | USDT   | 75%         | 0%           | 10%        | 25%         |
| Polygon V3 | USDC   | 75%         | 0%           | 10%        | 20%         |
| Polygon V2 | USDC.e | 75%         | 0%           | 99.9%      | -           |
| Polygon V2 | DAI    | 63%         | 0%           | 99.9%      | -           |

2. Remove support for Aave V3 Polygon in the Safety Module and cancel the umbrella deployment on Polygon.

## References

- Implementation: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250210_Multi_AdjustRiskParametersForAaveV2AndV3OnPolygon/AaveV2Polygon_AdjustRiskParametersForAaveV2AndV3OnPolygon_20250210.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250210_Multi_AdjustRiskParametersForAaveV2AndV3OnPolygon/AaveV3Polygon_AdjustRiskParametersForAaveV2AndV3OnPolygon_20250210.sol)
- Tests: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250210_Multi_AdjustRiskParametersForAaveV2AndV3OnPolygon/AaveV2Polygon_AdjustRiskParametersForAaveV2AndV3OnPolygon_20250210.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250210_Multi_AdjustRiskParametersForAaveV2AndV3OnPolygon/AaveV3Polygon_AdjustRiskParametersForAaveV2AndV3OnPolygon_20250210.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x48cb2ca277c9cfa0855e8561878836eea182e45dea0e140c03786e533519c2dc)
- [Discussion](https://governance.aave.com/t/arfc-adjust-risk-parameters-for-aave-v2-and-v3-on-polygon/20211)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
