// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {UpgradeableBurnMintTokenPool} from 'aave-ccip/v0.8/ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {RateLimiter} from 'aave-ccip/v0.8/ccip/libraries/RateLimiter.sol';

/**
 * @title GHO CCIP 1.50 Upgrade
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/51
 */
contract AaveV3Arbitrum_GHOCCIP150Upgrade_20241021 is IProposalGenericExecutor {
  address public constant GHO_CCIP_PROXY_POOL = 0x26329558f08cbb40d6a4CCA0E0C67b29D64A8c50;
  uint64 public constant ETH_CHAIN_SELECTOR = 5009297550715157269;

  function execute() external {
    UpgradeableBurnMintTokenPool tokenPoolProxy = UpgradeableBurnMintTokenPool(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL
    );

    // Deploy new tokenPool implementation, retain existing immutable configuration
    address tokenPoolImpl = address(
      new UpgradeableBurnMintTokenPool(
        address(tokenPoolProxy.getToken()),
        tokenPoolProxy.getArmProxy(),
        tokenPoolProxy.getAllowListEnabled()
      )
    );

    ProxyAdmin(MiscArbitrum.PROXY_ADMIN).upgrade(
      TransparentUpgradeableProxy(payable(address(tokenPoolProxy))),
      tokenPoolImpl
    );

    // Update proxyPool address
    tokenPoolProxy.setProxyPool(GHO_CCIP_PROXY_POOL);

    // Set rate limit
    tokenPoolProxy.setChainRateLimiterConfig(
      ETH_CHAIN_SELECTOR,
      getOutBoundRateLimiterConfig(),
      getInBoundRateLimiterConfig()
    );
  }

  /// @notice Returns the rate limiter configuration for the outbound rate limiter
  /// The onRamp rate limit for ARB => ETH will be as follows:
  /// Capacity: 350_000 GHO
  /// Rate: 100 GHO per second (=> 360_000 GHO per hour)
  /// @return The rate limiter configuration
  function getOutBoundRateLimiterConfig() public pure returns (RateLimiter.Config memory) {
    return RateLimiter.Config({isEnabled: true, capacity: 350_000e18, rate: 100e18});
  }

  /// @notice Returns the rate limiter configuration for the inbound rate limiter
  /// The offramp capacity for ETH => ARB will be disabled, as the outbound rate limit
  /// will be set on ETH token pool
  /// @return The rate limiter configuration
  function getInBoundRateLimiterConfig() public pure returns (RateLimiter.Config memory) {
    return RateLimiter.Config({isEnabled: false, capacity: 0, rate: 0});
  }
}
