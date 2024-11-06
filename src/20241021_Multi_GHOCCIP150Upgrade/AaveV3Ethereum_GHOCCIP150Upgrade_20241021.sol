// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IUpgradeableLockReleaseTokenPool} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';

/**
 * @title GHO CCIP 1.50 Upgrade
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/51
 */
contract AaveV3Ethereum_GHOCCIP150Upgrade_20241021 is IProposalGenericExecutor {
  uint64 public constant ARB_CHAIN_SELECTOR = 4949039107694359620;

  // https://etherscan.io/address/0xb77E872A68C62CfC0dFb02C067Ecc3DA23B4bbf3
  address public constant TOKEN_POOL_IMPL = 0xb77E872A68C62CfC0dFb02C067Ecc3DA23B4bbf3;
  // https://etherscan.io/address/0x9Ec9F9804733df96D1641666818eFb5198eC50f0
  address public constant GHO_CCIP_PROXY_POOL = 0x9Ec9F9804733df96D1641666818eFb5198eC50f0;

  /// @dev Token Rate Limit Capacity: 300_000 GHO
  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = 300_000e18;

  /// @dev Token Rate Limit Refill Rate: 60 GHO per second (=> 216_000 GHO per hour)
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE = 60e18;

  function execute() external {
    IUpgradeableLockReleaseTokenPool tokenPoolProxy = IUpgradeableLockReleaseTokenPool(
      MiscEthereum.GHO_CCIP_TOKEN_POOL
    );

    ProxyAdmin(MiscEthereum.PROXY_ADMIN).upgrade(
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
    tokenPoolProxy.setChainRateLimiterConfig(ARB_CHAIN_SELECTOR, rateLimitConfig, rateLimitConfig);
  }
}
