```diff
diff --git a/etherscan/v2PolPoolConfiguratorImplFlattened.sol b/etherscan/v2PolPoolConfiguratorImplNewFlattened.sol
index 1a96fa8..4229340 100644
--- a/etherscan/v2PolPoolConfiguratorImplFlattened.sol
+++ b/etherscan/v2PolPoolConfiguratorImplNewFlattened.sol
@@ -636,6 +636,7 @@ library Errors {
   string public constant LP_NOT_CONTRACT = '78';
   string public constant SDT_STABLE_DEBT_OVERFLOW = '79';
   string public constant SDT_BURN_EXCEEDS_BALANCE = '80';
+  string public constant LPC_CALLER_NOT_POOL_OR_EMERGENCY_ADMIN = '83'; // 'The caller must be the emergency or pool admin'
 
   enum CollateralManagerErrors {
     NO_ERROR,
@@ -1911,7 +1912,16 @@ contract LendingPoolConfigurator is VersionedInitializable, ILendingPoolConfigur
     _;
   }
 
-  uint256 internal constant CONFIGURATOR_REVISION = 0x1;
+  modifier onlyPoolOrEmergencyAdmin() {
+    require(
+      addressesProvider.getPoolAdmin() == msg.sender ||
+        addressesProvider.getEmergencyAdmin() == msg.sender,
+      Errors.LPC_CALLER_NOT_POOL_OR_EMERGENCY_ADMIN
+    );
+    _;
+  }
+
+  uint256 internal constant CONFIGURATOR_REVISION = 0x2;
 
   function getRevision() internal pure override returns (uint256) {
     return CONFIGURATOR_REVISION;
@@ -2247,7 +2257,7 @@ contract LendingPoolConfigurator is VersionedInitializable, ILendingPoolConfigur
    *  but allows repayments, liquidations, rate rebalances and withdrawals
    * @param asset The address of the underlying asset of the reserve
    **/
-  function freezeReserve(address asset) external onlyPoolAdmin {
+  function freezeReserve(address asset) external onlyPoolOrEmergencyAdmin {
     DataTypes.ReserveConfigurationMap memory currentConfig = pool.getConfiguration(asset);
 
     currentConfig.setFrozen(true);
@@ -2261,7 +2271,7 @@ contract LendingPoolConfigurator is VersionedInitializable, ILendingPoolConfigur
    * @dev Unfreezes a reserve
    * @param asset The address of the underlying asset of the reserve
    **/
-  function unfreezeReserve(address asset) external onlyPoolAdmin {
+  function unfreezeReserve(address asset) external onlyPoolOrEmergencyAdmin {
     DataTypes.ReserveConfigurationMap memory currentConfig = pool.getConfiguration(asset);
 
     currentConfig.setFrozen(false);
```
