// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';

import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title GHO Base Launch
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-base-set-aci-as-emissions-manager-for-rewards/19338
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x03dc21e0423c60082dc23317af6ebaf997610cbc2cbb0f5a385653bd99a524fe
 */
contract AaveV3Base_GHOBaseLaunch_20241223 is IProposalGenericExecutor {
  uint64 public constant ETH_CHAIN_SELECTOR = 5009297550715157269;
  uint64 public constant ARB_CHAIN_SELECTOR = 4949039107694359620;

  uint128 public constant CCIP_BUCKET_CAPACITY = 25_000_000e18; // 25M GHO

  ITokenAdminRegistry public constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0x6f6C373d09C07425BaAE72317863d7F6bb731e37);

  IUpgradeableBurnMintTokenPool_1_5_1 public immutable TOKEN_POOL;

  address public immutable GHO_TOKEN_IMPL;
  address public immutable GHO_CCIP_STEWARD;

  address public immutable REMOTE_TOKEN_POOL_ETH;
  address public immutable REMOTE_TOKEN_POOL_ARB;

  constructor(
    address tokenPool,
    address ghoTokenImpl,
    address ghoCcipSteward,
    address tokenPoolEth,
    address tokenPoolArb
  ) {
    TOKEN_POOL = IUpgradeableBurnMintTokenPool_1_5_1(tokenPool);
    GHO_TOKEN_IMPL = ghoTokenImpl;
    GHO_CCIP_STEWARD = ghoCcipSteward;
    REMOTE_TOKEN_POOL_ETH = tokenPoolEth;
    REMOTE_TOKEN_POOL_ARB = tokenPoolArb;
  }

  function execute() external {
    IGhoToken GHO_TOKEN = _deployAndInitializeGhoToken();

    GHO_TOKEN.grantRole(GHO_TOKEN.FACILITATOR_MANAGER_ROLE(), GovernanceV3Base.EXECUTOR_LVL_1);
    GHO_TOKEN.grantRole(GHO_TOKEN.BUCKET_MANAGER_ROLE(), GovernanceV3Base.EXECUTOR_LVL_1);
    GHO_TOKEN.addFacilitator(address(TOKEN_POOL), 'CCIP TokenPool v1.5.1', CCIP_BUCKET_CAPACITY);

    TOKEN_ADMIN_REGISTRY.acceptAdminRole(address(GHO_TOKEN));
    TOKEN_POOL.acceptOwnership();

    _setupRemoteTokenPools();

    TOKEN_ADMIN_REGISTRY.setPool(address(GHO_TOKEN), address(TOKEN_POOL));
  }

  function _deployAndInitializeGhoToken() internal returns (IGhoToken) {
    TransparentUpgradeableProxy tokenProxy = new TransparentUpgradeableProxy(
      GHO_TOKEN_IMPL,
      MiscBase.PROXY_ADMIN,
      abi.encodeWithSignature('initialize(address)', GovernanceV3Base.EXECUTOR_LVL_1)
    );
    return IGhoToken(address(tokenProxy));
  }

  function _setupRemoteTokenPools() internal {
    IRateLimiter.Config memory emptyRateLimiterConfig = IRateLimiter.Config({
      isEnabled: false,
      capacity: 0,
      rate: 0
    });

    IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[]
      memory chains = new IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[](2);

    {
      bytes[] memory remotePoolAddresses = new bytes[](1);
      remotePoolAddresses[0] = abi.encode(REMOTE_TOKEN_POOL_ETH);
      chains[0] = IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate({
        remoteChainSelector: ETH_CHAIN_SELECTOR,
        remotePoolAddresses: remotePoolAddresses,
        remoteTokenAddress: abi.encode(AaveV3EthereumAssets.GHO_UNDERLYING),
        outboundRateLimiterConfig: emptyRateLimiterConfig,
        inboundRateLimiterConfig: emptyRateLimiterConfig
      });
    }

    {
      bytes[] memory remotePoolAddresses = new bytes[](1);
      remotePoolAddresses[0] = abi.encode(REMOTE_TOKEN_POOL_ARB);
      chains[1] = IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate({
        remoteChainSelector: ARB_CHAIN_SELECTOR,
        remotePoolAddresses: remotePoolAddresses,
        remoteTokenAddress: abi.encode(AaveV3ArbitrumAssets.GHO_UNDERLYING),
        outboundRateLimiterConfig: emptyRateLimiterConfig,
        inboundRateLimiterConfig: emptyRateLimiterConfig
      });
    }

    TOKEN_POOL.applyChainUpdates({
      remoteChainSelectorsToRemove: new uint64[](0),
      chainsToAdd: chains
    });
  }
}
