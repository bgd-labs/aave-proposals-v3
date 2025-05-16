// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Gnosis.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {GhoBase} from 'aave-address-book/GhoBase.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {CCIPUtils} from './utils/CCIPUtils.sol';
import {GHOLaunchConstants} from './utils/GHOLaunchConstants.sol';

/**
 * @title GHO Gnosis Listing
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-gnosis-chain/21379
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x62996204d8466d603fe8c953176599db02a23f440a682ff15ba2d0ca63dda386
 */
contract AaveV3Gnosis_GHOGnosisLaunch_20250421 is IProposalGenericExecutor {
  uint64 public constant BASE_CHAIN_SELECTOR = CCIPUtils.BASE_CHAIN_SELECTOR;
  uint64 public constant ARB_CHAIN_SELECTOR = CCIPUtils.ARB_CHAIN_SELECTOR;
  uint64 public constant ETH_CHAIN_SELECTOR = CCIPUtils.ETH_CHAIN_SELECTOR;

  uint128 public constant CCIP_BUCKET_CAPACITY = GHOLaunchConstants.CCIP_BUCKET_CAPACITY; // 15M GHO

  // https://gnosisscan.io/address/0x73BC11423CBF14914998C23B0aFC9BE0cb5B2229
  ITokenAdminRegistry public constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(GHOLaunchConstants.GNO_TOKEN_ADMIN_REGISTRY);
  // https://gnosisscan.io/address/0xDe6539018B095353A40753Dc54C91C68c9487D4E
  IUpgradeableBurnMintTokenPool_1_5_1 public constant TOKEN_POOL =
    IUpgradeableBurnMintTokenPool_1_5_1(GHOLaunchConstants.GNO_TOKEN_POOL);

  // https://gnosisscan.io/address/0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73
  IGhoToken public constant GHO_TOKEN = IGhoToken(GHOLaunchConstants.GNO_GHO_TOKEN);

  // https://gnosisscan.io/address/0x6e637e1E48025E51315d50ab96d5b3be1971A715
  address public constant GHO_AAVE_STEWARD = GHOLaunchConstants.GNO_AAVE_STEWARD;
  // https://gnosisscan.io/address/0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee
  address public constant GHO_BUCKET_STEWARD = GHOLaunchConstants.GNO_BUCKET_STEWARD;
  // https://gnosisscan.io/address/0x06179f7C1be40863405f374E7f5F8806c728660A
  address public constant GHO_CCIP_STEWARD = GHOLaunchConstants.GNO_CCIP_STEWARD;

  // https://etherscan.io/address/0x06179f7C1be40863405f374E7f5F8806c728660A
  address public constant REMOTE_TOKEN_POOL_ETH = GhoEthereum.GHO_CCIP_TOKEN_POOL;
  // https://arbiscan.io/address/0xB94Ab28c6869466a46a42abA834ca2B3cECCA5eB
  address public constant REMOTE_TOKEN_POOL_ARB = GhoArbitrum.GHO_CCIP_TOKEN_POOL;
  // https://basescan.org/address/0xDe6539018B095353A40753Dc54C91C68c9487D4E
  address public constant REMOTE_TOKEN_POOL_BASE = GhoBase.GHO_CCIP_TOKEN_POOL;

  // Token Rate Limit Capacity: 300_000 GHO
  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = GHOLaunchConstants.CCIP_RATE_LIMIT_CAPACITY;
  // Token Rate Limit Refill Rate: 60 GHO per second (=> 216_000 GHO per hour)
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE =
    GHOLaunchConstants.CCIP_RATE_LIMIT_REFILL_RATE;

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
    GHO_TOKEN.grantRole(GHO_TOKEN.FACILITATOR_MANAGER_ROLE(), GovernanceV3Gnosis.EXECUTOR_LVL_1);
    GHO_TOKEN.grantRole(GHO_TOKEN.BUCKET_MANAGER_ROLE(), GovernanceV3Gnosis.EXECUTOR_LVL_1);

    // Token Pool as facilitator with 15M GHO capacity
    GHO_TOKEN.addFacilitator(address(TOKEN_POOL), 'CCIP TokenPool v1.5.1', CCIP_BUCKET_CAPACITY);

    // Gho Aave Steward
    AaveV3Gnosis.ACL_MANAGER.grantRole(
      AaveV3Gnosis.ACL_MANAGER.RISK_ADMIN_ROLE(),
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
