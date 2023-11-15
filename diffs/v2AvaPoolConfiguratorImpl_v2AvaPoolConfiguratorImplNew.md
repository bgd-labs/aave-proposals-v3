```diff
diff --git a/etherscan/v2AvaPoolConfiguratorImplFlattened.sol b/etherscan/v2AvaPoolConfiguratorImplNewFlattened.sol
index a9f418d..4229340 100644
--- a/etherscan/v2AvaPoolConfiguratorImplFlattened.sol
+++ b/etherscan/v2AvaPoolConfiguratorImplNewFlattened.sol
@@ -636,6 +636,7 @@ library Errors {
   string public constant LP_NOT_CONTRACT = '78';
   string public constant SDT_STABLE_DEBT_OVERFLOW = '79';
   string public constant SDT_BURN_EXCEEDS_BALANCE = '80';
+  string public constant LPC_CALLER_NOT_POOL_OR_EMERGENCY_ADMIN = '83'; // 'The caller must be the emergency or pool admin'
 
   enum CollateralManagerErrors {
     NO_ERROR,
@@ -1609,132 +1610,7 @@ library PercentageMath {
 }
 
 interface IAaveIncentivesController {
-  event RewardsAccrued(address indexed user, uint256 amount);
-
-  event RewardsClaimed(address indexed user, address indexed to, uint256 amount);
-
-  event RewardsClaimed(
-    address indexed user,
-    address indexed to,
-    address indexed claimer,
-    uint256 amount
-  );
-
-  event ClaimerSet(address indexed user, address indexed claimer);
-
-  /*
-   * @dev Returns the configuration of the distribution for a certain asset
-   * @param asset The address of the reference asset of the distribution
-   * @return The asset index, the emission per second and the last updated timestamp
-   **/
-  function getAssetData(address asset) external view returns (uint256, uint256, uint256);
-
-  /*
-   * LEGACY **************************
-   * @dev Returns the configuration of the distribution for a certain asset
-   * @param asset The address of the reference asset of the distribution
-   * @return The asset index, the emission per second and the last updated timestamp
-   **/
-  function assets(address asset) external view returns (uint128, uint128, uint256);
-
-  /**
-   * @dev Whitelists an address to claim the rewards on behalf of another address
-   * @param user The address of the user
-   * @param claimer The address of the claimer
-   */
-  function setClaimer(address user, address claimer) external;
-
-  /**
-   * @dev Returns the whitelisted claimer for a certain address (0x0 if not set)
-   * @param user The address of the user
-   * @return The claimer address
-   */
-  function getClaimer(address user) external view returns (address);
-
-  /**
-   * @dev Configure assets for a certain rewards emission
-   * @param assets The assets to incentivize
-   * @param emissionsPerSecond The emission for each asset
-   */
-  function configureAssets(
-    address[] calldata assets,
-    uint256[] calldata emissionsPerSecond
-  ) external;
-
-  /**
-   * @dev Called by the corresponding asset on any update that affects the rewards distribution
-   * @param asset The address of the user
-   * @param userBalance The balance of the user of the asset in the lending pool
-   * @param totalSupply The total supply of the asset in the lending pool
-   **/
-  function handleAction(address asset, uint256 userBalance, uint256 totalSupply) external;
-
-  /**
-   * @dev Returns the total of rewards of an user, already accrued + not yet accrued
-   * @param user The address of the user
-   * @return The rewards
-   **/
-  function getRewardsBalance(
-    address[] calldata assets,
-    address user
-  ) external view returns (uint256);
-
-  /**
-   * @dev Claims reward for an user, on all the assets of the lending pool, accumulating the pending rewards
-   * @param amount Amount of rewards to claim
-   * @param to Address that will be receiving the rewards
-   * @return Rewards claimed
-   **/
-  function claimRewards(
-    address[] calldata assets,
-    uint256 amount,
-    address to
-  ) external returns (uint256);
-
-  /**
-   * @dev Claims reward for an user on behalf, on all the assets of the lending pool, accumulating the pending rewards. The caller must
-   * be whitelisted via "allowClaimOnBehalf" function by the RewardsAdmin role manager
-   * @param amount Amount of rewards to claim
-   * @param user Address to check and claim rewards
-   * @param to Address that will be receiving the rewards
-   * @return Rewards claimed
-   **/
-  function claimRewardsOnBehalf(
-    address[] calldata assets,
-    uint256 amount,
-    address user,
-    address to
-  ) external returns (uint256);
-
-  /**
-   * @dev returns the unclaimed rewards of the user
-   * @param user the address of the user
-   * @return the unclaimed user rewards
-   */
-  function getUserUnclaimedRewards(address user) external view returns (uint256);
-
-  /**
-   * @dev returns the unclaimed rewards of the user
-   * @param user the address of the user
-   * @param asset The asset to incentivize
-   * @return the user index for the asset
-   */
-  function getUserAssetData(address user, address asset) external view returns (uint256);
-
-  /**
-   * @dev for backward compatibility with previous implementation of the Incentives controller
-   */
-  function REWARD_TOKEN() external view returns (address);
-
-  /**
-   * @dev for backward compatibility with previous implementation of the Incentives controller
-   */
-  function PRECISION() external view returns (uint8);
-
-  /**
-   * @dev Gets the distribution end timestamp of the emissions
-   */
-  function DISTRIBUTION_END() external view returns (uint256);
+  function handleAction(address user, uint256 userBalance, uint256 totalSupply) external;
 }
 
 /**
@@ -2036,7 +1912,16 @@ contract LendingPoolConfigurator is VersionedInitializable, ILendingPoolConfigur
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
@@ -2372,7 +2257,7 @@ contract LendingPoolConfigurator is VersionedInitializable, ILendingPoolConfigur
    *  but allows repayments, liquidations, rate rebalances and withdrawals
    * @param asset The address of the underlying asset of the reserve
    **/
-  function freezeReserve(address asset) external onlyPoolAdmin {
+  function freezeReserve(address asset) external onlyPoolOrEmergencyAdmin {
     DataTypes.ReserveConfigurationMap memory currentConfig = pool.getConfiguration(asset);
 
     currentConfig.setFrozen(true);
@@ -2386,7 +2271,7 @@ contract LendingPoolConfigurator is VersionedInitializable, ILendingPoolConfigur
    * @dev Unfreezes a reserve
    * @param asset The address of the underlying asset of the reserve
    **/
-  function unfreezeReserve(address asset) external onlyPoolAdmin {
+  function unfreezeReserve(address asset) external onlyPoolOrEmergencyAdmin {
     DataTypes.ReserveConfigurationMap memory currentConfig = pool.getConfiguration(asset);
 
     currentConfig.setFrozen(false);
```
