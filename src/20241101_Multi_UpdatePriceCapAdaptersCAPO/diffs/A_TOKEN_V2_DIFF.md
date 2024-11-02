```diff
diff --git a/etherscan/A_TOKEN_V2_OLD/AToken/lib/protocol-v2/contracts/protocol/tokenization/AToken.sol b/etherscan/A_TOKEN_V2/AToken/lib/protocol-v2/contracts/protocol/tokenization/AToken.sol
index fec453e..53e17b2 100644
--- a/etherscan/A_TOKEN_V2_OLD/AToken/lib/protocol-v2/contracts/protocol/tokenization/AToken.sol
+++ b/etherscan/A_TOKEN_V2/AToken/lib/protocol-v2/contracts/protocol/tokenization/AToken.sol
@@ -30,7 +30,7 @@ contract AToken is
   bytes32 public constant PERMIT_TYPEHASH =
     keccak256('Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)');
 
-  uint256 public constant ATOKEN_REVISION = 0x2;
+  uint256 public constant ATOKEN_REVISION = 0x3;
 
   /// @dev owner => next valid nonce to submit with permit()
   mapping(address => uint256) public _nonces;
```
