// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
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

  uint128 public constant CCIP_BUCKET_CAPACITY = 20_000_000e18; // 20M GHO

  ITokenAdminRegistry public constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0x6f6C373d09C07425BaAE72317863d7F6bb731e37);

  IUpgradeableBurnMintTokenPool_1_5_1 public immutable TOKEN_POOL;

  // https://basescan.org/address/0x26d595dddbad81bf976ef6f24686a12a800b141f
  address public constant GHO_TOKEN_IMPL = 0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1;
  // predicted address, will be deployed in the AIP
  IGhoToken public constant GHO_TOKEN_PROXY = IGhoToken(0x6F2216CB3Ca97b8756C5fD99bE27986f04CBd81D);

  address public immutable GHO_AAVE_STEWARD;
  address public immutable GHO_BUCKET_STEWARD;
  address public immutable GHO_CCIP_STEWARD;

  address public immutable REMOTE_TOKEN_POOL_ETH;
  address public immutable REMOTE_TOKEN_POOL_ARB;

  constructor(
    address tokenPool,
    address tokenPoolEth,
    address tokenPoolArb,
    address ghoAaveSteward,
    address ghoBucketSteward,
    address ghoCcipSteward
  ) {
    TOKEN_POOL = IUpgradeableBurnMintTokenPool_1_5_1(tokenPool);
    REMOTE_TOKEN_POOL_ETH = tokenPoolEth;
    REMOTE_TOKEN_POOL_ARB = tokenPoolArb;
    GHO_AAVE_STEWARD = ghoAaveSteward;
    GHO_BUCKET_STEWARD = ghoBucketSteward;
    GHO_CCIP_STEWARD = ghoCcipSteward;
  }

  function execute() external {
    _acceptOwnership();

    if (_deployAndInitializeGhoToken() != address(GHO_TOKEN_PROXY)) revert();

    _setupStewardsAndTokenPoolOnGho();

    _setupRemoteTokenPools(); // eth & arb

    TOKEN_ADMIN_REGISTRY.setPool(address(GHO_TOKEN_PROXY), address(TOKEN_POOL));
  }

  function _acceptOwnership() internal {
    TOKEN_ADMIN_REGISTRY.acceptAdminRole(address(GHO_TOKEN_PROXY));
    TOKEN_POOL.acceptOwnership();
  }

  function _deployAndInitializeGhoToken() internal returns (address) {
    return
      address(
        new TransparentUpgradeableProxy{salt: keccak256('based-GHO')}(
          GHO_TOKEN_IMPL,
          ProxyAdmin(MiscBase.PROXY_ADMIN),
          abi.encodeWithSignature('initialize(address)', GovernanceV3Base.EXECUTOR_LVL_1)
        )
      );
  }

  function _setupStewardsAndTokenPoolOnGho() internal {
    GHO_TOKEN_PROXY.grantRole(
      GHO_TOKEN_PROXY.FACILITATOR_MANAGER_ROLE(),
      GovernanceV3Base.EXECUTOR_LVL_1
    );
    GHO_TOKEN_PROXY.grantRole(
      GHO_TOKEN_PROXY.BUCKET_MANAGER_ROLE(),
      GovernanceV3Base.EXECUTOR_LVL_1
    );

    // Token Pool as facilitator with 20M GHO capacity
    GHO_TOKEN_PROXY.addFacilitator(
      address(TOKEN_POOL),
      'CCIP TokenPool v1.5.1',
      CCIP_BUCKET_CAPACITY
    );

    // Gho Aave Steward
    AaveV3Base.ACL_MANAGER.grantRole(AaveV3Base.ACL_MANAGER.RISK_ADMIN_ROLE(), GHO_AAVE_STEWARD);

    // Gho Bucket Steward
    GHO_TOKEN_PROXY.grantRole(GHO_TOKEN_PROXY.BUCKET_MANAGER_ROLE(), GHO_BUCKET_STEWARD);
    address[] memory facilitatorList = new address[](1);
    facilitatorList[0] = address(TOKEN_POOL);
    IGhoBucketSteward(GHO_BUCKET_STEWARD).setControlledFacilitator({
      facilitatorList: facilitatorList,
      approve: true
    });

    // Gho CCIP Steward
    TOKEN_POOL.setRateLimitAdmin(GHO_CCIP_STEWARD);
  }

  function _setupRemoteTokenPools() internal {
    IRateLimiter.Config memory emptyRateLimiterConfig = IRateLimiter.Config({
      isEnabled: false,
      capacity: 0,
      rate: 0
    });

    IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[]
      memory chainsToAdd = new IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[](2);

    {
      bytes[] memory remotePoolAddresses = new bytes[](1);
      remotePoolAddresses[0] = abi.encode(REMOTE_TOKEN_POOL_ETH);
      chainsToAdd[0] = IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate({
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
      chainsToAdd[1] = IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate({
        remoteChainSelector: ARB_CHAIN_SELECTOR,
        remotePoolAddresses: remotePoolAddresses,
        remoteTokenAddress: abi.encode(AaveV3ArbitrumAssets.GHO_UNDERLYING),
        outboundRateLimiterConfig: emptyRateLimiterConfig,
        inboundRateLimiterConfig: emptyRateLimiterConfig
      });
    }

    TOKEN_POOL.applyChainUpdates({
      remoteChainSelectorsToRemove: new uint64[](0),
      chainsToAdd: chainsToAdd
    });
  }
}
