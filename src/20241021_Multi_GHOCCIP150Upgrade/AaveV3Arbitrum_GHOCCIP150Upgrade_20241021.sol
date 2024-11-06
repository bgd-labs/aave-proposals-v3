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

  // https://arbiscan.io/address/0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73
  address public constant TOKEN_POOL_IMPL = 0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73;
  // https://arbiscan.io/address/0x26329558f08cbb40d6a4CCA0E0C67b29D64A8c50
  address public constant GHO_CCIP_PROXY_POOL = 0x26329558f08cbb40d6a4CCA0E0C67b29D64A8c50;

  /// @dev Token Rate Limit Capacity: 300_000 GHO
  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = 300_000e18;

  /// @dev Token Rate Limit Refill Rate: 60 GHO per second (=> 216_000 GHO per hour)
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE = 60e18;

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
    IRateLimiter.Config memory rateLimitConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: CCIP_RATE_LIMIT_CAPACITY,
      rate: CCIP_RATE_LIMIT_REFILL_RATE
    });
    tokenPoolProxy.setChainRateLimiterConfig(ETH_CHAIN_SELECTOR, rateLimitConfig, rateLimitConfig);
  }
}
