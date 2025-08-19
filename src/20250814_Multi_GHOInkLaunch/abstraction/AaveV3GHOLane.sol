// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {GhoCCIPChains} from './constants/GhoCCIPChains.sol';

/**
 * @title AaveV3GHOLane
 * @author Aave Labs
 * @notice Proposal Executor that sets Aave V3 GHO Lane through CCIP
 */
abstract contract AaveV3GHOLane is IProposalGenericExecutor {
  IUpgradeableBurnMintTokenPool_1_5_1 public immutable TOKEN_POOL;

  constructor(GhoCCIPChains.ChainInfo memory localChainInfo) {
    TOKEN_POOL = IUpgradeableBurnMintTokenPool_1_5_1(localChainInfo.ghoCCIPTokenPool);
  }

  function execute() external virtual {
    _execute();
  }

  function lanesToAdd()
    public
    view
    virtual
    returns (IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[] memory);

  function lanesToRemove() public view virtual returns (uint64[] memory) {
    return new uint64[](0);
  }

  function _execute() internal virtual {
    TOKEN_POOL.applyChainUpdates({
      remoteChainSelectorsToRemove: lanesToRemove(),
      chainsToAdd: lanesToAdd()
    });
  }

  /////////////////////// Helper functions ///////////////////////

  function _defaultRateLimiterConfig() internal pure virtual returns (IRateLimiter.Config memory) {
    return IRateLimiter.Config({isEnabled: true, capacity: 1_500_000e18, rate: 300e18});
  }

  function _asChainUpdate(
    GhoCCIPChains.ChainInfo memory chainInfo,
    IRateLimiter.Config memory outboundRateLimiterConfig,
    IRateLimiter.Config memory inboundRateLimiterConfig
  ) internal pure returns (IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate memory) {
    bytes[] memory remotePoolAddresses = new bytes[](1);
    remotePoolAddresses[0] = abi.encode(chainInfo.ghoCCIPTokenPool);
    return
      IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate({
        remoteChainSelector: chainInfo.chainSelector,
        remotePoolAddresses: remotePoolAddresses,
        remoteTokenAddress: abi.encode(chainInfo.ghoToken),
        outboundRateLimiterConfig: outboundRateLimiterConfig,
        inboundRateLimiterConfig: inboundRateLimiterConfig
      });
  }

  function _asChainUpdateWithDefaultRateLimiterConfig(
    GhoCCIPChains.ChainInfo memory chainInfo
  ) internal pure returns (IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate memory) {
    IRateLimiter.Config memory defaultRateLimiterConfig = _defaultRateLimiterConfig();
    return _asChainUpdate(chainInfo, defaultRateLimiterConfig, defaultRateLimiterConfig);
  }

  function _asArray(
    IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate memory chainUpdate
  ) internal pure returns (IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[] memory) {
    IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[]
      memory chainUpdates = new IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[](1);
    chainUpdates[0] = chainUpdate;
    return chainUpdates;
  }
}
