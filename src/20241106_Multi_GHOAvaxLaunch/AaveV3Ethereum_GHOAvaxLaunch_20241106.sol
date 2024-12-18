// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {UpgradeableLockReleaseTokenPool} from 'ccip/pools/GHO/UpgradeableLockReleaseTokenPool.sol';
import {UpgradeableTokenPool} from 'ccip/pools/GHO/UpgradeableTokenPool.sol';
import {RateLimiter} from 'ccip/libraries/RateLimiter.sol';
import {TokenAdminRegistry} from 'ccip/tokenAdminRegistry/TokenAdminRegistry.sol';

/**
 * @title GHO Avax Launch
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x2aed7eb8b03cb3f961cbf790bf2e2e1e449f841a4ad8bdbcdd223bb6ac69e719
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-avalanche-set-aci-as-emissions-manager-for-rewards/19339
 * @dev This payload consists of the following set of actions:
 * 1. Accept ownership of CCIP TokenPool
 * 2. Configure CCIP TokenPool for Arbitrum
 * 3. Configure CCIP TokenPool for Avalanche
 * 4. Accept administrator role from Chainlink token manager
 * 5. Link token to pool on Chainlink token admin registry
 */
contract AaveV3Ethereum_GHOAvaxLaunch_20241106 is IProposalGenericExecutor {
  address public constant CCIP_RMN_PROXY = 0x411dE17f12D1A34ecC7F45f49844626267c75e81;
  address public constant CCIP_ROUTER = 0xF4c7E640EdA248ef95972845a62bdC74237805dB;
  address public constant CCIP_TOKEN_ADMIN_REGISTRY = 0xb22764f98dD05c789929716D677382Df22C05Cb6;
  // TODO: Wait until new token pool is deployed on Ethereum, then use corresponding address
  address public constant CCIP_TOKEN_POOL = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
  uint256 public constant CCIP_BRIDGE_LIMIT = 25_000_000e18; // 25M
  uint64 public constant CCIP_ARB_CHAIN_SELECTOR = 4949039107694359620;
  uint64 public constant CCIP_AVAX_CHAIN_SELECTOR = 6433500567565415381;

  function execute() external {
    // 1. Accept TokenPool ownership
    UpgradeableLockReleaseTokenPool(CCIP_TOKEN_POOL).acceptOwnership();

    // 2. Configure CCIP for Arbitrum
    // TODO: Set remote pool and token addresses after deployment?
    _configureCcipTokenPool(CCIP_TOKEN_POOL, CCIP_ARB_CHAIN_SELECTOR, address(0), address(0));

    // 3. Configure CCIP for Avalanche
    // TODO: Set remote pool and token addresses after deployment?
    _configureCcipTokenPool(CCIP_TOKEN_POOL, CCIP_AVAX_CHAIN_SELECTOR, address(0), address(0));

    // 4. Accept Administrator role from Chainlink token manager
    TokenAdminRegistry(CCIP_TOKEN_ADMIN_REGISTRY).acceptAdminRole(MiscEthereum.GHO_TOKEN);

    // 5. Link token to pool on Chainlink token admin registry
    TokenAdminRegistry(CCIP_TOKEN_ADMIN_REGISTRY).setPool(MiscEthereum.GHO_TOKEN, CCIP_TOKEN_POOL);
  }

  function _configureCcipTokenPool(
    address tokenPool,
    uint64 chainSelector,
    address remotePool,
    address remoteToken
  ) internal {
    UpgradeableTokenPool.ChainUpdate[] memory chainUpdates = new UpgradeableTokenPool.ChainUpdate[](
      1
    );
    RateLimiter.Config memory rateConfig = RateLimiter.Config({
      isEnabled: false,
      capacity: 0,
      rate: 0
    });
    bytes[] memory remotePools = new bytes[](1);
    remotePools[0] = abi.encode(remotePool);
    chainUpdates[0] = UpgradeableTokenPool.ChainUpdate({
      remoteChainSelector: chainSelector,
      remotePoolAddresses: remotePools,
      remoteTokenAddress: abi.encode(remoteToken),
      outboundRateLimiterConfig: rateConfig,
      inboundRateLimiterConfig: rateConfig
    });
    UpgradeableLockReleaseTokenPool(tokenPool).applyChainUpdates(new uint64[](0), chainUpdates);
  }
}