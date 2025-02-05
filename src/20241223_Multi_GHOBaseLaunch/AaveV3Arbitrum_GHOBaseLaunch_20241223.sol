// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {ILegacyProxyAdmin, ITransparentUpgradeableProxy} from 'src/interfaces/ILegacyProxyAdmin.sol';

import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';

/**
 * @title GHO Base Launch
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-base-set-aci-as-emissions-manager-for-rewards/19338
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x03dc21e0423c60082dc23317af6ebaf997610cbc2cbb0f5a385653bd99a524fe
 */
contract AaveV3Arbitrum_GHOBaseLaunch_20241223 is IProposalGenericExecutor {
  uint64 public constant BASE_CHAIN_SELECTOR = 15971525489660198786;

  // https://arbiscan.io/address/0xB94Ab28c6869466a46a42abA834ca2B3cECCA5eB
  IUpgradeableBurnMintTokenPool_1_5_1 public constant TOKEN_POOL =
    IUpgradeableBurnMintTokenPool_1_5_1(GhoArbitrum.GHO_CCIP_TOKEN_POOL);

  // https://arbiscan.io/address/0x9f0e4F4c5664888442E459f40f635765BB6265Ec
  address public constant NEW_GHO_TOKEN_PROXY_ADMIN = 0x9f0e4F4c5664888442E459f40f635765BB6265Ec;

  // https://basescan.org/address/0x98217A06721Ebf727f2C8d9aD7718ec28b7aAe34
  address public constant REMOTE_TOKEN_POOL_BASE = 0x98217A06721Ebf727f2C8d9aD7718ec28b7aAe34;
  // https://basescan.org/address/0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee
  address public constant REMOTE_GHO_TOKEN_BASE = 0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee;

  // Token Rate Limit Capacity: 300_000 GHO
  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = 300_000e18;
  // Token Rate Limit Refill Rate: 60 GHO per second (=> 216_000 GHO per hour)
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE = 60e18;

  function execute() external {
    // Update ProxyAdmin on GHO
    ILegacyProxyAdmin(MiscArbitrum.PROXY_ADMIN).changeProxyAdmin(
      ITransparentUpgradeableProxy(AaveV3ArbitrumAssets.GHO_UNDERLYING),
      NEW_GHO_TOKEN_PROXY_ADMIN
    );

    IRateLimiter.Config memory rateLimiterConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: CCIP_RATE_LIMIT_CAPACITY,
      rate: CCIP_RATE_LIMIT_REFILL_RATE
    });

    IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[]
      memory chainsToAdd = new IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[](1);

    bytes[] memory remotePoolAddresses = new bytes[](1);
    remotePoolAddresses[0] = abi.encode(REMOTE_TOKEN_POOL_BASE);

    chainsToAdd[0] = IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate({
      remoteChainSelector: BASE_CHAIN_SELECTOR,
      remotePoolAddresses: remotePoolAddresses,
      remoteTokenAddress: abi.encode(REMOTE_GHO_TOKEN_BASE),
      outboundRateLimiterConfig: rateLimiterConfig,
      inboundRateLimiterConfig: rateLimiterConfig
    });

    TOKEN_POOL.applyChainUpdates({
      remoteChainSelectorsToRemove: new uint64[](0),
      chainsToAdd: chainsToAdd
    });
  }
}
