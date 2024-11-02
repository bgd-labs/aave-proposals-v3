```diff
diff --git a/etherscan/STABLE_PRICE_CAP_V3_OLD/PriceCapAdapterStable/src/contracts/PriceCapAdapterStable.sol b/etherscan/STABLE_PRICE_CAP_V3/PriceCapAdapterStable/src/contracts/PriceCapAdapterStable.sol
index a995aa3..cebf486 100644
--- a/etherscan/STABLE_PRICE_CAP_V3_OLD/PriceCapAdapterStable/src/contracts/PriceCapAdapterStable.sol
+++ b/etherscan/STABLE_PRICE_CAP_V3/PriceCapAdapterStable/src/contracts/PriceCapAdapterStable.sol
@@ -24,27 +24,19 @@ contract PriceCapAdapterStable is IPriceCapAdapterStable {
   int256 internal _priceCap;
 
   /**
-   * @param aclManager ACL manager contract
-   * @param assetToUsdAggregator the address of (underlyingAsset / USD) price feed
-   * @param adapterDescription the capped (lstAsset / underlyingAsset) pair description
-   * @param priceCap the price cap
+   * @param capAdapterStableParams parameters to create stable cap adapter
    */
-  constructor(
-    IACLManager aclManager,
-    IChainlinkAggregator assetToUsdAggregator,
-    string memory adapterDescription,
-    int256 priceCap
-  ) {
-    if (address(aclManager) == address(0)) {
+  constructor(CapAdapterStableParams memory capAdapterStableParams) {
+    if (address(capAdapterStableParams.aclManager) == address(0)) {
       revert ACLManagerIsZeroAddress();
     }
 
-    ASSET_TO_USD_AGGREGATOR = assetToUsdAggregator;
-    ACL_MANAGER = aclManager;
-    description = adapterDescription;
-    decimals = assetToUsdAggregator.decimals();
+    ASSET_TO_USD_AGGREGATOR = capAdapterStableParams.assetToUsdAggregator;
+    ACL_MANAGER = capAdapterStableParams.aclManager;
+    description = capAdapterStableParams.adapterDescription;
+    decimals = ASSET_TO_USD_AGGREGATOR.decimals();
 
-    _setPriceCap(priceCap);
+    _setPriceCap(capAdapterStableParams.priceCap);
   }
 
   /// @inheritdoc ICLSynchronicityPriceAdapter
@@ -68,6 +60,11 @@ contract PriceCapAdapterStable is IPriceCapAdapterStable {
     _setPriceCap(priceCap);
   }
 
+  /// @inheritdoc IPriceCapAdapterStable
+  function getPriceCap() external view returns (int256) {
+    return _priceCap;
+  }
+
   /// @inheritdoc IPriceCapAdapterStable
   function isCapped() public view virtual returns (bool) {
     return (ASSET_TO_USD_AGGREGATOR.latestAnswer() > this.latestAnswer());
```
