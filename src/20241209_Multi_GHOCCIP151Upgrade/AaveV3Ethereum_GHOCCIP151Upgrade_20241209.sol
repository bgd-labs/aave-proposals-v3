// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IUpgradeableLockReleaseTokenPool_1_4, IUpgradeableLockReleaseTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableLockReleaseTokenPool.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IProxyPool} from 'src/interfaces/ccip/IProxyPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

/**
 * @title GHO CCIP 1.5.1 Upgrade
 * @author Aave Labs
 * - Discussion: TODO
 */
contract AaveV3Ethereum_GHOCCIP151Upgrade_20241209 is IProposalGenericExecutor {
  uint64 public constant ARB_CHAIN_SELECTOR = 4949039107694359620;

  // https://etherscan.io/address/0xb22764f98dD05c789929716D677382Df22C05Cb6
  ITokenAdminRegistry public constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0xb22764f98dD05c789929716D677382Df22C05Cb6);

  // https://etherscan.io/address/0x9Ec9F9804733df96D1641666818eFb5198eC50f0
  IProxyPool public constant EXISTING_PROXY_POOL =
    IProxyPool(0x9Ec9F9804733df96D1641666818eFb5198eC50f0);
  // https://etherscan.io/address/0x5756880B6a1EAba0175227bf02a7E87c1e02B28C
  IUpgradeableLockReleaseTokenPool_1_4 public constant EXISTING_TOKEN_POOL =
    IUpgradeableLockReleaseTokenPool_1_4(GhoEthereum.GHO_CCIP_TOKEN_POOL); // will be updated in address-book after AIP
  // https://etherscan.io/address/0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6
  IUpgradeableLockReleaseTokenPool_1_5_1 public constant NEW_TOKEN_POOL =
    IUpgradeableLockReleaseTokenPool_1_5_1(0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6);
  // https://etherscan.io/address/0xFAdC082665577b533e62A7B0E067f884cA5C5E8F
  address public constant NEW_GHO_CCIP_STEWARD = 0xFAdC082665577b533e62A7B0E067f884cA5C5E8F;

  // https://arbiscan.io/address/0x26329558f08cbb40d6a4CCA0E0C67b29D64A8c50
  address public constant EXISTING_REMOTE_POOL_ARB = 0x26329558f08cbb40d6a4CCA0E0C67b29D64A8c50; // ProxyPool on Arb
  // https://arbiscan.io/address/0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6
  address public constant NEW_REMOTE_POOL_ARB = 0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6;

  // Token Rate Limit Capacity: 300_000 GHO
  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = 300_000e18;
  // Token Rate Limit Refill Rate: 60 GHO per second (=> 216_000 GHO per hour)
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE = 60e18;

  function execute() external {
    _acceptOwnership();
    _migrateLiquidity();
    _setupAndRegisterNewPool();
  }

  // pre-req - chainlink transfers gho token pool ownership on token admin registry
  function _acceptOwnership() internal {
    EXISTING_PROXY_POOL.acceptOwnership();
    NEW_TOKEN_POOL.acceptOwnership();
    TOKEN_ADMIN_REGISTRY.acceptAdminRole(AaveV3EthereumAssets.GHO_UNDERLYING);
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
    IRateLimiter.Config memory rateLimiterConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: CCIP_RATE_LIMIT_CAPACITY,
      rate: CCIP_RATE_LIMIT_REFILL_RATE
    });

    IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate[]
      memory chains = new IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate[](1);

    bytes[] memory remotePoolAddresses = new bytes[](2);
    remotePoolAddresses[0] = abi.encode(EXISTING_REMOTE_POOL_ARB);
    remotePoolAddresses[1] = abi.encode(NEW_REMOTE_POOL_ARB);

    chains[0] = IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate({
      remoteChainSelector: ARB_CHAIN_SELECTOR,
      remotePoolAddresses: remotePoolAddresses,
      remoteTokenAddress: abi.encode(AaveV3ArbitrumAssets.GHO_UNDERLYING),
      outboundRateLimiterConfig: rateLimiterConfig,
      inboundRateLimiterConfig: rateLimiterConfig
    });

    // setup new pool
    NEW_TOKEN_POOL.applyChainUpdates({
      remoteChainSelectorsToRemove: new uint64[](0),
      chainsToAdd: chains
    });
    NEW_TOKEN_POOL.setRateLimitAdmin(NEW_GHO_CCIP_STEWARD);
    NEW_TOKEN_POOL.setBridgeLimitAdmin(NEW_GHO_CCIP_STEWARD);

    // register new pool
    TOKEN_ADMIN_REGISTRY.setPool(AaveV3EthereumAssets.GHO_UNDERLYING, address(NEW_TOKEN_POOL));
  }
}
