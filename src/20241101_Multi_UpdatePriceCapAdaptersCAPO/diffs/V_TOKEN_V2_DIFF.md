```diff
diff --git a/etherscan/V_TOKEN_V2_OLD/VariableDebtToken/contracts/protocol/tokenization/VariableDebtToken.sol b/etherscan/V_TOKEN_V2/VariableDebtToken/contracts/protocol/tokenization/VariableDebtToken.sol
index a7a2817..05da9e7 100644
--- a/etherscan/V_TOKEN_V2_OLD/VariableDebtToken/contracts/protocol/tokenization/VariableDebtToken.sol
+++ b/etherscan/V_TOKEN_V2/VariableDebtToken/contracts/protocol/tokenization/VariableDebtToken.sol
@@ -17,7 +17,7 @@ import {IAaveIncentivesController} from '../../interfaces/IAaveIncentivesControl
 contract VariableDebtToken is DebtTokenBase, IVariableDebtToken {
   using WadRayMath for uint256;
 
-  uint256 public constant DEBT_TOKEN_REVISION = 0x1;
+  uint256 public constant DEBT_TOKEN_REVISION = 0x2;
 
   ILendingPool internal _pool;
   address internal _underlyingAsset;
```
