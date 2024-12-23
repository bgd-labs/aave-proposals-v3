// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IUpgradeableLockReleaseTokenPool_1_4, IUpgradeableLockReleaseTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableLockReleaseTokenPool.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

/**
 * @title GHO CCIP 1.5.1 Upgrade
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Ethereum_GHOCCIP151Upgrade_20241209 is IProposalGenericExecutor {
  uint64 public constant ARB_CHAIN_SELECTOR = 4949039107694359620;

  // https://etherscan.io/address/0xb22764f98dD05c789929716D677382Df22C05Cb6
  ITokenAdminRegistry public constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0xb22764f98dD05c789929716D677382Df22C05Cb6);

  // https://etherscan.io/address/0x5756880B6a1EAba0175227bf02a7E87c1e02B28C
  IUpgradeableLockReleaseTokenPool_1_4 public constant EXISTING_TOKEN_POOL =
    IUpgradeableLockReleaseTokenPool_1_4(0x5756880B6a1EAba0175227bf02a7E87c1e02B28C); // MiscEthereum.GHO_CCIP_TOKEN_POOL; will be updated in address-book after AIP
  IUpgradeableLockReleaseTokenPool_1_5_1 public immutable NEW_TOKEN_POOL;

  address public immutable NEW_GHO_CCIP_STEWARD;

  // https://arbiscan.io/address/0x26329558f08cbb40d6a4CCA0E0C67b29D64A8c50
  address public constant EXISTING_REMOTE_POOL_ARB = 0x26329558f08cbb40d6a4CCA0E0C67b29D64A8c50; // ProxyPool on Arb
  address public immutable NEW_REMOTE_POOL_ARB;

  constructor(address newTokenPoolEth, address newTokenPoolArb, address newGhoCcipSteward) {
    NEW_TOKEN_POOL = IUpgradeableLockReleaseTokenPool_1_5_1(newTokenPoolEth);
    NEW_REMOTE_POOL_ARB = newTokenPoolArb;
    NEW_GHO_CCIP_STEWARD = newGhoCcipSteward;
  }

  function execute() external {
    _acceptOwnership();
    _migrateLiquidity();
    _setupAndRegisterNewPool();
  }

  // pre-req - chainlink transfers gho token pool ownership on token admin registry
  function _acceptOwnership() internal {
    NEW_TOKEN_POOL.acceptOwnership();
    TOKEN_ADMIN_REGISTRY.acceptAdminRole(MiscEthereum.GHO_TOKEN);
  }

  function _migrateLiquidity() internal {
    EXISTING_TOKEN_POOL.setRebalancer(address(NEW_TOKEN_POOL));
    uint256 bridgeAmount = EXISTING_TOKEN_POOL.getCurrentBridgedAmount();
    NEW_TOKEN_POOL.transferLiquidity(address(EXISTING_TOKEN_POOL), bridgeAmount);
    NEW_TOKEN_POOL.setCurrentBridgedAmount(bridgeAmount);

    // disable existing pool
    EXISTING_TOKEN_POOL.setBridgeLimit(0);
  }

  function _setupAndRegisterNewPool() internal {
    bytes[] memory remotePoolAddresses = new bytes[](2);
    remotePoolAddresses[0] = abi.encode(EXISTING_REMOTE_POOL_ARB);
    remotePoolAddresses[1] = abi.encode(NEW_REMOTE_POOL_ARB);
    IRateLimiter.Config memory emptyRateLimiterConfig = IRateLimiter.Config({
      isEnabled: false,
      capacity: 0,
      rate: 0
    });

    IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate[]
      memory chains = new IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate[](1);

    chains[0] = IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate({
      remoteChainSelector: ARB_CHAIN_SELECTOR,
      remotePoolAddresses: remotePoolAddresses,
      remoteTokenAddress: abi.encode(AaveV3ArbitrumAssets.GHO_UNDERLYING),
      outboundRateLimiterConfig: emptyRateLimiterConfig,
      inboundRateLimiterConfig: emptyRateLimiterConfig
    });

    // setup new pool
    NEW_TOKEN_POOL.applyChainUpdates({
      remoteChainSelectorsToRemove: new uint64[](0),
      chainsToAdd: chains
    });
    NEW_TOKEN_POOL.setRateLimitAdmin(NEW_GHO_CCIP_STEWARD);
    NEW_TOKEN_POOL.setBridgeLimitAdmin(NEW_GHO_CCIP_STEWARD);

    // register new pool
    TOKEN_ADMIN_REGISTRY.setPool(MiscEthereum.GHO_TOKEN, address(NEW_TOKEN_POOL));
  }
}
