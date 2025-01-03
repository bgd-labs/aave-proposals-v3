// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPool {
  struct LockOrBurnInV1 {
    bytes receiver;
    uint64 remoteChainSelector;
    address originalSender;
    uint256 amount;
    address localToken;
  }

  struct LockOrBurnOutV1 {
    bytes destTokenAddress;
    bytes destPoolData;
  }

  struct ReleaseOrMintInV1 {
    bytes originalSender;
    uint64 remoteChainSelector;
    address receiver;
    uint256 amount;
    address localToken;
    bytes sourcePoolAddress;
    bytes sourcePoolData;
    bytes offchainTokenData;
  }

  struct ReleaseOrMintOutV1 {
    uint256 destinationAmount;
  }
}
