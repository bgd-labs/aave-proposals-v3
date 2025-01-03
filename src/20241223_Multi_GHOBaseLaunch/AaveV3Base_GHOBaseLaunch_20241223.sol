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

  // https://basescan.org/address/0x6f6C373d09C07425BaAE72317863d7F6bb731e37
  ITokenAdminRegistry public constant TOKEN_ADMIN_REGISTRY =
    ITokenAdminRegistry(0x6f6C373d09C07425BaAE72317863d7F6bb731e37);
  // https://basescan.org/address/0xDe6539018B095353A40753Dc54C91C68c9487D4E
  IUpgradeableBurnMintTokenPool_1_5_1 public constant TOKEN_POOL =
    IUpgradeableBurnMintTokenPool_1_5_1(0xDe6539018B095353A40753Dc54C91C68c9487D4E);

  // https://basescan.org/address/0x26d595dddbad81bf976ef6f24686a12a800b141f
  address public constant GHO_TOKEN_IMPL = 0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1;
  // predicted address, will be deployed in the AIP, https://basescan.org/address/0x6F2216CB3Ca97b8756C5fD99bE27986f04CBd81D
  IGhoToken public constant GHO_TOKEN_PROXY = IGhoToken(0x6F2216CB3Ca97b8756C5fD99bE27986f04CBd81D);

  // https://basescan.org/address/0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6
  address public constant GHO_AAVE_STEWARD = 0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6;
  // https://basescan.org/address/0xA5Ba213867E175A182a5dd6A9193C6158738105A
  address public constant GHO_BUCKET_STEWARD = 0xA5Ba213867E175A182a5dd6A9193C6158738105A;
  // https://basescan.org/address/0x2Ce400703dAcc37b7edFA99D228b8E70a4d3831B
  address public constant GHO_CCIP_STEWARD = 0x2Ce400703dAcc37b7edFA99D228b8E70a4d3831B;

  // https://etherscan.io/address/0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6
  address public constant REMOTE_TOKEN_POOL_ETH = 0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6;
  // https://arbiscan.io/address/0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee
  address public constant REMOTE_TOKEN_POOL_ARB = 0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee;

  // Token Rate Limit Capacity: 300_000 GHO
  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = 300_000e18;
  // Token Rate Limit Refill Rate: 60 GHO per second (=> 216_000 GHO per hour)
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE = 60e18;

  function execute() external {
    _acceptOwnership();
    _deployAndInitializeGhoToken();
    _setupStewardsAndTokenPoolOnGho();
    _setupRemoteAndRegisterTokenPool();
  }

  function _acceptOwnership() internal {
    TOKEN_ADMIN_REGISTRY.acceptAdminRole(address(GHO_TOKEN_PROXY));
    TOKEN_POOL.acceptOwnership();
  }

  function _deployAndInitializeGhoToken() internal {
    address ghoTokenProxy = address(
      new TransparentUpgradeableProxy{salt: keccak256('based-GHO')}(
        GHO_TOKEN_IMPL,
        ProxyAdmin(MiscBase.PROXY_ADMIN),
        abi.encodeCall(IGhoToken.initialize, (GovernanceV3Base.EXECUTOR_LVL_1))
      )
    );
    // burn all gas, assert predicted address match
    assert(ghoTokenProxy == address(GHO_TOKEN_PROXY));
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

  function _setupRemoteAndRegisterTokenPool() internal {
    IRateLimiter.Config memory rateLimiterConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: CCIP_RATE_LIMIT_CAPACITY,
      rate: CCIP_RATE_LIMIT_REFILL_RATE
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

    // setup remote token pools
    TOKEN_POOL.applyChainUpdates({
      remoteChainSelectorsToRemove: new uint64[](0),
      chainsToAdd: chainsToAdd
    });

    // register token pool
    TOKEN_ADMIN_REGISTRY.setPool(address(GHO_TOKEN_PROXY), address(TOKEN_POOL));
  }
}
