// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
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
 * 1. Deploy LockReleaseTokenPool
 * 2. Accept ownership of CCIP TokenPool
 * 3. Configure CCIP TokenPool for Arbitrum
 * 4. Configure CCIP TokenPool for Avalanche
 * 5. Accept administrator role from Chainlink token manager
 * 6. Link token to pool on Chainlink token admin registry
 */
contract AaveV3Ethereum_GHOAvaxLaunch_20241106 is IProposalGenericExecutor {
  address public constant CCIP_RMN_PROXY = 0x411dE17f12D1A34ecC7F45f49844626267c75e81;
  address public constant CCIP_ROUTER = 0xF4c7E640EdA248ef95972845a62bdC74237805dB;
  // TODO: Wait for token admin registry to be deployed, and get proper address
  address public constant CCIP_TOKEN_ADMIN_REGISTRY = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
  uint256 public constant CCIP_BRIDGE_LIMIT = 25_000_000e18; // 25M
  uint64 public constant CCIP_ARB_CHAIN_SELECTOR = 4949039107694359620;
  uint64 public constant CCIP_AVAX_CHAIN_SELECTOR = 6433500567565415381;

  function execute() external {
    // 1. Deploy LockReleaseTokenPool
    address tokenPool = _deployCcipTokenPool();

    // 2. Accept TokenPool ownership
    UpgradeableLockReleaseTokenPool(tokenPool).acceptOwnership();

    // 3. Configure CCIP for Arbitrum
    // TODO: Set remote pool and token addresses after deployment?
    _configureCcipTokenPool(tokenPool, CCIP_ARB_CHAIN_SELECTOR, address(0), address(0));

    // 4. Configure CCIP for Avalanche
    // TODO: Set remote pool and token addresses after deployment?
    _configureCcipTokenPool(tokenPool, CCIP_AVAX_CHAIN_SELECTOR, address(0), address(0));

    // 5. Accept Administrator role from Chainlink token manager
    TokenAdminRegistry(CCIP_TOKEN_ADMIN_REGISTRY).acceptAdminRole(MiscEthereum.GHO_TOKEN);

    // 6. Link token to pool on Chainlink token admin registry
    TokenAdminRegistry(CCIP_TOKEN_ADMIN_REGISTRY).setPool(MiscEthereum.GHO_TOKEN, tokenPool);

    // TODO: Migrate funds?
  }

  function _deployCcipTokenPool() internal returns (address) {
    address imple = address(
      new UpgradeableLockReleaseTokenPool(MiscEthereum.GHO_TOKEN, CCIP_RMN_PROXY, false, true)
    );

    bytes memory tokenPoolInitParams = abi.encodeWithSignature(
      'initialize(address,address[],address,uint256)',
      GovernanceV3Ethereum.EXECUTOR_LVL_1, // owner
      new address[](0), // allowList
      CCIP_ROUTER, // router
      CCIP_BRIDGE_LIMIT // bridgeLimit
    );
    return
      address(
        new TransparentUpgradeableProxy(imple, MiscEthereum.PROXY_ADMIN, tokenPoolInitParams)
      );
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
    chainUpdates[0] = UpgradeableTokenPool.ChainUpdate({
      remoteChainSelector: chainSelector,
      allowed: true,
      remotePoolAddress: abi.encode(remotePool),
      remoteTokenAddress: abi.encode(remoteToken),
      outboundRateLimiterConfig: rateConfig,
      inboundRateLimiterConfig: rateConfig
    });
    UpgradeableLockReleaseTokenPool(tokenPool).applyChainUpdates(chainUpdates);
  }
}
