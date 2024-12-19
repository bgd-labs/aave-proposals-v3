// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {RateLimiter} from 'ccip/libraries/RateLimiter.sol';
import {IUpgradeableTokenPool} from 'src/interfaces/ccip/IUpgradeableTokenPool.sol';

/**
 * @title GHO Avax Launch
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x2aed7eb8b03cb3f961cbf790bf2e2e1e449f841a4ad8bdbcdd223bb6ac69e719
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-avalanche-set-aci-as-emissions-manager-for-rewards/19339
 * @dev This payload configures the CCIP TokenPool for Avalanche
 */
contract AaveV3Ethereum_GHOAvaxLaunch_20241106 is IProposalGenericExecutor {
  address public constant CCIP_TOKEN_POOL = MiscEthereum.GHO_CCIP_TOKEN_POOL;
  uint64 public constant CCIP_AVAX_CHAIN_SELECTOR = 6433500567565415381;

  function execute() external {
    _configureCcipTokenPool(CCIP_TOKEN_POOL, CCIP_AVAX_CHAIN_SELECTOR);
  }

  function _configureCcipTokenPool(address tokenPool, uint64 chainSelector) internal {
    IUpgradeableTokenPool.ChainUpdate[]
      memory chainUpdates = new IUpgradeableTokenPool.ChainUpdate[](1);
    RateLimiter.Config memory rateConfig = RateLimiter.Config({
      isEnabled: false,
      capacity: 0,
      rate: 0
    });
    chainUpdates[0] = IUpgradeableTokenPool.ChainUpdate({
      remoteChainSelector: chainSelector,
      allowed: true,
      outboundRateLimiterConfig: rateConfig,
      inboundRateLimiterConfig: rateConfig
    });
    IUpgradeableTokenPool(tokenPool).applyChainUpdates(chainUpdates);
  }
}
