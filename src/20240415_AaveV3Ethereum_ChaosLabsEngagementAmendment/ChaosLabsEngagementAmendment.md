---
title: "Chaos Labs Engagement Amendment"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-engagement-amendment/17324"
---

## Simple Summary

Chaos Labs proposes an amendment to our current scope of work and compensation structure accordingly. Chaos Labs is requesting a $400,000 increase, bringing our total annual compensation to $2M.

## Motivation

In November 2023, Chaos Labs’ engagement with Aave DAO was [unanimously renewed](https://governance-v2.aave.com/governance/proposal/360/), underscoring our ongoing commitment and the expanded scope of our engagement with Aave, which has evolved significantly with Aave’s expansion now across over 10 deployments.

This renewal was done during the bear market, prompting us to propose a community-friendly deal at a lower-than-market cost, given the challenging market conditions and being mindful of the broader economic environment. This was aligned with the feedback from major Aave stakeholders and delegates. However, the expansion of Aave to multiple chains, in addition to the increased volatility and activity across DeFi and crypto, has significantly increased our scope and workload, necessitating additional resources to maintain the high level of service required.

As dedicated risk contributors, Chaos Labs adopts a holistic approach to managing the spectrum of responsibilities within Aave’s ecosystem, including V3, GHO, and the continued offboarding of V2. Our commitment encompasses risk management, data science, analytics, and parameter recommendation, among other critical functions. An amendment to our compensation is essential to reflect better the resources committed, the depth of our engagement, and the substantial value we bring to the Aave community.

Considering improved market conditions and Aave’s growth over the past several months, we believe the DAO is now in a position to revise our compensation to more accurately reflect the current scale and impact of our engagement and allocated resources.

### Enhancing Aave’s Risk Management Framework

The proposed compensation amendment is not merely a financial adjustment but a continued investment in our collaboration. With additional funding, Chaos Labs will be poised to:

- **Deploy Additional Resources:** Enhance support for existing and future Aave markets, ensuring comprehensive risk management across all deployments.
- **Develop and Optimize Risk Oracles:** Focus efforts on the continued development of the Chaos Risk Oracle specifically for Aave’s needs, enabling more efficient and dynamic risk parameter adjustments. This will further streamline the risk management process, reducing the need for manual interventions and significantly boosting the protocol’s operational efficiency and security.
- **Expansion of Risk Monitoring and Alerts:** Our real-time monitoring and alert services are delivered via the [Chaos Labs Risk Monitoring Platform](https://community.chaoslabs.xyz/aave-v2/risk/overview). We’re committed to enriching these services with more comprehensive analytics and alerts, enhancing visibility and enabling users to meticulously evaluate ecosystem risks and the health of the protocol through intuitive dashboards and data visualizations. The deployment of Risk Oracles will introduce additional data, providing the community with an improved grasp of risk levels and updates to protocol parameters.

### Collaborative Expansion with a Second Risk Service Provider

Following Gauntlet’s resignation as the second-risk service provider, we strongly support the idea of bringing on another service provider to complement our existing scope of work. As part of our engagement, we are committed to dedicating the required resources to assist with the onboarding process and ongoing collaborations, ensuring a seamless integration that enhances Aave’s risk management capabilities without duplicating efforts.

### Conclusion

The requested compensation amendment is key for Chaos Labs to sustain and expand its support for Aave. It will enable us to allocate additional resources effectively, develop innovative solutions like the Risk Oracle, and continue our mission to enhance Aave’s security and efficiency. We are committed to our partnership with Aave and believe that with the community’s support, we can continue setting the standards for risk management in the industry.

## Specification

We request an additional $400K for the remainder of our current engagement, bringing the total annual compensation to $2M.

If this proposal is approved, a stream of the allocated budget will be activated, with a Chaos Labs-controlled account (0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0) as the recipient.

In terms of technical implementation, the AIP will call the createStream() method of the IAaveEcosystemReserveController interface to create a stream of 400,000 aUSDC or GHO.

## Disclaimer

Chaos Labs provides ongoing risk management services to several other borrowing/lending protocols, such as Benqi, Venus, Tapioca, and more. These commitments do not interfere with our responsibilities concerning our association with Aave. We conscientiously provide explicit disclaimers and relevant context in any proposals that may influence clientele across the DeFi ecosystem.

This proposal was not commissioned or paid for by any third party.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7d467002155ba0b1d30cb77780169dc268662f4e/src/20240415_AaveV3Ethereum_ChaosLabsEngagementAmendment/AaveV3Ethereum_ChaosLabsEngagementAmendment_20240415.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/7d467002155ba0b1d30cb77780169dc268662f4e/src/20240415_AaveV3Ethereum_ChaosLabsEngagementAmendment/AaveV3Ethereum_ChaosLabsEngagementAmendment_20240415.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x34b6cf5bc9c8a0525c5b32d4ce2ca2ccfce39d15bd0aba5cab46a4e9e78f3ea8)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-engagement-amendment/17324)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
