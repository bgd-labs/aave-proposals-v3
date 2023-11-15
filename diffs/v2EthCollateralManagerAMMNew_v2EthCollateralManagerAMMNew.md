```diff
diff --git a/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/ILiquidationsGraceSentinel.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/ILiquidationsGraceSentinel.sol
new file mode 100644
index 0000000..f61895d
--- /dev/null
+++ b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/ILiquidationsGraceSentinel.sol
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: agpl-3.0
+pragma solidity 0.6.12;
+
+interface ILiquidationsGraceSentinel {
+  /**
+   * @dev Emitted when a new grace period is set
+   * @param asset Address of the underlying asset listed on Aave
+   * @param until Timestamp until the grace period will be activated
+   **/
+  event GracePeriodSet(address indexed asset, uint40 until);
+
+  /**
+   * @dev Returns until when a grace period is enabled
+   * @param asset Address of the underlying asset listed on Aave
+   **/
+  function gracePeriodUntil(address asset) external view returns (uint40);
+
+  /// @notice Function to set grace period to one or multiple Aave underlyings
+  /// @dev To enable a grace period, a timestamp in the future should be set,
+  ///      To disable a grace period, any timestamp in the past works, like 0
+  /// @param assets Address of the underlying asset listed on Aave
+  /// @param until Timestamp when the liquidations' grace period will end
+  function setGracePeriods(address[] calldata assets, uint40[] calldata until) external;
+}
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/dependencies/openzeppelin/contracts/Address.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/dependencies/openzeppelin/contracts/Address.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/dependencies/openzeppelin/contracts/Address.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/dependencies/openzeppelin/contracts/Address.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/dependencies/openzeppelin/contracts/IERC20.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/dependencies/openzeppelin/contracts/IERC20.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/dependencies/openzeppelin/contracts/IERC20.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/dependencies/openzeppelin/contracts/IERC20.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/dependencies/openzeppelin/contracts/SafeERC20.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/dependencies/openzeppelin/contracts/SafeERC20.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/dependencies/openzeppelin/contracts/SafeERC20.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/dependencies/openzeppelin/contracts/SafeERC20.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/dependencies/openzeppelin/contracts/SafeMath.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/dependencies/openzeppelin/contracts/SafeMath.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/dependencies/openzeppelin/contracts/SafeMath.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/dependencies/openzeppelin/contracts/SafeMath.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/IAToken.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/IAToken.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/IAToken.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/IAToken.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/ILendingPoolAddressesProvider.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/ILendingPoolAddressesProvider.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/ILendingPoolAddressesProvider.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/ILendingPoolAddressesProvider.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/ILendingPoolCollateralManager.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/ILendingPoolCollateralManager.sol
similarity index 88%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/ILendingPoolCollateralManager.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/ILendingPoolCollateralManager.sol
index ed70ea0..1b76650 100644
--- a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/ILendingPoolCollateralManager.sol
+++ b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/ILendingPoolCollateralManager.sol
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: agpl-3.0
 pragma solidity 0.6.12;
+import {ILiquidationsGraceSentinel} from '../../../../ILiquidationsGraceSentinel.sol';
 
 /**
  * @title ILendingPoolCollateralManager
@@ -57,4 +58,10 @@ interface ILendingPoolCollateralManager {
     uint256 debtToCover,
     bool receiveAToken
   ) external returns (uint256, string memory);
+
+  /**
+   * @dev Function to get an address LiquidationsGraceSentinel
+   * @return ILiquidationsGraceSentinel
+   **/
+  function LIQUIDATIONS_GRACE_SENTINEL() external view returns (ILiquidationsGraceSentinel);
 }
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/IPriceOracleGetter.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/IPriceOracleGetter.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/IPriceOracleGetter.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/IPriceOracleGetter.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/IReserveInterestRateStrategy.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/IReserveInterestRateStrategy.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/IReserveInterestRateStrategy.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/IReserveInterestRateStrategy.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/IScaledBalanceToken.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/IScaledBalanceToken.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/IScaledBalanceToken.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/IScaledBalanceToken.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/IStableDebtToken.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/IStableDebtToken.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/IStableDebtToken.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/IStableDebtToken.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/IVariableDebtToken.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/IVariableDebtToken.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/interfaces/IVariableDebtToken.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/interfaces/IVariableDebtToken.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/lendingpool/LendingPoolCollateralManager.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/lendingpool/LendingPoolCollateralManager.sol
similarity index 94%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/lendingpool/LendingPoolCollateralManager.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/lendingpool/LendingPoolCollateralManager.sol
index ab08244..5917ef1 100644
--- a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/lendingpool/LendingPoolCollateralManager.sol
+++ b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/lendingpool/LendingPoolCollateralManager.sol
@@ -7,7 +7,7 @@ import {IAToken} from '../../interfaces/IAToken.sol';
 import {IStableDebtToken} from '../../interfaces/IStableDebtToken.sol';
 import {IVariableDebtToken} from '../../interfaces/IVariableDebtToken.sol';
 import {IPriceOracleGetter} from '../../interfaces/IPriceOracleGetter.sol';
-import {ILendingPoolCollateralManager} from '../../interfaces/ILendingPoolCollateralManager.sol';
+import {ILendingPoolCollateralManager, ILiquidationsGraceSentinel} from '../../interfaces/ILendingPoolCollateralManager.sol';
 import {VersionedInitializable} from '../libraries/aave-upgradeability/VersionedInitializable.sol';
 import {GenericLogic} from '../libraries/logic/GenericLogic.sol';
 import {Helpers} from '../libraries/helpers/Helpers.sol';
@@ -37,6 +37,7 @@ contract LendingPoolCollateralManager is
   using PercentageMath for uint256;
 
   uint256 internal constant LIQUIDATION_CLOSE_FACTOR_PERCENT = 5000;
+  ILiquidationsGraceSentinel public immutable override LIQUIDATIONS_GRACE_SENTINEL;
 
   struct LiquidationCallLocalVars {
     uint256 userCollateralBalance;
@@ -58,6 +59,10 @@ contract LendingPoolCollateralManager is
     string errorMsg;
   }
 
+  constructor(address liquidationsGraceRegistry) public {
+    LIQUIDATIONS_GRACE_SENTINEL = ILiquidationsGraceSentinel(liquidationsGraceRegistry);
+  }
+
   /**
    * @dev As thIS contract extends the VersionedInitializable contract to match the state
    * of the LendingPool contract, the getRevision() function is needed, but the value is not
@@ -91,6 +96,14 @@ contract LendingPoolCollateralManager is
 
     LiquidationCallLocalVars memory vars;
 
+    if (
+      address(LIQUIDATIONS_GRACE_SENTINEL) != address(0) &&
+      (LIQUIDATIONS_GRACE_SENTINEL.gracePeriodUntil(collateralAsset) >= uint40(block.timestamp) ||
+        LIQUIDATIONS_GRACE_SENTINEL.gracePeriodUntil(debtAsset) >= uint40(block.timestamp))
+    ) {
+      return (uint256(Errors.CollateralManagerErrors.ON_GRACE_PERIOD), Errors.LPCM_ON_GRACE_PERIOD);
+    }
+
     (, , , , vars.healthFactor) = GenericLogic.calculateUserAccountData(
       user,
       _reserves,
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/lendingpool/LendingPoolStorage.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/lendingpool/LendingPoolStorage.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/lendingpool/LendingPoolStorage.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/lendingpool/LendingPoolStorage.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/aave-upgradeability/VersionedInitializable.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/aave-upgradeability/VersionedInitializable.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/aave-upgradeability/VersionedInitializable.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/aave-upgradeability/VersionedInitializable.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/configuration/ReserveConfiguration.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/configuration/ReserveConfiguration.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/configuration/UserConfiguration.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/configuration/UserConfiguration.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/configuration/UserConfiguration.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/configuration/UserConfiguration.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/helpers/Errors.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/helpers/Errors.sol
similarity index 98%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/helpers/Errors.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/helpers/Errors.sol
index 8756d79..87d2033 100644
--- a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/helpers/Errors.sol
+++ b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/helpers/Errors.sol
@@ -103,6 +103,7 @@ library Errors {
   string public constant LP_NOT_CONTRACT = '78';
   string public constant SDT_STABLE_DEBT_OVERFLOW = '79';
   string public constant SDT_BURN_EXCEEDS_BALANCE = '80';
+  string public constant LPCM_ON_GRACE_PERIOD = '82';
 
   enum CollateralManagerErrors {
     NO_ERROR,
@@ -114,6 +115,7 @@ library Errors {
     NO_ACTIVE_RESERVE,
     HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD,
     INVALID_EQUAL_ASSETS_TO_SWAP,
-    FROZEN_RESERVE
+    FROZEN_RESERVE,
+    ON_GRACE_PERIOD
   }
 }
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/helpers/Helpers.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/helpers/Helpers.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/helpers/Helpers.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/helpers/Helpers.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/logic/GenericLogic.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/logic/GenericLogic.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/logic/GenericLogic.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/logic/GenericLogic.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/logic/ReserveLogic.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/logic/ReserveLogic.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/logic/ReserveLogic.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/logic/ReserveLogic.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/logic/ValidationLogic.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/logic/ValidationLogic.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/logic/ValidationLogic.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/logic/ValidationLogic.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/math/MathUtils.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/math/MathUtils.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/math/MathUtils.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/math/MathUtils.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/math/PercentageMath.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/math/PercentageMath.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/math/PercentageMath.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/math/PercentageMath.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/math/WadRayMath.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/math/WadRayMath.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/math/WadRayMath.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/math/WadRayMath.sol
diff --git a/etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/types/DataTypes.sol b/etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/types/DataTypes.sol
similarity index 100%
rename from etherscan/v2EthCollateralManagerAMM/LendingPoolCollateralManager/contracts/protocol/libraries/types/DataTypes.sol
rename to etherscan/v2EthCollateralManagerAMMNew/LendingPoolCollateralManager/src/v2EthLendingPoolCollateralManager/LendingPoolCollateralManager/contracts/protocol/libraries/types/DataTypes.sol
```
