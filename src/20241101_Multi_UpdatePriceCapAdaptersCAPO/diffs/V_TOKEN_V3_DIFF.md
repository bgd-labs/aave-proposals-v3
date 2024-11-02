```diff
diff --git a/etherscan/V_TOKEN_V3_OLD/VariableDebtToken/lib/aave-v3-core/contracts/protocol/tokenization/VariableDebtToken.sol b/etherscan/V_TOKEN_V3/VariableDebtToken/lib/aave-v3-core/contracts/protocol/tokenization/VariableDebtToken.sol
index fab5463..a538272 100644
--- a/etherscan/V_TOKEN_V3_OLD/VariableDebtToken/lib/aave-v3-core/contracts/protocol/tokenization/VariableDebtToken.sol
+++ b/etherscan/V_TOKEN_V3/VariableDebtToken/lib/aave-v3-core/contracts/protocol/tokenization/VariableDebtToken.sol
@@ -25,7 +25,7 @@ contract VariableDebtToken is DebtTokenBase, ScaledBalanceTokenBase, IVariableDe
   using WadRayMath for uint256;
   using SafeCast for uint256;
 
-  uint256 public constant DEBT_TOKEN_REVISION = 0x2;
+  uint256 public constant DEBT_TOKEN_REVISION = 0x3;
 
   /**
    * @dev Constructor.
```
