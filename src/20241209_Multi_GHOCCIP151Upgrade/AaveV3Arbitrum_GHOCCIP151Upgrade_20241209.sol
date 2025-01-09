// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ITransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {IUpgradeableBurnMintTokenPool_1_4, IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {IProxyPool} from 'src/interfaces/ccip/IProxyPool.sol';
import {ILegacyProxyAdmin} from 'src/interfaces/ILegacyProxyAdmin.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

/**
 * @title GHO CCIP 1.5.1 Upgrade
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/59
 */
contract AaveV3Arbitrum_GHOCCIP151Upgrade_20241209 is IProposalGenericExecutor {
  uint64 public constant ETH_CHAIN_SELECTOR = 5009297550715157269;

  // https://arbiscan.io/address/0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E
  ITokenAdminRegistry public constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E);

  // https://arbiscan.io/address/0x26329558f08cbb40d6a4CCA0E0C67b29D64A8c50
  IProxyPool public constant EXISTING_PROXY_POOL =
    IProxyPool(0x26329558f08cbb40d6a4CCA0E0C67b29D64A8c50);
  // https://arbiscan.io/address/0xF168B83598516A532a85995b52504a2Fa058C068
  IUpgradeableBurnMintTokenPool_1_4 public constant EXISTING_TOKEN_POOL =
    IUpgradeableBurnMintTokenPool_1_4(GhoArbitrum.GHO_CCIP_TOKEN_POOL); // will be updated in address-book after AIP
  // https://arbiscan.io/address/0xB94Ab28c6869466a46a42abA834ca2B3cECCA5eB
  IUpgradeableBurnMintTokenPool_1_5_1 public constant NEW_TOKEN_POOL =
    IUpgradeableBurnMintTokenPool_1_5_1(0xB94Ab28c6869466a46a42abA834ca2B3cECCA5eB);

  // https://arbiscan.io/address/0xcd04d93bea13921dad05240d577090b5ac36dfca
  address public constant EXISTING_GHO_AAVE_STEWARD = 0xCd04D93bEA13921DaD05240D577090b5AC36DfCA;
  // https://arbiscan.io/address/0xd2D586f849620ef042FE3aF52eAa10e9b78bf7De
  address public constant NEW_GHO_AAVE_STEWARD = 0xd2D586f849620ef042FE3aF52eAa10e9b78bf7De;
  // https://arbiscan.io/address/0xa9afaE6A53E90f9E4CE0717162DF5Bc3d9aBe7B2
  IGhoBucketSteward public constant GHO_BUCKET_STEWARD =
    IGhoBucketSteward(0xa9afaE6A53E90f9E4CE0717162DF5Bc3d9aBe7B2);
  // https://arbiscan.io/address/0xCd5ab470AaC5c13e1063ee700503f3346b7C90Db
  address public constant NEW_GHO_CCIP_STEWARD = 0xCd5ab470AaC5c13e1063ee700503f3346b7C90Db;

  // https://etherscan.io/address/0x9Ec9F9804733df96D1641666818eFb5198eC50f0
  address public constant EXISTING_REMOTE_POOL_ETH = 0x9Ec9F9804733df96D1641666818eFb5198eC50f0; // ProxyPool on ETH
  // https://etherscan.io/address/0x06179f7C1be40863405f374E7f5F8806c728660A
  address public constant NEW_REMOTE_POOL_ETH = 0x06179f7C1be40863405f374E7f5F8806c728660A;

  // https://arbiscan.io/address/0xA5Ba213867E175A182a5dd6A9193C6158738105A
  // https://github.com/aave/ccip/commit/ca73ec8c4f7dc0f6a99ae1ea0acde43776c7b9bb
  address public constant EXISTING_TOKEN_POOL_UPGRADE_IMPL =
    0xA5Ba213867E175A182a5dd6A9193C6158738105A;

  // https://arbiscan.io/address/0x7dfF72693f6A4149b17e7C6314655f6A9F7c8B33
  IGhoToken public constant GHO = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING);

  // Token Rate Limit Capacity: 300_000 GHO
  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = 300_000e18;
  // Token Rate Limit Refill Rate: 60 GHO per second (=> 216_000 GHO per hour)
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE = 60e18;

  function execute() external {
    _acceptOwnership();
    _migrateLiquidity();
    _setupAndRegisterNewPool();
    _updateStewards();
  }

  // pre-req - chainlink transfers gho token pool ownership on token admin registry
  function _acceptOwnership() internal {
    EXISTING_PROXY_POOL.acceptOwnership();
    NEW_TOKEN_POOL.acceptOwnership();
    TOKEN_ADMIN_REGISTRY.acceptAdminRole(AaveV3ArbitrumAssets.GHO_UNDERLYING);
  }

  function _migrateLiquidity() internal {
    // bucketLevel === bridgedAmount
    (uint256 bucketCapacity, uint256 bucketLevel) = GHO.getFacilitatorBucket(
      address(EXISTING_TOKEN_POOL)
    );

    GHO.addFacilitator(address(NEW_TOKEN_POOL), 'CCIP TokenPool v1.5.1', uint128(bucketCapacity));
    NEW_TOKEN_POOL.directMint(address(EXISTING_TOKEN_POOL), bucketLevel); // increase facilitator level

    _upgradeExistingTokenPool(); // introduce `directBurn` method
    EXISTING_TOKEN_POOL.directBurn(bucketLevel); // decrease facilitator level

    GHO.removeFacilitator(address(EXISTING_TOKEN_POOL));
  }

  function _setupAndRegisterNewPool() internal {
    IRateLimiter.Config memory rateLimiterConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: CCIP_RATE_LIMIT_CAPACITY,
      rate: CCIP_RATE_LIMIT_REFILL_RATE
    });

    IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[]
      memory chains = new IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[](1);

    bytes[] memory remotePoolAddresses = new bytes[](2);
    remotePoolAddresses[0] = abi.encode(EXISTING_REMOTE_POOL_ETH);
    remotePoolAddresses[1] = abi.encode(NEW_REMOTE_POOL_ETH);

    chains[0] = IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate({
      remoteChainSelector: ETH_CHAIN_SELECTOR,
      remotePoolAddresses: remotePoolAddresses,
      remoteTokenAddress: abi.encode(AaveV3EthereumAssets.GHO_UNDERLYING),
      outboundRateLimiterConfig: rateLimiterConfig,
      inboundRateLimiterConfig: rateLimiterConfig
    });

    // setup new pool
    NEW_TOKEN_POOL.applyChainUpdates({
      remoteChainSelectorsToRemove: new uint64[](0),
      chainsToAdd: chains
    });

    // register new pool
    TOKEN_ADMIN_REGISTRY.setPool(address(GHO), address(NEW_TOKEN_POOL));
  }

  function _updateStewards() internal {
    // Gho Aave Steward
    AaveV3Arbitrum.ACL_MANAGER.revokeRole(
      AaveV3Arbitrum.ACL_MANAGER.RISK_ADMIN_ROLE(),
      EXISTING_GHO_AAVE_STEWARD
    );
    AaveV3Arbitrum.ACL_MANAGER.grantRole(
      AaveV3Arbitrum.ACL_MANAGER.RISK_ADMIN_ROLE(),
      NEW_GHO_AAVE_STEWARD
    );

    // Gho Bucket Steward
    address[] memory facilitatorList = new address[](1);
    facilitatorList[0] = address(EXISTING_TOKEN_POOL);
    GHO_BUCKET_STEWARD.setControlledFacilitator({facilitatorList: facilitatorList, approve: false});
    facilitatorList[0] = address(NEW_TOKEN_POOL);
    GHO_BUCKET_STEWARD.setControlledFacilitator({facilitatorList: facilitatorList, approve: true});

    // Gho Ccip Steward
    NEW_TOKEN_POOL.setRateLimitAdmin(NEW_GHO_CCIP_STEWARD);
  }

  function _upgradeExistingTokenPool() internal {
    ILegacyProxyAdmin(MiscArbitrum.PROXY_ADMIN).upgrade(
      ITransparentUpgradeableProxy(payable(address(EXISTING_TOKEN_POOL))),
      EXISTING_TOKEN_POOL_UPGRADE_IMPL
    );
  }
}
