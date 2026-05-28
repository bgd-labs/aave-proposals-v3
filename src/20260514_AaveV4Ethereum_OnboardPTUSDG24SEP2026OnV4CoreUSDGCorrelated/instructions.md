[quote="LlamaRisk, post:3, topic:24942, full:true"]

# PT-USDG-24SEP2026: Aave V4 Plus Hub Onboarding

## Summary

LlamaRisk supports listing PT-USDG-24SEP2026 on the Aave V4 Plus Hub via a new dedicated USDG Correlated spoke. At the time of this analysis, the asset has approximately 121 days remaining until maturity. The new maturity provides a rollover destination for users currently holding PT-USDG-28MAY2026 collateral on Aave V3 Core as that maturity approaches expiry on May 28, 2026.

The 24SEP2026 Pendle pool currently holds approximately $99.7K in liquidity, we support the onboarding conditionally that the liquidity from the May 28 pool migrates to the PT-USDG-24SEP2026, as its normal of most Pendle pools. The prior maturity PT-USDG-28MAY2026 anchors approximately $105.1M of collateral supply on Aave V3 Core, the demand cohort positioned to rotate into successor pools as the May expiry approaches.

**Assessment of PT base asset:** [Link](https://governance.aave.com/t/arfc-onboard-usdg-to-aave-v3-core-instance/23271/2)

**Assessment of Pendle PTs:** [Link](https://governance.aave.com/t/arfc-onboard-pendle-pt-tokens-to-aave-v3-core-instance/20541)

**Considered PT asset maturities:** PT-USDG-24SEP2026

## Architecture

In Aave V4, every market is structured as a Hub, plus one or more Spokes. The Plus Hub today contains two Spokes (Ethena Ecosystem and Ethena Correlated). The proposed addition introduces a third Spoke on Plus, dedicated to PT-USDG collateral against a single borrowable asset, USDG for the initial deployment period.

![|1120x668](https://llamarisk-outline-storage.nyc3.digitaloceanspaces.com/uploads/2975505f-cbf2-48fc-a597-4f05ca7f6058/274ca2f4-5569-4121-ab44-67229155b90b/plus_hub_expanded.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=DO0037B6TFPQJHE2MVB8%2F20260527%2Fnyc3%2Fs3%2Faws4_request&X-Amz-Date=20260527T110322Z&X-Amz-Expires=604800&X-Amz-Signature=159956c8acca76b00f6d26dbfeebebfd354dfd207d976f3521768b603d0c98d9&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject) _Source: LlamaRisk, May 26, 2026_

USDG is already an established asset on the Core Hub, with native supply, native borrow, and listings across the Main, Gold, and Forex spokes. The proposed listing does not introduce USDG as a new asset to V4; it instead authorizes the new Plus / USDG Correlated spoke to draw from Core’s existing USDG inventory through a cross-hub credit line. From the depositor side, USDG suppliers continue to deposit into the Core Hub. From the borrower side, PT-USDG holders supply collateral to the Plus / USDG Correlated spoke and borrow USDG, which is sourced through the credit line at the Hub level. The Draw Cap on Core for the Plus / USDG Correlated spoke acts as the explicit containment boundary for Core USDG suppliers’ exposure to the new spoke.

The spoke is designated as correlated, enabling tighter Collateral Factors than the equivalent general-purpose configuration. PT-USDG collateral redeems 1:1 to USDG at maturity.

The arrangement parallels the existing Ethena Correlated spoke on Plus Hub, where PT-sUSDE and PT-USDe are paired against USDe borrow within the Ethena correlation group. As subsequent PT-USDG maturities are listed, they would be added to this same USDG Correlated spoke, providing a rollover destination for collateral suppliers as each maturity approaches expiry.

## Asset State

### Asset Growth

USDG circulating supply across all chains stands at approximately $2.63B as of May 26, 2026, up from approximately $1.70B at the time of the V3 Core onboarding assessment on March 30, 2026. On Ethereum, the circulating balance is approximately $480M, broadly stable since the March assessment ($450M), with the remainder distributed across other Global Dollar Network chains (predominantly X Layer and Solana).

![|2000x769](https://llamarisk-outline-storage.nyc3.digitaloceanspaces.com/uploads/2975505f-cbf2-48fc-a597-4f05ca7f6058/dd48d34d-40d8-4fd8-bf78-61671bae8b73/usdg_supply.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=DO0037B6TFPQJHE2MVB8%2F20260527%2Fnyc3%2Fs3%2Faws4_request&X-Amz-Date=20260527T110322Z&X-Amz-Expires=604800&X-Amz-Signature=83b1ba355863a7df0d391644879ccbdf56506fefa55177038ef83cb9196ef387&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject) _Source: LlamaRisk, May 26, 2026_

### Underlying Stability

USDG is issued by Paxos Digital Singapore and Paxos Issuance Europe and is backed 1:1 by cash deposits, short-dated US Treasury instruments, overcollateralized reverse repos, and institutional stable NAV money market funds held in segregated reserve accounts. Monthly reserve attestation reports are published by Enrome LLP, an independent Singapore-based firm.

The market price of USDG stands at $0.9997 against the Chainlink USDG/USD feed, within a few basis points of par. No structural anomalies appear in the price series since feed inception.

![|2000x860](https://llamarisk-outline-storage.nyc3.digitaloceanspaces.com/uploads/2975505f-cbf2-48fc-a597-4f05ca7f6058/28f37030-33c7-4900-9e8c-76066c971398/chainlink_peg.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=DO0037B6TFPQJHE2MVB8%2F20260527%2Fnyc3%2Fs3%2Faws4_request&X-Amz-Date=20260527T110322Z&X-Amz-Expires=604800&X-Amz-Signature=9ac234971d279f64529bffd550fb312a12847bc2244167f0e8ee86fd6dcb1ac1&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject) _Source: LlamaRisk, May 26, 2026_

### Underlying Yield Source

USDG is non-yield-bearing by design; yield is passed through to holders via the Pendle PT structure or through Global Dollar Network (GDN) integrations. For PT-USDG, the fixed yield is implied by purchasing the principal token at a discount to its notional 1 USDG face value and redeeming it 1:1 for USDG at maturity. The discount accretes to par over time following the standard Pendle PT structure, while the floating component is stripped to the corresponding yield token (YT).

The current underlying USDG yield reported by Pendle is 3.11%, reflecting the yield component distributed through GDN to participating platforms.

## Market Analysis

### Total Supply

The PT-USDG-24SEP2026 Pendle market holds approximately $99.7K in pool liquidity, consisting of 74,752 SY-USDG and 25,300 PT-USDG.

The SY-USDG (Standardized Yield) wrapper, which represents all USDG deposited into the Pendle system across maturities, holds approximately 209.6M USDG. Aggregate PT-USDG-24SEP2026 outstanding is 25,300 tokens, with ~100% currently residing inside the AMM (no off-pool carry-trade positions). For context, PT-USDG-28MAY2026 supports approximately $105.1M of collateral supply on Aave V3 Core, the demand cohort positioned to rotate into the successor maturity as the May 28 expiry approaches.

![|2000x800](https://llamarisk-outline-storage.nyc3.digitaloceanspaces.com/uploads/2975505f-cbf2-48fc-a597-4f05ca7f6058/61fe1679-1189-404e-b20d-ed466a7e1256/pool_growth.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=DO0037B6TFPQJHE2MVB8%2F20260527%2Fnyc3%2Fs3%2Faws4_request&X-Amz-Date=20260527T110322Z&X-Amz-Expires=604800&X-Amz-Signature=01352116eac62167cadca4a9f8c09468a9d41241c4729f5a993a3481482ed7f3&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject) _Source: LlamaRisk, May 26, 2026_

### Pool Composition

**PT-USDG-24SEP2026 Pool:**

- **Total Liquidity:** approximately $99.7K
- **SY-USDG:** 74,752 (74.7%)
- **PT-USDG-24SEP2026:** 25,300 (25.3%)

The 74.7% / 25.3% SY/PT split is consistent with proportional LP additions in the absence of swap flow.

![|2000x428](https://llamarisk-outline-storage.nyc3.digitaloceanspaces.com/uploads/2975505f-cbf2-48fc-a597-4f05ca7f6058/873560ec-b556-4072-b015-059138da2f2f/pool_composition.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=DO0037B6TFPQJHE2MVB8%2F20260527%2Fnyc3%2Fs3%2Faws4_request&X-Amz-Date=20260527T110322Z&X-Amz-Expires=604800&X-Amz-Signature=4db6af7b5eb963cbc542b86bd82b6de6bc04beaf2485d9210faf881817580546&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject) _Source: LlamaRisk, May 26, 2026_

### Price and Yield

The implied yield for PT-USDG-24SEP2026 stands at 4.50%, against an underlying USDG yield of 3.11%, with the PT trading at a 1.44% discount to par over the 121-day window to maturity. The 139 bps spread reflects the AMM’s structural anchor in the absence of trading flow.

![|2000x800](https://llamarisk-outline-storage.nyc3.digitaloceanspaces.com/uploads/2975505f-cbf2-48fc-a597-4f05ca7f6058/d89ab93b-a7b5-48e4-8043-c469115c8921/pt_yield.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=DO0037B6TFPQJHE2MVB8%2F20260527%2Fnyc3%2Fs3%2Faws4_request&X-Amz-Date=20260527T110322Z&X-Amz-Expires=604800&X-Amz-Signature=ab7e8a4ec8b6c025f68562ab6d088c0b0c8646da4dbf3044d99359396c304fd3&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject) _Source: LlamaRisk, May 26, 2026_

The LP base APY stands at 3.46%, with a max boosted APY of 6.96% for vePENDLE holders.

![|2000x800](https://llamarisk-outline-storage.nyc3.digitaloceanspaces.com/uploads/2975505f-cbf2-48fc-a597-4f05ca7f6058/711832e2-fafc-4bf1-b55c-367eb004cc3c/lp_apy_history.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=DO0037B6TFPQJHE2MVB8%2F20260527%2Fnyc3%2Fs3%2Faws4_request&X-Amz-Date=20260527T110322Z&X-Amz-Expires=604800&X-Amz-Signature=96b22f0039c0763535ee0cabeee0da6398430f0c8ae1fd93c20042d212ba6ab9&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject) _Source: LlamaRisk, May 26, 2026_

### PT Yield in Context

On Aave V3 Ethereum mainnet, USDT (3.51%) and USDe (3.23%) variable borrow rates sit below the PT implied yield of 4.50%, producing positive carry of approximately 99 bps and 127 bps respectively, while USDC (4.73%) and USDS (5.67%) sit above, producing negative carry of 23 bps and 117 bps. PT-backed leveraged borrowing is currently profitable against USDT and USDe at prevailing rates and unprofitable against USDC and USDS.

### Price and Implied APY Projection

The chart projects the PT price trajectory and implied APY from the snapshot through maturity, with the AMM’s structural ceiling at the 96% proportion bound shown as dashed lines. The initial discount rate of 4.50% tracks the current implied yield of 4.50%.

![|2000x1169](https://llamarisk-outline-storage.nyc3.digitaloceanspaces.com/uploads/2975505f-cbf2-48fc-a597-4f05ca7f6058/11dbd8ac-836f-498c-bde5-a62a96789831/discount_rate_calibration.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=DO0037B6TFPQJHE2MVB8%2F20260527%2Fnyc3%2Fs3%2Faws4_request&X-Amz-Date=20260527T110322Z&X-Amz-Expires=604800&X-Amz-Signature=fa24cbfea9f1ced98eb5d21dc181cc9a2ee55e11dcd68600db2e6729286efdee&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject) _Source: LlamaRisk, May 26, 2026_

### Maturities

PT-USDG-24SEP2026 is the next listed maturity in the USDG-backed PT series alongside the currently active PT-USDG-28MAY2026, which matures on May 28, 2026. With the May maturity within days of expiry, the September pool serves as the rollover destination for collateral suppliers seeking to maintain fixed-yield exposure. Subsequent maturities listed onto the USDG Correlated spoke would provide further rollover destinations as the September pool approaches its own expiry.

## Recommendations

### Parameter Recommendation

**Spoke-level liquidation configuration**

| Spoke                 | Target Health Factor | HF for Max Bonus | Liquidation Bonus Factor |
| --------------------- | -------------------- | ---------------- | ------------------------ |
| USDG Correlated (new) | 1.0277               | 0.99             | 1                        |

**Reserve-level parameters**

We propose enabling the USDG Correlated Spoke to draw liquidity from the Core Hub in order to facilitate the strategy. As demand expands, we would enable other Plus Hub stablecoins to be borrowed against PT-USDG as well as onboard USDG to Plus Hub natively.

| Parameter             | PT-USDG-24SEP2026 | USDG                                    |
| --------------------- | ----------------- | --------------------------------------- |
| Asset role            | Collateral only   | Borrow only (credit line from Core Hub) |
| Suppliable            | yes               | no                                      |
| Collateral            | yes               | no                                      |
| Borrowable            | no                | yes                                     |
| Add Cap               | 15,000,000        | -                                       |
| Draw Cap              | -                 | 13,000,000                              |
| Collateral Factor     | 95%               | -                                       |
| Max Liquidation Bonus | 2%                | -                                       |
| Liquidation Fee       | 10%               | -                                       |
| Collateral Risk score | 0%                | -                                       |

### Price Feed Recommendation

For pricing PT-USDG-24SEP2026 on Aave, the [dynamic linear discount rate oracle](https://governance.aave.com/t/arfc-onboard-pendle-pt-tokens-to-aave-v3-core-instance/20541/5) is recommended. The same oracle template currently in use for PT-USDG-28MAY2026 on Aave V3 Core can be reused for this deployment.

The oracle prices the PT as a zero-coupon bond against a capped underlying Chainlink reference (USDG/USD fixed at $1), applying a linear discount that decays to par at maturity. The discount rate is bounded above by the maxDiscountRatePerYear parameter, providing a deterministic price floor against adverse market dislocations.

#### Discount Rate Parameters

| Parameter                  | PT-USDG-24SEP2026 |
| -------------------------- | ----------------- |
| initialDiscountRatePerYear | 4.50%             |
| maxDiscountRatePerYear     | 10.38%            |

### Disclaimer

This review was independently prepared by LlamaRisk, a DeFi risk service provider funded in part by the Aave DAO. LlamaRisk did not receive compensation from the protocol(s) or their affiliated entities for this work. The information should not be construed as legal, financial, tax, or professional advice.
[/quote]
