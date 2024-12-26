// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IUpgradeableLockReleaseTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableLockReleaseTokenPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';

/**
 * @title GHO Base Launch
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-base-set-aci-as-emissions-manager-for-rewards/19338
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x03dc21e0423c60082dc23317af6ebaf997610cbc2cbb0f5a385653bd99a524fe
 */
contract AaveV3Ethereum_GHOBaseLaunch_20241223 is IProposalGenericExecutor {
  uint64 public constant BASE_CHAIN_SELECTOR = 15971525489660198786;

  // https://etherscan.io/address/
  IUpgradeableLockReleaseTokenPool_1_5_1 public immutable TOKEN_POOL;

  // https://basescan.org/address/
  address public immutable REMOTE_TOKEN_POOL_BASE;
  // https://basescan.org/address/0x6F2216CB3Ca97b8756C5fD99bE27986f04CBd81D
  address public constant REMOTE_GHO_TOKEN_BASE = 0x6F2216CB3Ca97b8756C5fD99bE27986f04CBd81D; // predicted

  constructor(address tokenPoolEth, address tokenPoolBase) {
    TOKEN_POOL = IUpgradeableLockReleaseTokenPool_1_5_1(tokenPoolEth);
    REMOTE_TOKEN_POOL_BASE = tokenPoolBase;
  }

  function execute() external {
    IRateLimiter.Config memory emptyRateLimiterConfig = IRateLimiter.Config({
      isEnabled: false,
      capacity: 0,
      rate: 0
    });

    IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate[]
      memory chains = new IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate[](1);

    bytes[] memory remotePoolAddresses = new bytes[](1);
    remotePoolAddresses[0] = abi.encode(REMOTE_TOKEN_POOL_BASE);

    chains[0] = IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate({
      remoteChainSelector: BASE_CHAIN_SELECTOR,
      remotePoolAddresses: remotePoolAddresses,
      remoteTokenAddress: abi.encode(REMOTE_GHO_TOKEN_BASE),
      outboundRateLimiterConfig: emptyRateLimiterConfig,
      inboundRateLimiterConfig: emptyRateLimiterConfig
    });

    TOKEN_POOL.applyChainUpdates(new uint64[](0), chains);
  }
}
