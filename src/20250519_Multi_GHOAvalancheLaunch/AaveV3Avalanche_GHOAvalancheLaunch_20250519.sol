// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {GhoBase} from 'aave-address-book/GhoBase.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {GHOAvalancheLaunch} from './utils/GHOAvalancheLaunch.sol';

/**
 * @title GHO Avalanche Listing
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-avalanche-set-aci-as-emissions-manager-for-rewards
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x2aed7eb8b03cb3f961cbf790bf2e2e1e449f841a4ad8bdbcdd223bb6ac69e719
 */
contract AaveV3Avalanche_GHOAvalancheLaunch_20250519 is IProposalGenericExecutor {
  uint64 public constant BASE_CHAIN_SELECTOR = GHOAvalancheLaunch.BASE_CHAIN_SELECTOR;
  uint64 public constant ARB_CHAIN_SELECTOR = GHOAvalancheLaunch.ARB_CHAIN_SELECTOR;
  uint64 public constant ETH_CHAIN_SELECTOR = GHOAvalancheLaunch.ETH_CHAIN_SELECTOR;
  uint128 public constant CCIP_BUCKET_CAPACITY = GHOAvalancheLaunch.CCIP_BUCKET_CAPACITY;

  ITokenAdminRegistry public constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(GHOAvalancheLaunch.AVAX_TOKEN_ADMIN_REGISTRY);
  IUpgradeableBurnMintTokenPool_1_5_1 public constant TOKEN_POOL =
    IUpgradeableBurnMintTokenPool_1_5_1(GHOAvalancheLaunch.GHO_CCIP_TOKEN_POOL);

  IGhoToken public constant GHO_TOKEN = IGhoToken(GHOAvalancheLaunch.GHO_TOKEN);

  address public constant GHO_AAVE_STEWARD = GHOAvalancheLaunch.GHO_AAVE_CORE_STEWARD;
  address public constant GHO_BUCKET_STEWARD = GHOAvalancheLaunch.GHO_BUCKET_STEWARD;
  address public constant GHO_CCIP_STEWARD = GHOAvalancheLaunch.GHO_CCIP_STEWARD;

  address public constant REMOTE_TOKEN_POOL_ETH = GhoEthereum.GHO_CCIP_TOKEN_POOL;
  address public constant REMOTE_TOKEN_POOL_ARB = GhoArbitrum.GHO_CCIP_TOKEN_POOL;
  address public constant REMOTE_TOKEN_POOL_BASE = GhoBase.GHO_CCIP_TOKEN_POOL;

  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = GHOAvalancheLaunch.CCIP_RATE_LIMIT_CAPACITY;
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE =
    GHOAvalancheLaunch.CCIP_RATE_LIMIT_REFILL_RATE;

  function execute() external {
    _acceptOwnership();
    _setupStewardsAndTokenPoolOnGho();
    _setupRemoteAndRegisterTokenPool();
  }

  function _acceptOwnership() internal {
    TOKEN_ADMIN_REGISTRY.acceptAdminRole(address(GHO_TOKEN));
    TOKEN_POOL.acceptOwnership();
  }

  function _setupStewardsAndTokenPoolOnGho() internal {
    GHO_TOKEN.grantRole(GHO_TOKEN.FACILITATOR_MANAGER_ROLE(), GovernanceV3Avalanche.EXECUTOR_LVL_1);
    GHO_TOKEN.grantRole(GHO_TOKEN.BUCKET_MANAGER_ROLE(), GovernanceV3Avalanche.EXECUTOR_LVL_1);

    // Token Pool as facilitator
    GHO_TOKEN.addFacilitator(address(TOKEN_POOL), 'CCIP TokenPool v1.5.1', CCIP_BUCKET_CAPACITY);

    // Gho Aave Steward
    AaveV3Avalanche.ACL_MANAGER.grantRole(
      AaveV3Avalanche.ACL_MANAGER.RISK_ADMIN_ROLE(),
      GHO_AAVE_STEWARD
    );

    // Gho Bucket Steward
    GHO_TOKEN.grantRole(GHO_TOKEN.BUCKET_MANAGER_ROLE(), GHO_BUCKET_STEWARD);
    address[] memory facilitatorList = new address[](1);
    facilitatorList[0] = address(TOKEN_POOL);
    IGhoBucketSteward(GHO_BUCKET_STEWARD).setControlledFacilitator({
      facilitatorList: facilitatorList,
      approve: true
    });

    // Gho CCIP Steward
    TOKEN_POOL.setRateLimitAdmin(GHO_CCIP_STEWARD);
  }

  function _setupRemoteAndRegisterTokenPool() internal {
    IRateLimiter.Config memory rateLimiterConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: CCIP_RATE_LIMIT_CAPACITY,
      rate: CCIP_RATE_LIMIT_REFILL_RATE
    });

    IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[]
      memory chainsToAdd = new IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[](3);

    {
      bytes[] memory remotePoolAddresses = new bytes[](1);
      remotePoolAddresses[0] = abi.encode(REMOTE_TOKEN_POOL_ETH);
      chainsToAdd[0] = IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate({
        remoteChainSelector: ETH_CHAIN_SELECTOR,
        remotePoolAddresses: remotePoolAddresses,
        remoteTokenAddress: abi.encode(AaveV3EthereumAssets.GHO_UNDERLYING),
        outboundRateLimiterConfig: rateLimiterConfig,
        inboundRateLimiterConfig: rateLimiterConfig
      });
    }

    {
      bytes[] memory remotePoolAddresses = new bytes[](1);
      remotePoolAddresses[0] = abi.encode(REMOTE_TOKEN_POOL_ARB);
      chainsToAdd[1] = IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate({
        remoteChainSelector: ARB_CHAIN_SELECTOR,
        remotePoolAddresses: remotePoolAddresses,
        remoteTokenAddress: abi.encode(AaveV3ArbitrumAssets.GHO_UNDERLYING),
        outboundRateLimiterConfig: rateLimiterConfig,
        inboundRateLimiterConfig: rateLimiterConfig
      });
    }

    {
      bytes[] memory remotePoolAddresses = new bytes[](1);
      remotePoolAddresses[0] = abi.encode(REMOTE_TOKEN_POOL_BASE);
      chainsToAdd[2] = IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate({
        remoteChainSelector: BASE_CHAIN_SELECTOR,
        remotePoolAddresses: remotePoolAddresses,
        remoteTokenAddress: abi.encode(AaveV3BaseAssets.GHO_UNDERLYING),
        outboundRateLimiterConfig: rateLimiterConfig,
        inboundRateLimiterConfig: rateLimiterConfig
      });
    }

    // setup remote token pools
    TOKEN_POOL.applyChainUpdates({
      remoteChainSelectorsToRemove: new uint64[](0),
      chainsToAdd: chainsToAdd
    });

    // register token pool
    TOKEN_ADMIN_REGISTRY.setPool(address(GHO_TOKEN), address(TOKEN_POOL));
  }
}
