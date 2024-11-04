// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {UpgradeableLockReleaseTokenPool} from 'aave-ccip/v0.8/ccip/pools/GHO/UpgradeableLockReleaseTokenPool.sol';
import {RateLimiter} from 'aave-ccip/v0.8/ccip/libraries/RateLimiter.sol';

/**
 * @title GHO CCIP 1.50 Upgrade
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/51
 */
contract AaveV3Ethereum_GHOCCIP150Upgrade_20241021 is IProposalGenericExecutor {
  address public constant GHO_CCIP_PROXY_POOL = 0x9Ec9F9804733df96D1641666818eFb5198eC50f0;
  uint64 public constant ARB_CHAIN_SELECTOR = 4949039107694359620;

  function execute() external {
    UpgradeableLockReleaseTokenPool tokenPoolProxy = UpgradeableLockReleaseTokenPool(
      MiscEthereum.GHO_CCIP_TOKEN_POOL
    );

    // Deploy new tokenPool implementation, retain existing immutable configuration
    address tokenPoolImpl = address(
      new UpgradeableLockReleaseTokenPool(
        address(tokenPoolProxy.getToken()),
        tokenPoolProxy.getArmProxy(),
        tokenPoolProxy.getAllowListEnabled(),
        tokenPoolProxy.canAcceptLiquidity()
      )
    );

    ProxyAdmin(MiscEthereum.PROXY_ADMIN).upgrade(
      TransparentUpgradeableProxy(payable(address(tokenPoolProxy))),
      tokenPoolImpl
    );

    // Update proxyPool address
    tokenPoolProxy.setProxyPool(GHO_CCIP_PROXY_POOL);

    // Set rate limit
    tokenPoolProxy.setChainRateLimiterConfig(
      ARB_CHAIN_SELECTOR,
      getOutBoundRateLimiterConfig(),
      getInBoundRateLimiterConfig()
    );
  }

  /// @notice Returns the rate limiter configuration for the outbound rate limiter
  /// The onRamp rate limit for ETH => ARB will be as follows:
  /// Capacity: 350_000 GHO
  /// Rate: 100 GHO per second (=> 360_000 GHO per hour)
  /// @return The rate limiter configuration
  function getOutBoundRateLimiterConfig() public pure returns (RateLimiter.Config memory) {
    return RateLimiter.Config({isEnabled: true, capacity: 350_000e18, rate: 100e18});
  }

  /// @notice Returns the rate limiter configuration for the inbound rate limiter
  /// The offRamp rate limit for ARB=>ETH will be as follows:
  /// Capacity: 350_000 GHO
  /// Rate: 100 GHO per second (=> 360_000 GHO per hour)
  /// @return The rate limiter configuration
  function getInBoundRateLimiterConfig() public pure returns (RateLimiter.Config memory) {
    return RateLimiter.Config({isEnabled: true, capacity: 350_000e18, rate: 100e18});
  }
}
