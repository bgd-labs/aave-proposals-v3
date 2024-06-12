// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
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
  address public immutable CCIP_TOKEN_POOL;
  address public immutable CCIP_TOKEN_POOL_IMPLE;
  address public constant CCIP_ARM_PROXY = 0x411dE17f12D1A34ecC7F45f49844626267c75e81;
  address public constant CCIP_ROUTER = 0x80226fc0Ee2b096224EeAc085Bb9a8cba1146f7D;
  uint256 public constant CCIP_BRIDGE_LIMIT = 1_000_000e18; // 1M
  uint64 public constant CCIP_ARB_CHAIN_SELECTOR = 4949039107694359620;

  constructor() {
    // Predict CCIP TokenPool contract address
    CCIP_TOKEN_POOL_IMPLE = GovV3Helpers.predictDeterministicAddress(
      _getCcipTokenPoolImpleCreationCode()
    );
    CCIP_TOKEN_POOL = GovV3Helpers.predictDeterministicAddress(
      _getCcipTokenPoolProxyCreationCode(CCIP_TOKEN_POOL_IMPLE)
    );
  }

  function execute() external {
    // 1. Deploy LockReleaseTokenPool
    (address tokenPoolImple, address tokenPool) = _deployCcipTokenPool();
    require(CCIP_TOKEN_POOL_IMPLE == tokenPoolImple, 'UNEXPECTED_CCIP_TOKEN_POOL_IMPLE_ADDRESS');
    require(CCIP_TOKEN_POOL == tokenPool, 'UNEXPECTED_CCIP_TOKEN_POOL_ADDRESS');

    // 2. Accept TokenPool ownership
    UpgradeableLockReleaseTokenPool(CCIP_TOKEN_POOL).acceptOwnership();

    // 3. Configure CCIP
    _configureCcipTokenPool();
  }

  function _deployCcipTokenPool() internal returns (address imple, address proxy) {
    imple = GovV3Helpers.deployDeterministic(_getCcipTokenPoolImpleCreationCode());
    proxy = GovV3Helpers.deployDeterministic(_getCcipTokenPoolProxyCreationCode(imple));
  }

  function _getCcipTokenPoolImpleCreationCode() internal pure returns (bytes memory) {
    return
      abi.encodePacked(
        type(UpgradeableLockReleaseTokenPool).creationCode,
        abi.encode(
          MiscEthereum.GHO_TOKEN, // token
          CCIP_ARM_PROXY, // armProxy
          false, // allowlistEnabled
          true // acceptLiquidity
        )
      );
  }

  function _getCcipTokenPoolProxyCreationCode(address imple) internal pure returns (bytes memory) {
    bytes memory tokenPoolInitParams = abi.encodeWithSignature(
      'initialize(address,address[],address,uint256)',
      GovernanceV3Ethereum.EXECUTOR_LVL_1, // owner
      new address[](0), // allowList
      CCIP_ROUTER, // router
      CCIP_BRIDGE_LIMIT // bridgeLimit
    );
    return
      abi.encodePacked(
        type(TransparentUpgradeableProxy).creationCode,
        abi.encode(
          imple, // logic
          MiscEthereum.PROXY_ADMIN, // proxy admin
          tokenPoolInitParams // data
        )
      );
  }

  function _configureCcipTokenPool() internal {
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
    UpgradeableLockReleaseTokenPool(CCIP_TOKEN_POOL).applyChainUpdates(chainUpdates);
  }
}
