```diff
diff --git a/etherscan/BasePriceOracleSentinel/PriceOracleSentinel/src/core/contracts/protocol/configuration/PriceOracleSentinel.sol b/etherscan/BasePriceOracleSentinelNew/PriceOracleSentinel/src/core/contracts/protocol/configuration/PriceOracleSentinel.sol
index ec2017a..c9fe465 100644
--- a/etherscan/BasePriceOracleSentinel/PriceOracleSentinel/src/core/contracts/protocol/configuration/PriceOracleSentinel.sol
+++ b/etherscan/BasePriceOracleSentinelNew/PriceOracleSentinel/src/core/contracts/protocol/configuration/PriceOracleSentinel.sol
@@ -69,8 +69,8 @@ contract PriceOracleSentinel is IPriceOracleSentinel {
    * @return True if the SequencerOracle is up and the grace period passed, false otherwise
    */
   function _isUpAndGracePeriodPassed() internal view returns (bool) {
-    (, int256 answer, , uint256 lastUpdateTimestamp, ) = _sequencerOracle.latestRoundData();
-    return answer == 0 && block.timestamp - lastUpdateTimestamp > _gracePeriod;
+    (, int256 answer, uint256 startedAt, , ) = _sequencerOracle.latestRoundData();
+    return answer == 0 && block.timestamp - startedAt > _gracePeriod;
   }
 
   /// @inheritdoc IPriceOracleSentinel
```
