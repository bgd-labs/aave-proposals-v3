// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

struct L2TransactionRequestDirect {
  uint256 chainId;
  uint256 mintValue;
  address l2Contract;
  uint256 l2Value;
  bytes l2Calldata;
  uint256 l2GasLimit;
  uint256 l2GasPerPubdataByteLimit;
  bytes[] factoryDeps;
  address refundRecipient;
}

interface IBridgehub {
  function requestL2TransactionDirect(
    L2TransactionRequestDirect calldata _request
  ) external payable returns (bytes32 canonicalTxHash);
}
