```diff
diff --git a/etherscan/ArbitrumPriceOracleSentinel/PriceOracleSentinel/@aave/core-v3/contracts/protocol/configuration/PriceOracleSentinel.sol b/etherscan/ArbitrumPriceOracleSentinelNew/PriceOracleSentinel/src/core/contracts/protocol/configuration/PriceOracleSentinel.sol
index 27e4281..c9fe465 100644
--- a/etherscan/ArbitrumPriceOracleSentinel/PriceOracleSentinel/@aave/core-v3/contracts/protocol/configuration/PriceOracleSentinel.sol
+++ b/etherscan/ArbitrumPriceOracleSentinelNew/PriceOracleSentinel/src/core/contracts/protocol/configuration/PriceOracleSentinel.sol
@@ -1,5 +1,5 @@
-// SPDX-License-Identifier: BUSL-1.1
-pragma solidity 0.8.10;
+// SPDX-License-Identifier: MIT
+pragma solidity ^0.8.10;
 
 import {Errors} from '../libraries/helpers/Errors.sol';
 import {IPoolAddressesProvider} from '../../interfaces/IPoolAddressesProvider.sol';
@@ -17,7 +17,7 @@ import {IACLManager} from '../../interfaces/IACLManager.sol';
 contract PriceOracleSentinel is IPriceOracleSentinel {
   /**
    * @dev Only pool admin can call functions marked by this modifier.
-   **/
+   */
   modifier onlyPoolAdmin() {
     IACLManager aclManager = IACLManager(ADDRESSES_PROVIDER.getACLManager());
     require(aclManager.isPoolAdmin(msg.sender), Errors.CALLER_NOT_POOL_ADMIN);
@@ -26,7 +26,7 @@ contract PriceOracleSentinel is IPriceOracleSentinel {
 
   /**
    * @dev Only risk or pool admin can call functions marked by this modifier.
-   **/
+   */
   modifier onlyRiskOrPoolAdmins() {
     IACLManager aclManager = IACLManager(ADDRESSES_PROVIDER.getACLManager());
     require(
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
