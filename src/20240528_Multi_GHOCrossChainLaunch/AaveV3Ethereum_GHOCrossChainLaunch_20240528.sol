// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {UpgradeableLockReleaseTokenPool} from 'ccip/v0.8/ccip/pools/GHO/UpgradeableLockReleaseTokenPool.sol';
import {UpgradeableTokenPool} from 'ccip/v0.8/ccip/pools/GHO/UpgradeableTokenPool.sol';
import {RateLimiter} from 'ccip/v0.8/ccip/libraries/RateLimiter.sol';

/**
 * @title GHO Cross-Chain Launch
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x2a6ffbcff41a5ef98b7542f99b207af9c1e79e61f859d0a62f3bf52d3280877a
 * - Discussion: https://governance.aave.com/t/arfc-gho-cross-chain-launch/17616
 * @dev This payload consists of the following set of actions:
 * 1. Deploy LockReleaseTokenPool
 * 2. Accept ownership of CCIP TokenPool
 * 3. Configure CCIP TokenPool
 */
contract AaveV3Ethereum_GHOCrossChainLaunch_20240528 is IProposalGenericExecutor {
  address public constant CCIP_ARM_PROXY = 0x411dE17f12D1A34ecC7F45f49844626267c75e81;
  address public constant CCIP_ROUTER = 0x80226fc0Ee2b096224EeAc085Bb9a8cba1146f7D;
  uint256 public constant CCIP_BRIDGE_LIMIT = 1_000_000e18; // 1M
  uint64 public constant CCIP_ARB_CHAIN_SELECTOR = 4949039107694359620;

  function execute() external {
    // 1. Deploy LockReleaseTokenPool
    address tokenPool = _deployCcipTokenPool();

    // 2. Accept TokenPool ownership
    UpgradeableLockReleaseTokenPool(tokenPool).acceptOwnership();

    // 3. Configure CCIP
    _configureCcipTokenPool(tokenPool);
  }

  function _deployCcipTokenPool() internal returns (address) {
    address imple = address(
      new UpgradeableLockReleaseTokenPool(MiscEthereum.GHO_TOKEN, CCIP_ARM_PROXY, false, true)
    );

    bytes memory tokenPoolInitParams = abi.encodeWithSignature(
      'initialize(address,address[],address,uint256)',
      GovernanceV3Ethereum.EXECUTOR_LVL_1, // owner
      new address[](0), // allowList
      CCIP_ROUTER, // router
      CCIP_BRIDGE_LIMIT // bridgeLimit
    );
    return
      address(
        new TransparentUpgradeableProxy(imple, MiscEthereum.PROXY_ADMIN, tokenPoolInitParams)
      );
  }

  function _configureCcipTokenPool(address tokenPool) internal {
    UpgradeableTokenPool.ChainUpdate[] memory chainUpdates = new UpgradeableTokenPool.ChainUpdate[](
      1
    );
    RateLimiter.Config memory rateConfig = RateLimiter.Config({
      isEnabled: false,
      capacity: 0,
      rate: 0
    });
    chainUpdates[0] = UpgradeableTokenPool.ChainUpdate({
      remoteChainSelector: CCIP_ARB_CHAIN_SELECTOR,
      allowed: true,
      outboundRateLimiterConfig: rateConfig,
      inboundRateLimiterConfig: rateConfig
    });
    UpgradeableLockReleaseTokenPool(tokenPool).applyChainUpdates(chainUpdates);
  }
}
