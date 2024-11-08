// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {UpgradeableBurnMintTokenPool} from 'ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {UpgradeableTokenPool} from 'ccip/pools/GHO/UpgradeableTokenPool.sol';
import {RateLimiter} from 'ccip/libraries/RateLimiter.sol';
import {TokenAdminRegistry} from 'ccip/tokenAdminRegistry/TokenAdminRegistry.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {IGhoToken} from 'gho-core/gho/interfaces/IGhoToken.sol';

/**
 * @title GHOAvaxLaunch
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x2aed7eb8b03cb3f961cbf790bf2e2e1e449f841a4ad8bdbcdd223bb6ac69e719
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-avalanche-set-aci-as-emissions-manager-for-rewards/19339
 * @dev This payload consists of the following set of actions:
 * 1. Accept ownership of CCIP TokenPool
 * 2. Configure CCIP TokenPool for Ethereum
 * 3. Configure CCIP TokenPool for Avalanche
 * 4. Add CCIP TokenPool as GHO Facilitator (allowing burn and mint)
 * 5. Accept administrator role from Chainlink token admin registry
 * 6. Link token to pool on Chainlink token admin registry
 */
contract AaveV3Arbitrum_GHOAvaxLaunch_20241106 is IProposalGenericExecutor {
  address public constant CCIP_RMN_PROXY = 0xC311a21e6fEf769344EB1515588B9d535662a145;
  address public constant CCIP_ROUTER = 0x141fa059441E0ca23ce184B6A78bafD2A517DdE8;
  // TODO: Wait for token admin registry to be deployed, and get proper address
  address public constant CCIP_TOKEN_ADMIN_REGISTRY = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
  // TODO: Wait until new token pool is deployed on Arbitrum, then use corresponding address
  address public constant CCIP_TOKEN_POOL = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
  uint256 public constant CCIP_BUCKET_CAPACITY = 1_000_000e18; // 1M
  uint64 public constant CCIP_ETH_CHAIN_SELECTOR = 5009297550715157269;
  uint64 public constant CCIP_AVAX_CHAIN_SELECTOR = 6433500567565415381;

  function execute() external {
    // 1. Accept TokenPool ownership
    UpgradeableBurnMintTokenPool(CCIP_TOKEN_POOL).acceptOwnership();

    // 2. Configure CCIP TokenPool for Ethereum
    // TODO: Set remote pool and token addresses after deployment?
    _configureCcipTokenPool(CCIP_TOKEN_POOL, CCIP_ETH_CHAIN_SELECTOR, address(0), address(0));

    // 3. Configure CCIP TokenPool for Avalanche
    // TODO: Set remote pool and token addresses after deployment?
    _configureCcipTokenPool(CCIP_TOKEN_POOL, CCIP_AVAX_CHAIN_SELECTOR, address(0), address(0));

    // 4. Add CCIP TokenPool as GHO Facilitator
    IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).grantRole(
      IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).FACILITATOR_MANAGER_ROLE(),
      GovernanceV3Arbitrum.EXECUTOR_LVL_1
    );
    IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).grantRole(
      IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
      GovernanceV3Arbitrum.EXECUTOR_LVL_1
    );
    IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).addFacilitator(
      CCIP_TOKEN_POOL,
      'CCIP TokenPool',
      uint128(CCIP_BUCKET_CAPACITY)
    );

    // 5. Accept administrator role from Chainlink token manager
    TokenAdminRegistry(CCIP_TOKEN_ADMIN_REGISTRY).acceptAdminRole(
      AaveV3ArbitrumAssets.GHO_UNDERLYING
    );

    // 6. Link token to pool on Chainlink token admin registry
    TokenAdminRegistry(CCIP_TOKEN_ADMIN_REGISTRY).setPool(
      AaveV3ArbitrumAssets.GHO_UNDERLYING,
      CCIP_TOKEN_POOL
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
    UpgradeableBurnMintTokenPool(tokenPool).applyChainUpdates(chainUpdates);
  }
}
