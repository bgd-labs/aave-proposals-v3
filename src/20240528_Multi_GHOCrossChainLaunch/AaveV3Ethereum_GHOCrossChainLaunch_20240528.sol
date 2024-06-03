// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ITransparentProxyFactory} from 'solidity-utils/contracts/transparent-proxy/interfaces/ITransparentProxyFactory.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {UpgradeableLockReleaseTokenPool} from 'ccip/v0.8/ccip/pools/GHO/UpgradeableLockReleaseTokenPool.sol';
import {UpgradeableTokenPool} from 'ccip/v0.8/ccip/pools/GHO/UpgradeableTokenPool.sol';
import {RateLimiter} from 'ccip/v0.8/ccip/libraries/RateLimiter.sol';

/**
 * @title Factory for deploying contracts to deterministic addresses via Create3
 * @author BGD Labs
 * @notice Defines the methods implemented on Create3Factory contract
 */
interface ICreate3Factory {
  /**
   * @notice Deploys a contract using Create3
   * @dev The provided salt is hashed together with msg.sender to generate the final salt
   * @param salt The deployer-specific salt for determining the deployed contract's address
   * @param creationCode The creation code of the contract to deploy
   * @return The address of the deployed contract
   */
  function create(bytes32 salt, bytes memory creationCode) external payable returns (address);

  /**
   * @notice Predicts the address of a deployed contract
   * @dev The provided salt is hashed together with the deployer address to generate the final salt
   * @param deployer The deployer account that will call deploy()
   * @param salt The deployer-specific salt for determining the deployed contract's address
   * @return The address of the contract that will be deployed
   */
  function predictAddress(address deployer, bytes32 salt) external view returns (address);
}

/**
 * @title GHO Cross-Chain Launch
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x2a6ffbcff41a5ef98b7542f99b207af9c1e79e61f859d0a62f3bf52d3280877a
 * - Discussion: https://governance.aave.com/t/arfc-gho-cross-chain-launch/17616
 */
contract AaveV3Ethereum_GHOCrossChainLaunch_20240528 is IProposalGenericExecutor {
  address public immutable CCIP_TOKEN_POOL;
  address public immutable CCIP_TOKEN_POOL_IMPL;
  bytes32 public constant CCIP_TOKEN_POOL_IMPL_DEPLOY_SALT =
    bytes32(uint256(keccak256('gho.ccip.impl')));
  bytes32 public constant CCIP_TOKEN_POOL_DEPLOY_SALT = bytes32(uint256(keccak256('gho.ccip')));
  address public constant CCIP_ARM_PROXY = 0x411dE17f12D1A34ecC7F45f49844626267c75e81;
  address public constant CCIP_ROUTER = 0x80226fc0Ee2b096224EeAc085Bb9a8cba1146f7D;
  uint256 public constant CCIP_BRIDGE_LIMIT = 1_000_000e18; // 1M
  uint64 public constant CCIP_ARB_CHAIN_SELECTOR = 4949039107694359620;

  constructor() {
    // Predict CCIP TokenPool contract address
    CCIP_TOKEN_POOL_IMPL = ICreate3Factory(MiscEthereum.CREATE_3_FACTORY).predictAddress(
      GovernanceV3Ethereum.EXECUTOR_LVL_1,
      CCIP_TOKEN_POOL_IMPL_DEPLOY_SALT
    );
    CCIP_TOKEN_POOL = ICreate3Factory(MiscEthereum.CREATE_3_FACTORY).predictAddress(
      GovernanceV3Ethereum.EXECUTOR_LVL_1,
      CCIP_TOKEN_POOL_DEPLOY_SALT
    );
  }

  function execute() external {
    // 1. Deploy LockReleaseTokenPool
    address tokenPool = _deployCcipTokenPool();
    // 2. Accept TokenPool ownership
    UpgradeableLockReleaseTokenPool(tokenPool).acceptOwnership();
    // 3. Configure CCIP
    _configureCcipTokenPool(tokenPool);
  }

  function _deployCcipTokenPool() internal returns (address) {
    // Deploy imple
    bytes memory implCreationCode = abi.encodePacked(
      type(UpgradeableLockReleaseTokenPool).creationCode,
      abi.encode(
        MiscEthereum.GHO_TOKEN, // token
        CCIP_ARM_PROXY, // armProxy
        false, // allowlistEnabled
        true // acceptLiquidity
      )
    );
    address tokenPoolImpl = ICreate3Factory(MiscEthereum.CREATE_3_FACTORY).create(
      CCIP_TOKEN_POOL_IMPL_DEPLOY_SALT,
      implCreationCode
    );
    require(CCIP_TOKEN_POOL_IMPL == tokenPoolImpl, 'UNEXPECTED_CCIP_TOKEN_POOL_IMPL_ADDRESS');

    // Deploy Proxy and init
    address[] memory emptyArray = new address[](0);
    bytes memory tokenPoolInitParams = abi.encodeWithSignature(
      'initialize(address,address[],address,uint256)',
      GovernanceV3Ethereum.EXECUTOR_LVL_1, // owner
      emptyArray, // allowList
      CCIP_ROUTER, // router
      CCIP_BRIDGE_LIMIT // bridgeLimit
    );
    bytes memory creationCode = abi.encodePacked(
      type(TransparentUpgradeableProxy).creationCode,
      abi.encode(
        tokenPoolImpl, // logic
        MiscEthereum.PROXY_ADMIN, // proxy admin
        tokenPoolInitParams // data
      )
    );
    return
      ICreate3Factory(MiscEthereum.CREATE_3_FACTORY).create(
        CCIP_TOKEN_POOL_DEPLOY_SALT,
        creationCode
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
