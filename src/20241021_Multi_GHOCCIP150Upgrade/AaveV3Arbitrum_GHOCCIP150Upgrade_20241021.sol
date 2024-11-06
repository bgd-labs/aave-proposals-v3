// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {IUpgradeableBurnMintTokenPool} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';

/**
 * @title GHO CCIP 1.50 Upgrade
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/51
 */
contract AaveV3Arbitrum_GHOCCIP150Upgrade_20241021 is IProposalGenericExecutor {
  uint64 public constant ETH_CHAIN_SELECTOR = 5009297550715157269;

  // https://arbiscan.io/address/0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1
  address public constant TOKEN_POOL_IMPL = 0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1;
  // https://arbiscan.io/address/0x26329558f08cbb40d6a4CCA0E0C67b29D64A8c50
  address public constant GHO_CCIP_PROXY_POOL = 0x26329558f08cbb40d6a4CCA0E0C67b29D64A8c50;

  function execute() external {
    IUpgradeableBurnMintTokenPool tokenPoolProxy = IUpgradeableBurnMintTokenPool(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL
    );

    ProxyAdmin(MiscArbitrum.PROXY_ADMIN).upgrade(
      TransparentUpgradeableProxy(payable(address(tokenPoolProxy))),
      TOKEN_POOL_IMPL
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
  /// Capacity: 300_000 GHO
  /// Rate: 60 GHO per second (=> 216_000 GHO per hour)
  /// @return The rate limiter configuration
  function getOutBoundRateLimiterConfig() public pure returns (IRateLimiter.Config memory) {
    return IRateLimiter.Config({isEnabled: true, capacity: 300_000e18, rate: 60e18});
  }

  /// @notice Returns the rate limiter configuration for the inbound rate limiter
  /// The offRamp rate limit for ETH => ARB will be as follows:
  /// Capacity: 350_000 GHO
  /// Rate: 60 GHO per second (=> 216_000 GHO per hour)
  /// @return The rate limiter configuration
  function getInBoundRateLimiterConfig() public pure returns (IRateLimiter.Config memory) {
    return IRateLimiter.Config({isEnabled: true, capacity: 300_000e18, rate: 60e18});
  }
}
