```diff
diff --git a/etherscan/A_TOKEN_V3_OLD/AToken/lib/aave-v3-core/contracts/protocol/tokenization/AToken.sol b/etherscan/A_TOKEN_V3/AToken/lib/aave-v3-core/contracts/protocol/tokenization/AToken.sol
index 845b09f..e6aae82 100644
--- a/etherscan/A_TOKEN_V3_OLD/AToken/lib/aave-v3-core/contracts/protocol/tokenization/AToken.sol
+++ b/etherscan/A_TOKEN_V3/AToken/lib/aave-v3-core/contracts/protocol/tokenization/AToken.sol
@@ -28,7 +28,7 @@ contract AToken is VersionedInitializable, ScaledBalanceTokenBase, EIP712Base, I
   bytes32 public constant PERMIT_TYPEHASH =
     keccak256('Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)');
 
-  uint256 public constant ATOKEN_REVISION = 0x2;
+  uint256 public constant ATOKEN_REVISION = 0x3;
 
   address internal _treasury;
   address internal _underlyingAsset;
```
