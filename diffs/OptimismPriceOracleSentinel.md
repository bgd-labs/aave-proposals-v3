```diff
diff --git a/etherscan/OptimismPriceOracleSentinel/PriceOracleSentinel/@aave/core-v3/contracts/protocol/configuration/PriceOracleSentinel.sol b/etherscan/OptimismPriceOracleSentinelNew/PriceOracleSentinel/src/core/contracts/protocol/configuration/PriceOracleSentinel.sol
index 1ee932a..c9fe465 100644
--- a/etherscan/OptimismPriceOracleSentinel/PriceOracleSentinel/@aave/core-v3/contracts/protocol/configuration/PriceOracleSentinel.sol
+++ b/etherscan/OptimismPriceOracleSentinelNew/PriceOracleSentinel/src/core/contracts/protocol/configuration/PriceOracleSentinel.sol
@@ -1,5 +1,5 @@
-// SPDX-License-Identifier: BUSL-1.1
-pragma solidity 0.8.10;
+// SPDX-License-Identifier: MIT
+pragma solidity ^0.8.10;
 
 import {Errors} from '../libraries/helpers/Errors.sol';
 import {IPoolAddressesProvider} from '../../interfaces/IPoolAddressesProvider.sol';
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
